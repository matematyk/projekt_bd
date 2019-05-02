from project.db import get_db, get_con

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
            join Players p
            on p.Team_ID = t.Team_ID
            where t.TEAM_ID = :team_id""")
    players = db_c.execute(
        None, {'team_id': team_id}
    )

    return players.fetchall()


def create_team(team_name):
    con = get_con()
    db = con.cursor()

    db.prepare("""
            INSERT INTO Teams(TeamName) VALUES (:team_name)
            """)
    db.execute(None, {'team_name': team_name})

    con.commit()
