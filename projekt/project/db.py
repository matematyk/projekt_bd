import cx_Oracle
import click
from flask import current_app, g
from flask.cli import with_appcontext


def get_db():
    if 'db' not in g:
        connection = get_con()
        g.db = connection.cursor()
        print(g.db)
    return g.db


def get_con():
    return cx_Oracle.connect('bp209493/abc123@localhost/LABS')


def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()


def init_app(app):
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)


def init_db():
    db = get_db()

    with current_app.open_resource('schema.sql') as f:
        db.executescript(f.read().decode('utf8'))


def simple_select():
    db = get_db()
    res = db.execute(
        "SELECT * from Users"
    ).fetchall()
    return res 


@click.command('init-db')
@with_appcontext
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')


@click.command('testSql')
@with_appcontext
def test_command():
    simple_select()
    click.echo('Select')