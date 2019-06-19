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


def get_game(game_id):
    con = get_con()
    curs = con.cursor()
    curs.prepare("""SELECT
              g.Game_ID,
              g.Result,
              t1.TeamName | | '-' | | t2.TeamName "VS"
            FROM Games g
            JOIN Teams t1
              ON Team1_Id = t1.Team_id
            JOIN Teams t2
              ON Team2_id = t2.Team_id
            WHERE g.Game_ID = :game_id 
              """)

    game = curs.execute(
        None, {'game_id': game_id}
    )

    return get_column_name(game.fetchall(), curs)


def set_score_to_game(game_id, result):
    con = get_con()
    db = con.cursor()

    db.prepare("""
           UPDATE Games
            SET result = :result
            WHERE game_id = :game_id
            """)
    db.execute(None, {'game_id': game_id, 'result': result})

    con.commit()


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
                JOIN Players p
                  ON p.Player_ID = who.Player_ID
                JOIN Teams t
                ON t.TEAM_ID = p.TEAM_ID
                WHERE who.Game_ID = :team_id
                """)
    players = curs.execute(
        None, {'team_id': team_id}
    )

    return get_column_name(players.fetchall(), curs)


def get_games_by_tournament(tour_id):
    con = get_con()
    curs = con.cursor()
    curs.prepare("""
                  SELECT *
                    FROM Tournament_Application ta
                    JOIN Tournament t 
                        ON ta.Tournament_ID = t.Tournament_ID
                    JOIN Teams team
                        ON team.Team_ID = ta.Team_ID
                    WHERE t.Tournament_ID = :tournament_id
                   """)
    games = curs.execute(
        None, {'tournament_id': tour_id}
    )

    return get_column_name(games.fetchall(), curs)


def create_game(tournament_id, team1, team2, date):
    con = get_con()
    db = con.cursor()

    db.prepare("""
            INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
            VALUES (to_date(:date_s, 'YYYY-MM-DD'), '0:0', :team1, :team2, :tournament_id)
            """)
    db.execute(None, {'tournament_id': tournament_id, 'team1': team1, 'team2': team2, 'date_s': date})

    con.commit()
