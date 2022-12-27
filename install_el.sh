#!/bin/bash

#
# Install SO Packages
#

dnf install -y git docker python3 python3-pip libpqxx-devel.x86_64

#
# Clone Repo
#

cd /opt
git clone https://github.com/paulovigne/py-db-app.git

#
# Install PostgreSQL
#

systemctl start docker && systemctl enable docker

docker run \
      --name postgres \
      --env POSTGRES_USER=root \
      --env POSTGRES_PASSWORD=rootpassword \
      --detach  \
      --publish 5432:5432 \
      -v /opt/py-db-app/sql:/docker-entrypoint-initdb.d \
      postgres

sleep 10

#
# Install PyApp
#

adduser pyapp

pip3 install -r /opt/py-db-app/requirements.txt

mkdir -p /etc/pyapp

cp /opt/py-db-app/pyapp.service /etc/systemd/system/pyapp.service
cp /opt/py-db-app/pyapp.env /etc/pyapp/pyapp.env

chown -R pyapp. /opt/py-db-app
chown -R pyapp. /etc/pyapp

systemctl daemon-reload
systemctl start pyapp
systemctl enable pyapp