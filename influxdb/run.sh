#!/bin/bash

set -m
CONFIG_TEMPLATE="/influxdb.template.conf"
CONFIG_FILE="/etc/influxdb/influxdb.conf"
CURR_TIMESTAMP=`date +%s`
echo " influxdb with custom setup by iotbits"
sleep 2

mv -v $CONFIG_FILE $CONFIG_FILE.$CURR_TIMESTAMP
cp -v $CONFIG_TEMPLATE $CONFIG_FILE
mkdir -p /var/log/influxdb/
# touch /var/log/influxdb/influxdb.log
# ls /var/

exec influxd -config=$CONFIG_FILE 1>>/var/log/influxdb/influxdb.log 2>&1 &
# exec influxd -config=$CONFIG_FILE 1>>/var/lib/influxdb/influxdb.log 2>&1 &
sleep 5

USER_EXISTS=`influx -host=${INFLUXDB_HOST} -port=${INFLUXDB_API_PORT} -execute="SHOW USERS" | awk '{print $1}' | grep "${INFLUXDB_ADMIN_USER}" | wc -l`
echo "user exist : '"$USER_EXISTS "'"

if [ -n ${USER_EXISTS} ]
then
 echo "setting up influx database admin user and password "
  influx -host=${INFLUXDB_HOST} -port=${INFLUXDB_API_PORT} -execute="CREATE USER ${INFLUXDB_ADMIN_USER} WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
  influx -host=${INFLUXDB_HOST} -port=${INFLUXDB_API_PORT} -username=${INFLUXDB_ADMIN_USER} -password="${INFLUXDB_ADMIN_PASSWORD}" -execute="create database ${INFLUXDB_DB}"
  influx -host=${INFLUXDB_HOST} -port=${INFLUXDB_API_PORT} -username=${INFLUXDB_ADMIN_USER} -password="${INFLUXDB_ADMIN_PASSWORD}" -execute="grant all PRIVILEGES on ${INFLUXDB_DB} to ${INLFUXDB_ADMIN_USER}"
echo "done.. "
fi
echo " "
echo " influxdb setup finished"
echo "Enjoy TIMG  with Mobusbox"
echo "For more information please visit www.iotbits.net"
echo "Special thanks to @chenryhabana for contributing to this repo"
echo "  "
tail -f /var/log/influxdb/influxdb.log
