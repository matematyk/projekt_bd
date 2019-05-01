from flask import (
    Blueprint, render_template, request, flash, redirect, url_for
)
from project.model.tournament import *


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
            error = 'Title is required.'

        if error is not None:
            flash(error)
        else:

            torunament = create_tournament(name, date_start, date_end)

            return redirect(url_for('tournament.all_tournaments'))

    return render_template('tournament/create.html')
