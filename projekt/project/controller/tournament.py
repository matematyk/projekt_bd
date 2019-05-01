from flask import (
    Blueprint, render_template, request, flash, redirect, url_for
)
from project.model.tournament import *
from project.model.team import get_teams

import datetime

bp = Blueprint('tournament', __name__)


@bp.route('/tournaments/all')
def all_tournaments():
    tournaments = get_tournaments()

    return render_template('tournament/all.html', tournaments=tournaments)


@bp.route('/tournament/<int:id>/show', methods=('POST', 'GET'))
def show_tournament(id):
    teams = get_tournament(id)

    return render_template('tournament/show.html', teams_for=teams)


@bp.route('/tournament/create', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        name = request.form['tournament']
        date_start = request.form['date_start']
        date_end = request.form['date_end']
        print(date_start)
        error = None

        if not name:
            error = 'tournament name is required.'

        if error is not None:
            flash(error)
        else:

            torunament = create_tournament(name, date_start, date_end)

            return redirect(url_for('tournament.all_tournaments'))

    return render_template('tournament/create.html')


@bp.route('/tournament/new_application', methods=('GET', 'POST'))
def new_application():
    tournaments = get_all_tournaments()
    teams = get_teams()

    if request.method == 'POST':
        tournaments = request.form['tournament']
        team = request.form['team']
        now = datetime.datetime.now().strftime("%Y-%m-%d")

        create_application(tournaments, team, now)

        return redirect(url_for('tournament.new_application'))

    return render_template('tournament/new_application.html', tournaments=tournaments, teams=teams)