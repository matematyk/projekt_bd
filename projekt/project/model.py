from werkzeug.exceptions import abort
from project.db import get_con, get_db

TEAM_ID = 1
TEAM_NAME = 2


def get_teams():
    db_c = get_db()
    teams = db_c.execute(
        'select * from Teams'
    ).fetchall()

    return teams


def get_teams_players(team_id):
    db_c = get_db()
    db_c.prepare("""select * from Teams t
            left join Players p
            on p.Team_ID = t.Team_ID
            where t.TEAM_ID = :team_id""")
    players = db_c.execute(
        None, {'team_id': team_id}
    )

    return players.fetchall()