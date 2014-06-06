#!/bin/bash
export PGDATA=/var/lib/pgsql/data

if [ ! -f ${PGDATA}/PG_VERSION ] ; 
    then
    echo "rebuilding PostgreSQL database cluster"

    # blow away the old cluster
    rm -rf ${PGDATA}
    
    # create a fresh new cluster
    initdb -D ${PGDATA} -E UTF-8

    # allow md5-based password auth for IPv4 connections
    echo "host all all 0.0.0.0/0 md5" >> ${PGDATA}/pg_hba.conf
    # listen on all addresses, not just localhost
    echo "listen_addresses='*'" >> ${PGDATA}/postgresql.conf

    # Start PostgreSQL to create the new user
    pg_ctl -D ${PGDATA} start

    # create a new user
    PGPASSWORD=drupaltestbotpw createuser -d -E -l -R -S drupaltestbot
    # create a new default database for the user
    createdb -O drupaltestbot drupaltestbot
    # stop the cluster
    pg_ctl -D ${PGDATA} stop
fi

postgres -D ${PGDATA} -p 5432
echo "pgsql died at $(date)";
