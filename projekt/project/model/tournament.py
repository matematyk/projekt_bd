from project.db import get_db, get_con


def get_tournaments():
    db_c = get_db()
    tournaments = db_c.execute(
        """select t.Tournament_ID,  t.Tournament_NAME, sum(case when apli.Tournament_ID is not null then 1 else 0 end) sum_teams
            from Tournament t
            left join Tournament_Application apli
            on t.Tournament_ID = apli.Tournament_ID
            group by t.Tournament_ID, t.Tournament_NAME
        """
    ).fetchall()

    return tournaments


def get_tournament(tournament_id):
    db_c = get_db()
    db_c.prepare("""select t.TEAM_ID, team.TeamName, t.DATE_APPLICATION
            from Tournament_Application t
            left join Teams team
            on team.Team_ID = t.Team_ID
            where t.Tournament_ID = :tournament_id
            """)
    tournament = db_c.execute(
        None, {'tournament_id': tournament_id}
    )

    return tournament.fetchall()


def create_tournament(name, date_start, date_end):
    con = get_con()
    db = con.cursor()

    db.prepare("""
            INSERT INTO Tournament(Tournament_NAME, Date_start, Date_end)
            VALUES (:name, to_date(:date_start, 'YYYY-MM-DD'), to_date(:date_end, 'YYYY-MM-DD'))
            """)
    db.execute(None, {'name': name, 'date_start': date_start, 'date_end': date_end})

    con.commit()
