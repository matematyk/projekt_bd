from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from project.controller.auth import (
    requires_roles, login_required
)
from project.model.games import (
    get_games, get_games_team, get_who_plays, get_games_by_tournament, create_game
)

bp = Blueprint('games', __name__)

from project.model.tournament import get_games_by_tournament


@bp.route('/games/all')
@login_required
@requires_roles('admin', 'kibic')
def index():
    games = get_games()

    return render_template('games/all.html', games=games)


@bp.route('/games/<int:id>/show')
@login_required
@requires_roles('admin', 'kibic')
def show_game_for_team(id):
    games = get_games_team(id)

    return render_template('games/show_game.html', games=games)


@bp.route('/games/who_play/<int:id>/show')
@login_required
@requires_roles('admin', 'kibic')
def show_who_play(id):
    players = get_who_plays(id)

    return render_template('games/who_plays.html', players=players)


@bp.route('/tournament/<int:tour_id>/games/add', methods=('POST', 'GET'))
@login_required
@requires_roles('admin')
def add_teams(tour_id):
    tournament_teams = get_games_by_tournament(tour_id)

    if request.method == 'POST':
        team1 = request.form['team_1']
        team2 = request.form['team_2']
        date = request.form['date']
        error = None

        if not team1:
            error = 'team1 name is required.'
        if not team2:
            error = 'team2 name is required'
        if team1 == team2:
            error = 'Zespół sam ze sobą nie może zagrać meczu.'

        if error is not None:
            flash(error)
        else:

            create_game(tour_id, team1, team2, date)

            flash('Dodałeś nowy turniej. Gratulacje!')

            return redirect(url_for('tournament.all_tournaments'))

    return render_template('games/add_teams.html', teams=tournament_teams)