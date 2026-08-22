from model import User, engine
from sqlalchemy.orm import sessionmaker

Session = sessionmaker(bind=engine)
session = Session()

user = User(name="John Doe", age=30)
session.add(user)
session.commit()

