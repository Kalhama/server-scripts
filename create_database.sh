#!/bin/bash

# create database
read -p "Give database name: " dbname
if [ -z $dbname ] 
then
    echo "dbname cannot be empty"
    exit 1
fi
CREATE="create database \"$dbname\";"

# disallow everyone accessing it. This should be unnecessary if 
# REVOKE CONNECT ON DATABASE template1 FROM PUBLIC;
# has been ever run
# see: https://dba.stackexchange.com/questions/17790/created-user-can-access-all-databases-in-postgresql-without-any-grants
PERMISSIONS="REVOKE connect ON DATABASE \"$dbname\" FROM PUBLIC;"

# create new user
read -p "Give user name [$dbname]: " username
username=${username:-$dbname}

read -p "Give user passwork [$dbname]: " password
password=${password:-$dbname}

USER="create user \"$username\" with encrypted password '$password';"

# grant privileges on database to new user
GRANT="grant all privileges on database \"$username\" to \"$username\";"

echo "Next run"
echo "psql -c \"$CREATE $PERMISSIONS $USER $GRANT\""
