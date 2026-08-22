from sqlalchemy import create_engine, Column, Integer, String, Float, Date, DateTime, UniqueConstraint
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime


Base = declarative_base()

class StockPrice(Base):
    __tablename__ = 'stock_prices'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    trade_date = Column(Date, nullable=False)  # 交易日期
    stock_code = Column(String(20), nullable=False)  # 股票代码
    open_price = Column(Float)  # 开盘价
    high_price = Column(Float)  # 最高价
    low_price = Column(Float)  # 最低价
    close_price = Column(Float)  # 收盘价
    volume = Column(Float)  # 成交量
    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    
    # 联合唯一索引，防止重复插入
    __table_args__ = (
        UniqueConstraint('trade_date', 'stock_code', name='uq_date_stock'),
    )
