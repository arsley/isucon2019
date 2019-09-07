#!/bin/bash
set -xe
set -o pipefail

CURRENT_DIR=$(cd $(dirname $0);pwd)
export MYSQL_HOST=localhost
export MYSQL_PORT=${MYSQL_PORT}
export MYSQL_USER=${MYSQL_USER}
export MYSQL_DBNAME=${MYSQL_DBNAME}
export MYSQL_PWD=${MYSQL_PASS}
export LANG="C.UTF-8"
cd $CURRENT_DIR

cat 01_schema.sql 02_categories.sql initial.sql.gz | mysql -h $MYSQL_HOST -u $MYSQL_USER
