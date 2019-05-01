from flask import (
    Blueprint, render_template
)

from project.model.team import *


bp = Blueprint('team', __name__)


@bp.route('/teams')
def index():
    """Show all the teams"""
    teams = get_teams()

    return render_template('team/all.html', teams=teams)


@bp.route('/team/<int:id>/show', methods=('POST', 'GET'))
def show_players(id):
    players = get_teams_players(id)

    return render_template('team/players.html', players=players)