from project.db import get_db, get_con, get_column_name

TEAM_ID = 1
TEAM_NAME = 2


def get_teams():
    con = get_con()
    curs = con.cursor()
    teams = curs.execute("""
            SELECT
              *
            FROM Teams
            ORDER BY Teams.Team_ID
    """).fetchall()

    return get_column_name(teams, curs)


def get_teams_players(team_id):
    con = get_con()
    curs = con.cursor()
    curs.prepare("""
            SELECT
              *
            FROM Teams t
            JOIN Players p
              ON p.Team_ID = t.Team_ID
            WHERE t.TEAM_ID = :team_id
            """)
    players = curs.execute(
        None, {'team_id': team_id}
    )

    return get_column_name(players.fetchall(), curs)


def create_team(team_name):
    con = get_con()
    db = con.cursor()

    db.prepare("""
            INSERT INTO Teams (TeamName)
                VALUES (:team_name)
            """)
    db.execute(None, {'team_name': team_name})

    con.commit()


