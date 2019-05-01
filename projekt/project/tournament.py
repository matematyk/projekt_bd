from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from project.model import *


bp = Blueprint('tournament', __name__)


@bp.route('/app')
def index():
    """Show all the teams"""
    teams = get_teams()

    return render_template('team/all.html', teams=teams)


@bp.route('/app/all')
def show_tournament():

    pass


@bp.route('/app/team')
def show_teams():
    pass


@bp.route('/app/team/<int:id>/show', methods=('POST', 'GET'))
def show_players(id):
    players = get_teams_players(id)

    return render_template('team/players.html', players=players)