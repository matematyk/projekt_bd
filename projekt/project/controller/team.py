from flask import (
    Blueprint, render_template, request, redirect, url_for
)

from project.model.team import *
from project.controller.auth import requires_roles, login_required

bp = Blueprint('team', __name__)


@bp.route('/teams')
@login_required
@requires_roles('admin')
def index():
    teams = get_teams()

    return render_template('team/all.html', teams=teams)


@bp.route('/team/<int:id>/show')
@login_required
@requires_roles('admin', 'kibic')
def show_players(id):
    players = get_teams_players(id)

    return render_template('team/players.html', players=players)


@bp.route('/teams/add', methods=('POST', 'GET'))
@login_required
@requires_roles('admin')
def add_team():
    if request.method == 'POST':
        team_name = request.form['team']

        create_team(team_name)

        return redirect(url_for('team.index'))

    return render_template('team/create.html')
