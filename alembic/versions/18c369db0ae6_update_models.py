"""update models

Revision ID: 18c369db0ae6
Revises: 5420975bfce7
Create Date: 2024-06-05 17:55:21.678116

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '18c369db0ae6'
down_revision: Union[str, None] = '5420975bfce7'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    bind = op.get_bind()
    insp = sa.engine.reflection.Inspector.from_engine(bind)

    if 'gamequestion' not in insp.get_table_names(schema='petsitters'):
        op.create_table(
            'gamequestion',
            sa.Column('questionid', sa.Integer, primary_key=True, autoincrement=True, index=True),
            sa.Column('questiontext', sa.String, index=True),
            schema='petsitters'
        )

    if 'gameanswer' not in insp.get_table_names(schema='petsitters'):
        op.create_table(
            'gameanswer',
            sa.Column('answerid', sa.Integer, primary_key=True, autoincrement=True, index=True),
            sa.Column('questionid', sa.Integer, sa.ForeignKey('petsitters.gamequestion.questionid'), index=True),
            sa.Column('answertext', sa.String, index=True),
            sa.Column('is_correct', sa.Boolean, index=True),
            sa.UniqueConstraint('answerid', 'questionid', name='unique_answer_question'),
            schema='petsitters'
        )
    else:
        with op.batch_alter_table('gameanswer', schema='petsitters') as batch_op:
            batch_op.add_column(sa.Column('is_correct', sa.Boolean, index=True))
            batch_op.drop_column('score')

    if 'user' not in insp.get_table_names(schema='petsitters'):
        op.create_table(
            'user',
            sa.Column('userid', sa.Integer, primary_key=True, autoincrement=True, index=True),
            sa.Column('fullname', sa.String, index=True),
            sa.Column('phone', sa.String, index=True),
            sa.Column('email', sa.String, index=True, unique=True),
            sa.Column('profession', sa.String, index=True),
            sa.Column('currentgamequestionid', sa.Integer, index=True),
            schema='petsitters'
        )

    if 'useranswer' not in insp.get_table_names(schema='petsitters'):
        op.create_table(
            'useranswer',
            sa.Column('userid', sa.Integer, sa.ForeignKey('petsitters.user.userid'), primary_key=True, index=True),
            sa.Column('questionid', sa.Integer, sa.ForeignKey('petsitters.gamequestion.questionid'), primary_key=True,
                      index=True),
            sa.Column('answertext', sa.String, index=True),
            sa.Column('score', sa.Integer, index=True),
            sa.UniqueConstraint('userid', 'questionid', name='unique_user_question'),
            schema='petsitters'
        )
    else:
        with op.batch_alter_table('useranswer', schema='petsitters') as batch_op:
            batch_op.alter_column('score', type_=sa.Integer)


def downgrade():
    bind = op.get_bind()
    insp = sa.engine.reflection.Inspector.from_engine(bind)

    if 'gameanswer' in insp.get_table_names(schema='petsitters'):
        with op.batch_alter_table('gameanswer', schema='petsitters') as batch_op:
            batch_op.drop_column('is_correct')
            batch_op.add_column(sa.Column('score', sa.Float, index=True))

    if 'useranswer' in insp.get_table_names(schema='petsitters'):
        with op.batch_alter_table('useranswer', schema='petsitters') as batch_op:
            batch_op.alter_column('score', type_=sa.Float)
