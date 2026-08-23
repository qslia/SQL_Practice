import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from datetime import datetime
from models import StockPrice, Base
import os
import logging
from pathlib import Path

# 配置日志
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class StockDataImporter:
    def __init__(self, db_url, batch_size=1000):
        """
        初始化导入器
        :param db_url: 数据库连接URL，如 mysql+pymysql://user:pass@host:port/db
        :param batch_size: 批量插入大小
        """
        self.engine = create_engine(
            db_url,
            pool_size=10,
            max_overflow=20,
            pool_pre_ping=True
        )
        self.Session = sessionmaker(bind=self.engine)
        self.batch_size = batch_size
        
        # 创建表
        Base.metadata.create_all(self.engine)
    
    def parse_csv(self, file_path):
        """
        解析CSV文件
        根据实际CSV格式调整列名映射
        """
        try:
            # 读取CSV，假设第一行为表头
            df = pd.read_csv(file_path, encoding='utf-8')  # 或 'utf-8'
            
            # 从文件名提取日期
            file_name = Path(file_path).stem  # 20260616
            trade_date = datetime.strptime(file_name, '%Y%m%d').date()
            
            # 标准化列名（根据实际CSV列名调整）
            # 示例映射，需要根据实际CSV列名修改
            column_mapping = {
                'ts_code': 'stock_code',
                'open': 'open_price',
                'high': 'high_price',
                'low': 'low_price',
                'close': 'close_price',
                'vol': 'volume',
            }
            
            df = df.rename(columns=column_mapping)
            
            # 添加交易日期
            df['trade_date'] = trade_date
            
            # 处理缺失值
            df = df.fillna(0)
            
            # 只选择需要的列
            required_columns = ['trade_date', 'stock_code', 
                              'open_price', 'high_price', 'low_price', 
                              'close_price', 'volume']
            
            # 只保留存在的列
            existing_columns = [col for col in required_columns if col in df.columns]
            df = df[existing_columns]
            
            # 转换数据类型
            numeric_columns = ['open_price', 'high_price', 'low_price', 
                             'close_price', 'volume']
            for col in numeric_columns:
                if col in df.columns:
                    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)
            
            logger.info(f"成功解析文件 {file_path}，共 {len(df)} 条记录")
            return df
            
        except Exception as e:
            logger.error(f"解析文件 {file_path} 失败: {e}")
            raise
    
    def import_data(self, file_path, skip_existing=True):
        """
        导入数据到数据库
        :param file_path: CSV文件路径
        :param skip_existing: 是否跳过已存在的记录
        """
        # 解析CSV
        df = self.parse_csv(file_path)
        
        if df.empty:
            logger.warning(f"文件 {file_path} 无数据")
            return 0
        
        # 转换为字典列表
        records = df.to_dict('records')
        
        session = self.Session()
        try:
            imported_count = 0
            skipped_count = 0
            
            # 批量插入
            for i in range(0, len(records), self.batch_size):
                batch = records[i:i + self.batch_size]
                
                for record in batch:
                    try:
                        # 检查是否已存在
                        if skip_existing:
                            exists = session.query(StockPrice).filter(
                                StockPrice.trade_date == record['trade_date'],
                                StockPrice.stock_code == record['stock_code']
                            ).first()
                            
                            if exists:
                                skipped_count += 1
                                continue
                        
                        # 创建新记录
                        stock_price = StockPrice(**record)
                        session.add(stock_price)
                        imported_count += 1
                        
                    except Exception as e:
                        logger.error(f"插入记录失败: {record}, 错误: {e}")
                        session.rollback()
                        continue
                
                # 提交批次
                try:
                    session.commit()
                    logger.info(f"已导入 {imported_count} 条记录，跳过 {skipped_count} 条")
                except Exception as e:
                    session.rollback()
                    logger.error(f"批次提交失败: {e}")
                    continue
            
            logger.info(f"导入完成！共导入 {imported_count} 条记录，跳过 {skipped_count} 条")
            return imported_count
            
        except Exception as e:
            session.rollback()
            logger.error(f"导入失败: {e}")
            raise
        finally:
            session.close()
    
    def import_multiple_files(self, file_pattern, skip_existing=True):
        """
        批量导入多个文件
        :param file_pattern: 文件路径模式，如 '/data/2026*.csv'
        :param skip_existing: 是否跳过已存在的记录
        """
        import glob
        # 清理所有连接
        self.engine.dispose()  # 关闭池中所有连接
        # 或者重置池
        self.engine.pool.reset()
        
        files = sorted(glob.glob(file_pattern))
        total_imported = 0
        
        for file_path in files:
            logger.info(f"开始导入文件: {file_path}")
            try:
                count = self.import_data(file_path, skip_existing)
                total_imported += count
            except Exception as e:
                logger.error(f"导入文件 {file_path} 失败: {e}")
                continue
        
        logger.info(f"所有文件导入完成，共导入 {total_imported} 条记录")
        return total_imported

# 使用示例
if __name__ == "__main__":
    db_url = os.getenv("DATABASE_URL")
    print(db_url)
    engine = create_engine(db_url)
    
    # 创建导入器
    importer = StockDataImporter(db_url, batch_size=2000)
    
    # 导入单个文件
    # importer.import_data(r'sqlAlchemy\data\20260428.csv')
    
    # 或者批量导入
    importer.import_multiple_files(r'sqlAlchemy\data\2026*.csv')