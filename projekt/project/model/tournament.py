from project.db import get_db, get_con, get_column_name


def get_tournaments():
    con = get_con()
    curs = con.cursor()
    tournaments = curs.execute(
        """SELECT
              t.Tournament_ID,
              t.Tournament_NAME,
              SUM(CASE
                WHEN apli.Tournament_ID IS NOT NULL THEN 1
                ELSE 0
              END) sum_teams
            FROM Tournament t
            LEFT JOIN Tournament_Application apli
              ON t.Tournament_ID = apli.Tournament_ID
            GROUP BY t.Tournament_ID,
                     t.Tournament_NAME
        """
    ).fetchall()
    return get_column_name(tournaments, curs)



def get_tournament(tournament_id):
    db_c = get_db()
    db_c.prepare("""
            SELECT
              t.TEAM_ID,
              team.TeamName,
              t.DATE_APPLICATION
            FROM Tournament_Application t
            LEFT JOIN Teams team
              ON team.Team_ID = t.Team_ID
            WHERE t.Tournament_ID = :tournament_id
            """)
    tournament = db_c.execute(
        None, {'tournament_id': tournament_id}
    )

    return tournament.fetchall()


def get_all_tournaments():
    con = get_con()
    curs = con.cursor()
    tournaments = curs.execute("""
            SELECT
              *
            FROM Tournament t
            """)
    return get_column_name(tournaments.fetchall(), curs)



def create_tournament(name, date_start, date_end):
    con = get_con()
    db = con.cursor()

    db.prepare("""
            INSERT INTO Tournament(Tournament_NAME, Date_start, Date_end)
            VALUES (:name, to_date(:date_start, 'YYYY-MM-DD'), to_date(:date_end, 'YYYY-MM-DD'))
            """)
    db.execute(None, {'name': name, 'date_start': date_start, 'date_end': date_end})

    con.commit()


def create_application(team_id, tournament_id, date):
    con = get_con()
    db = con.cursor()
    print(team_id, tournament_id, date)
    db.prepare("""
            INSERT INTO Tournament_Application(Team_ID, Tournament_ID, Date_application) 
            VALUES (:team_id, :tournament_id, to_date(:date_s, 'YYYY-MM-DD'))
            """)
    db.execute(None, {'team_id': team_id, 'tournament_id': tournament_id, 'date_s': date})

    con.commit()
