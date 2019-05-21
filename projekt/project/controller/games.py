from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from project.controller.auth import (
    requires_roles, login_required
)
from project.model.games import (
    get_games, get_games_team, get_who_plays, get_games_by_tournament
)

bp = Blueprint('games', __name__)

from project.model.tournament import (
    get_tournament
)


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


@bp.route('/tournament/<int:tour_id>/games/<int:game_id>/add')
@login_required
@requires_roles('admin')
def add_teams(tour_id, game_id):
    tournament = get_tournament(tour_id)
    games = get_games_by_tournament(tour_id)



    return render_template('games/add_teams.html', tournament=tournament, games=games)