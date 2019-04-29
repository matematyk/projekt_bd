import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from project.db import get_db, get_con

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
        db.prepare('SELECT User_ID FROM Users WHERE username = :username' )
        res = db.execute(
            None, {'username': username}
        ).fetchone()
        if res is not None:
            error = 'User {} is already registered.'.format(username)

        if error is None:
            db.prepare('INSERT INTO Users (username, password) VALUES (:username, :password)')
            db.execute( None, {'username': username, 'password': generate_password_hash(password)})
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('auth/register.html')
@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        db = get_db()
        error = None
        db.prepare('SELECT * FROM Users WHERE username = :username')
        user = db.execute(
            None, {'username': username}
        ).fetchone()

        if user is None:
            error = 'Incorrect username.'
        elif not check_password_hash(user[2], password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user[0]
            return redirect(url_for('app'))

        flash(error)

    return render_template('auth/login.html')
@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        con = get_db().prepare('SELECT * FROM Users WHERE User_ID = :User_ID')
        con = con.execute( None, {'User_ID': user_id})
        g.user = con.fetchone()