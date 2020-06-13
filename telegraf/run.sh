#!/bin/bash

set -m
echo "=> Starting scripts..."
sleep 10
CONFIG_TEMPLATE="/telegraf.template.conf"
CONFIG_FILE="/etc/telegraf/telegraf.conf"
sleep 5
#echo "hostname :'"$HOST_NAME"', Influxdb host:'"${INFLUXDB_HOST}"', Influixdb port:'"${INFLUXDB_API_PORT}"', Database:'" ${DATABASE}"'"
#echo "INFLUXDB_ADMIN_USER :'"${INFLUXDB_ADMIN_USER}"', INFLUXDB_ADMIN_PASSWORD:'"${INFLUXDB_ADMIN_PASSWORD}"'"
echo "TELEGRAF_MQTTSERVER :'"${TELEGRAF_MQTTSERVER}"'"
echo "TELEGRAF_MQTTSERVER_PORT :'"${TELEGRAF_MQTTPORT}"'"
sleep 5
sed -e "s/\${HOST_NAME}/$HOST_NAME/" \
 -e "s!\${INFLUXDB_HOST}!$INFLUXDB_HOST!" \
 -e "s/\${INFLUXDB_PORT}/$INFLUXDB_PORT/" \
 -e "s/\${DATABASE}/$DATABASE/" \
 -e "s/\${INFLUXDB_ADMIN_USER}/$INFLUXDB_ADMIN_USER/" \
 -e "s/\${INFLUXDB_ADMIN_PASSWORD}/$INFLUXDB_ADMIN_PASSWORD/" \
 -e "s/\${TELEGRAF_MQTTSERVER}/$TELEGRAF_MQTTSERVER/" \
 -e "s/\${TELEGRAF_MQTTPORT}/$TELEGRAF_MQTTPORT/" \
 -e "s/\${TELEGRAF_MQTT_USERNAME}/$TELEGRAF_MQTT_USERNAME/" \
 -e "s/\${TELEGRAF_MQTT_PASSWD}/$TELEGRAF_MQTT_PASSWD/" \
 $CONFIG_TEMPLATE > $CONFIG_FILE

sleep 5
echo "***************************"
echo "Enjoy TIMG  with Mobusbox"
echo "For more information please visit www.iotbits.net"
echo "Special thanks to @chenryhabana for contributing to this repo"
echo "***************************"
echo "=> Starting Telegraf ..."

exec telegraf -config /etc/telegraf/telegraf.conf
