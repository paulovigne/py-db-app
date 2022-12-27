FROM python:3.11-alpine

ARG PG_HOST
ARG PG_PORT
ARG PG_DBNAME
ARG PG_USER
ARG PG_PASS

COPY app.py /opt/
COPY requirements.txt /opt/

RUN apk add libpq-dev
RUN pip3 install -r /opt/requirements.txt

USER 1001

EXPOSE 8080

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
