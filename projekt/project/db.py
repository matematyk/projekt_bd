import cx_Oracle
import click
from flask import current_app, g
from flask.cli import with_appcontext


def get_db():
    if 'db' not in g:
        connection = get_con()
        g.db = connection.cursor()
    return g.db


def get_column_name(result, curs):
    column_names = list(map(lambda x: x.lower(), [d[0] for d in curs.description]))
    # list of data items
    rows = list(result)

    result = [dict(zip(column_names, row)) for row in rows]
    return result


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

