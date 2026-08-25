import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import StockInfo, Base
from datetime import datetime
# 数据库连接
db_url = os.getenv("DATABASE_URL")
engine = create_engine(db_url)

# 创建所有表
Base.metadata.create_all(engine)

# 创建Session
Session = sessionmaker(bind=engine)
session = Session()

# # 插入股票基本信息
# stock = StockInfo(
#     ts_code='000001.SZ',
#     name='平安银行',
#     area='广东',
#     industry='银行',
#     list_date=datetime.strptime('1991-04-03', '%Y-%m-%d').date()
# )
# session.add(stock)
# session.commit()

# 批量插入
# stocks_data = [
#     {'ts_code': '000001.SZ', 'name': '平安银行', 'area': '广东', 'industry': '银行', 
#      'list_date': '1991-04-03'},
#     {'ts_code': '000002.SZ', 'name': '万科A', 'area': '广东', 'industry': '房地产',
#      'list_date': '1991-01-29'},
#     {'ts_code': '000003.SZ', 'name': 'PT金田A', 'area': '广东', 'industry': '综合',
#      'list_date': '1991-07-03'},
# ]

# for data in stocks_data:
#     data['list_date'] = datetime.strptime(data['list_date'], '%Y-%m-%d').date()
#     stock = StockInfo(**data)
#     session.add(stock)

# session.commit()

# 方法1：使用 to_dict('records') 批量转换（推荐）
df = pd.read_csv('sqlAlchemy/info_filtered_tushare.csv')
exclude = ['Unnamed: 0', 'symbol']
df = df[[col for col in df.columns if col not in exclude]]

# 转换日期格式（如果有日期列）
df['list_date'] = pd.to_datetime(df['list_date'], format='%Y%m%d').dt.date
    

# 批量创建对象并插入
stocks = []
for _, row in df.iterrows():
    stocks.append(StockInfo(**row.to_dict()))

session.add_all(stocks)
session.commit()

