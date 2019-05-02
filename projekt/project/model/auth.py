from project.db import get_con
from werkzeug.security import generate_password_hash


def create_user(username, password, status='admin'):
    con = get_con()
    db = con.cursor()
    db.prepare("""
            INSERT INTO Users (username, password, status)
                VALUES (:username, :password, :status)
                """)
    db.execute(None, {'username': username, 'password': generate_password_hash(password), 'status': status})
    con.commit()


def select_user(username):
    con = get_con()
    db = con.cursor()
    db.prepare("""
            SELECT
                *
            FROM Users
            WHERE username = :username
                """)
    res = db.execute(
        None, {'username': username}
    ).fetchone()

    return res


def select_user_by_id(user_id):
    con = get_con()
    db = con.cursor()
    db.prepare("""
            SELECT
                *
            FROM Users
            WHERE User_ID = :user_id
                """)

    res = db.execute(
        None, {'user_id': user_id}
    ).fetchone()

    return res
