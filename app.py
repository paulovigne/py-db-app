import psycopg
import os
import json

from flask import Flask
app = Flask(__name__)

def db():
    pg_host=os.environ.get('PG_HOST', 'localhost')
    pg_port=os.environ.get('PG_PORT', '5432')
    pg_dbname=os.environ.get('PG_DBNAME', 'pyapp')
    pg_user=os.environ.get('PG_USER', 'postgres')
    pg_pass=os.environ.get('PG_PASS', 'postgres')
    return psycopg.connect('host=' + pg_host + ' port=' + pg_port + ' dbname=' + pg_dbname + ' user=' + pg_user + ' password=' + pg_pass)

def query_db(query, args=(), one=False):
    cur = db().cursor()
    cur.execute(query, args)
    r = [dict((cur.description[i][0], value)                for i, value in enumerate(row)) for row in cur.fetchall()]
    cur.connection.close()
    return (r[0] if r else None) if one else r

@app.route("/")
def main():
    my_query = query_db("select * from movies limit %s", (3,))
    json_output = json.dumps(my_query)
    return (json_output)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
