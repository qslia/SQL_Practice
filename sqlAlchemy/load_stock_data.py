import os
from sqlalchemy.orm import joinedload
from sqlalchemy import create_engine
from models import StockInfo, StockPrice, Base
from sqlalchemy.orm import sessionmaker

db_url = os.getenv("DATABASE_URL")
engine = create_engine(db_url)
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
session = Session()

results = session.query(StockInfo, StockPrice).join(
    StockPrice, StockInfo.ts_code == StockPrice.stock_code
).filter(
    StockPrice.stock_code == '000002.SZ',
    StockPrice.trade_date.between('20260814', '20260824')
).order_by(StockPrice.trade_date).all()

# 遍历结果
for info, price in results:
    line = (
        f"{info.ts_code} | {info.name} | {price.trade_date} | "
        f"{price.close_price} | {info.area} | {info.industry} | "
        f"{info.list_date}"
    )
    print(line)