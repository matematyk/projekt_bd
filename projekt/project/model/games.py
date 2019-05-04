from project.db import get_con, get_column_name


def get_games():
    con = get_con()
    curs = con.cursor()
    games = curs.execute("""
            SELECT
              g.Game_ID,
              g.Result,
              t1.TeamName | | '-' | | t2.TeamName "VS"
            FROM Games g
            JOIN Teams t1
              ON Team1_Id = t1.Team_id
            JOIN Teams t2
              ON Team2_id = t2.Team_id
                """)

    return get_column_name(games.fetchall(), curs)


def get_games_team(team_id):
    con = get_con()
    curs = con.cursor()
    curs.prepare("""
            SELECT
              g.game_id,
              g.result,
              LISTAGG (s.ResultSet_1 | | ':' | | s.ResultSet_2, ', ') WITHIN GROUP (ORDER BY g.game_id) sets,
              t1.TeamName | | '-' | | t2.TeamName teams
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
    games = curs.execute(
        None, {'team_id': team_id}
    )

    return get_column_name(games.fetchall(), curs)


def get_who_plays(team_id):
    con = get_con()
    curs = con.cursor()
    curs.prepare("""
                SELECT
                  *
                FROM WhoPlays who
                JOIN Games g
                  ON g.Game_ID = who.Game_ID
                JOIN Players p
                  ON p.Player_ID = who.Player_ID
                WHERE who.Game_ID = :team_id
                """)
    players = curs.execute(
        None, {'team_id': team_id}
    )

    return get_column_name(players.fetchall(), curs)

