FROM python:3.11-alpine

RUN apk add libpq-dev
COPY app.py /opt/
COPY requirements.txt /opt/
RUN pip3 install -r /opt/requirements.txt
USER 1001

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
