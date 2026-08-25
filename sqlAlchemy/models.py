from sqlalchemy import Column, Integer, String, Float, Date, DateTime, UniqueConstraint, Index, ForeignKeyConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from datetime import datetime

Base = declarative_base()

class StockInfo(Base):
    __tablename__ = 'stock_info'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    ts_code = Column(String(20), nullable=False, unique=True, comment='股票代码')
    name = Column(String(50), nullable=False, comment='股票名称')
    area = Column(String(50), comment='所属地区')
    industry = Column(String(50), comment='所属行业')
    list_date = Column(Date, comment='上市日期')
    
    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    
    # 关联关系：一只股票有多条价格记录
    price_records = relationship("StockPrice", back_populates="stock_info")
    
    __table_args__ = (
        Index('idx_ts_code', 'ts_code'),
        Index('idx_area', 'area'),
        Index('idx_industry', 'industry'),
    )


class StockPrice(Base):
    __tablename__ = 'stock_prices'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    trade_date = Column(Date, nullable=False)
    stock_code = Column(String(20), nullable=False)  # 使用 ts_code 格式
    open_price = Column(Float)
    high_price = Column(Float)
    low_price = Column(Float)
    close_price = Column(Float)
    volume = Column(Float)
    
    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    
    # 关联关系：多条价格记录对应一只股票
    stock_info = relationship("StockInfo", back_populates="price_records")
    
    __table_args__ = (
        UniqueConstraint('trade_date', 'stock_code', name='uq_date_stock'),
        Index('idx_trade_date', 'trade_date'),
        Index('idx_stock_code', 'stock_code'),
        Index('idx_date_code', 'trade_date', 'stock_code'),
        # 外键约束（可选）
        ForeignKeyConstraint(['stock_code'], ['stock_info.ts_code']),
    )
