from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from project.controller.auth import requires_roles, login_required
from project.model.games import  get_games, get_games_team

bp = Blueprint('games', __name__)


@login_required
@requires_roles('admin', 'kibic')
@bp.route('/games/all')
def index():
    games = get_games()

    return render_template('games/all.html', games=games)


@bp.route('/games/<int:id>/show')
@login_required
@requires_roles('admin', 'kibic')
def show_game_for_team(id):
    games = get_games_team(id)

    return render_template('games/show_game.html', games=games)