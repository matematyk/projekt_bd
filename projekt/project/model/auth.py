from project.db import get_con
from werkzeug.security import generate_password_hash


def create_user(username, password, status=1):
    con = get_con()
    db = con.cursor()
    db.prepare('INSERT INTO Users (username, password, status) VALUES (:username, :password,:status)')
    db.execute(None, {'username': username, 'password': generate_password_hash(password), 'status': status})
    con.commit()
