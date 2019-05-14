from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash

from project.model.auth import create_user, select_user, select_user_by_id
from functools import wraps

bp = Blueprint('auth', __name__, url_prefix='/auth')


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if g.user is None:
            return redirect(url_for('auth.login', next=request.url))
        return f(*args, **kwargs)
    return decorated_function


@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        error = None

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'

        res = select_user(username)

        if len(res) != 0:
            error = 'User {} is already registered.'.format(username)

        if error is None:
            create_user(username, password, status='admin')
            flash('thank you for registering', 'info')
            return redirect(url_for('auth.login'))

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
        elif not check_password_hash(user[0]['password'], password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user[0]['user_id']
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
        user = select_user_by_id(user_id)

        g.user = user


def requires_roles(*roles):
    def wrapper(f):
        @wraps(f)
        def wrapped(*args, **kwargs):
            if get_current_user_role() not in roles:
                return render_template('auth/error.html')
            return f(*args, **kwargs)
        return wrapped
    return wrapper


@bp.route('/user')
@login_required
@requires_roles('admin', 'kibic')
def user_page():
    return "You've got permission to access this page."


def get_current_user_role():
    user_id = session.get('user_id')
    user = select_user_by_id(user_id)
    print(user)

    return user[0]['status']


