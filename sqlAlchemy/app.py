import os
from sqlalchemy import create_engine, Column, String, Integer
from sqlalchemy.orm import declarative_base

db_url = os.getenv("DATABASE_URL", "mysql+pymysql://root:123@localhost:3306/sqlAlchemyPracticeDb")
engine = create_engine(db_url)
Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    name = Column(String(50))
    age = Column(Integer)
    
Base.metadata.create_all(engine)
