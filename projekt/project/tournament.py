from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from project.db import get_db


bp = Blueprint('tournament', __name__)

@bp.route('/')
def index():
    """Show all the posts, most recent first."""
    db_c = get_db()
    posts = db_c.execute(
        'select * from emp'
    ).fetchall()

    return render_template('index.html', posts=posts)
