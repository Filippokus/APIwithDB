from sqlalchemy import Column, Integer, String, Float, ForeignKey, UniqueConstraint, MetaData
from sqlalchemy.orm import relationship
from app.database import Base

metadata = MetaData(schema='petsitters')

class GameQuestion(Base):
    __tablename__ = 'gamequestion'
    __table_args__ = {'schema': 'petsitters'}

    questionid = Column(Integer, primary_key=True, autoincrement=True, index=True)
    questiontext = Column(String, index=True)

    answers = relationship("GameAnswer", back_populates="question")
    user_answers = relationship("UserAnswer", back_populates="question")

class GameAnswer(Base):
    __tablename__ = 'gameanswer'
    __table_args__ = (
        UniqueConstraint('answerid', 'questionid', name='unique_answer_question'),
        {'schema': 'petsitters'}
    )

    answerid = Column(Integer, primary_key=True, autoincrement=True, index=True)
    questionid = Column(Integer, ForeignKey('petsitters.gamequestion.questionid'), index=True)
    answertext = Column(String, index=True)
    score = Column(Float, index=True)

    question = relationship("GameQuestion", back_populates="answers")

class User(Base):
    __tablename__ = 'user'
    __table_args__ = (
        UniqueConstraint('email', name='unique_email'),
        {'schema': 'petsitters'}
    )

    userid = Column(Integer, primary_key=True, autoincrement=True, index=True)
    fullname = Column(String, index=True)
    phone = Column(String, index=True)
    email = Column(String, index=True, unique=True)
    profession = Column(String, index=True)
    currentgamequestionid = Column(Integer, index=True)
    
    answers = relationship("UserAnswer", back_populates="user")

class UserAnswer(Base):
    __tablename__ = 'useranswer'
    __table_args__ = (
        UniqueConstraint('userid', 'questionid', name='unique_user_question'),
        {'schema': 'petsitters'}
    )

    userid = Column(Integer, ForeignKey('petsitters.user.userid'), primary_key=True, index=True)
    questionid = Column(Integer, ForeignKey('petsitters.gamequestion.questionid'), primary_key=True, index=True)
    answertext = Column(String, index=True)
    score = Column(Float, index=True)

    user = relationship("User", back_populates="answers")
    question = relationship("GameQuestion", back_populates="user_answers")
