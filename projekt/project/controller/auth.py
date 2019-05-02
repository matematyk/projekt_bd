from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash

from project.db import get_db, get_con
from project.model.auth import create_user, select_user, select_user_by_id
from functools import wraps

bp = Blueprint('auth', __name__, url_prefix='/auth')


@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        con = get_con()
        error = None
        db = con.cursor()

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'

        res = select_user(username)

        if res is not None:
            error = 'User {} is already registered.'.format(username)

        if error is None:
            create_user(username, password, status='admin')
            return redirect(url_for('auth.user_page'))

        flash(error)

    return render_template('auth/register.html')


@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        error = None
        user = select_user(username)

        if user is None:
            error = 'Incorrect username.'
        elif not check_password_hash(user[2], password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user[0]
            return redirect(url_for('tournament.create'))

        flash(error)

    return render_template('auth/login.html')


@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('auth.login'))


@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        db = get_db()
        user = select_user_by_id(user_id)

        g.user = user


def requires_roles(*roles):
    def wrapper(f):
        @wraps(f)
        def wrapped(*args, **kwargs):
            if get_current_user_role() not in roles:
                return "NIE MASZ DOSTĘPU"
            return f(*args, **kwargs)
        return wrapped
    return wrapper


@bp.route('/user')
@requires_roles('admin', 'kibic')
def user_page():
    return "You've got permission to access this page."


def get_current_user_role():
    user_id = session.get('user_id')
    user = select_user_by_id(user_id)

    return user[3]
