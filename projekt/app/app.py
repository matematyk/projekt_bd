from flask import Flask, render_template
from . import db

app = Flask(__name__)

@app.route("/")
def main():
    db_c = db.get_db()
    posts = db_c.execute(
        'select * from emp'
    ).fetchall()
    print(posts)

    return render_template('index.html', posts=posts)

if __name__ == "__main__":
    app.run()