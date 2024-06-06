"""drop tables in public schema

Revision ID: 5420975bfce7
Revises: 907f43226796
Create Date: 2024-06-05 16:47:48.746314

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '5420975bfce7'
down_revision: Union[str, None] = '907f43226796'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.execute('DROP TABLE IF EXISTS public.gameanswer CASCADE')
    op.execute('DROP TABLE IF EXISTS public.useranswer CASCADE')
    op.execute('DROP TABLE IF EXISTS public.user CASCADE')
    op.execute('DROP TABLE IF EXISTS public.gamequestion CASCADE')


def downgrade() -> None:
    pass
