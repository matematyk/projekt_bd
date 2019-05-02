from project.db import get_con


def get_games():
    con = get_con()
    db_c = con.cursor()
    games = db_c.execute("""
            SELECT
              *
            FROM Games
            JOIN Teams t1
              ON Team1_Id = t1.Team_id
            JOIN Teams t2
              ON Team2_id = t2.Team_id
                        """).fetchall()

    con.commit()

    return games


def get_games_team(team_id):
    con = get_con()
    db_c = con.cursor()
    db_c.prepare("""
            SELECT
              g.game_id,
              g.result,
              LISTAGG (s.ResultSet_1 | | ':' | | s.ResultSet_2, ', ') WITHIN GROUP (ORDER BY g.game_id) "Result",
              t1.TeamName | | '-' | | t2.TeamName "VS"
            FROM Games g
            JOIN Teams t1
              ON g.Team1_Id = t1.Team_id
            JOIN teams t2
              ON g.Team2_id = t2.Team_id
            JOIN sets_m s
              ON g.game_id = s.game_id
            WHERE t1.team_id = :team_id
            OR t2.team_id = :team_id
            GROUP BY g.GAME_ID,
                     g.Result,
                     t1.TeamName,
                     t2.TeamName
                """)
    games = db_c.execute(
        None, {'team_id': team_id}
    )

    return games.fetchall()
