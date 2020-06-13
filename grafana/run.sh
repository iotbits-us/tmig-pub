#!/bin/bash -e

: "${GF_PATHS_DATA:=/var/lib/grafana}"     ## this a local vaiable pointing to that path?
: "${GF_PATHS_LOGS:=/var/log/grafana}"
: "${GF_PATHS_PLUGINS:=/var/lib/grafana/plugins}"
: "${GF_PATHS_PROVISIONING:=/etc/grafana/provisioning}"

chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_LOGS"
chown -R grafana:grafana /etc/grafana

# This section install all availlable plugins esta seccion instala todos los plugin de grafana 
# if [ "${GRAFANA_PLUGINS_ENABLED}" != "false" ]
# then
#    GRAFANA_PLUGINS=`grafana-cli plugins list-remote | awk '{print $2}'| grep "-"`
#    for plugin in ${GRAFANA_PLUGINS}; 
#    do
#      if [ ! -d ${GF_PATHS_PLUGINS}/$plugin ]
#      then
#        grafana-cli plugins install $plugin || true;
#      else
#       echo "Plugin $plugin already installed"
#      fi
#    done

# if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then
#  OLDIFS=$IFS
#  IFS=','
# for plugin in ${GF_INSTALL_PLUGINS}; do
#    IFS=$OLDIFS
#   if [ ! -d ${GF_PATHS_PLUGINS}/$plugin ]
#    then
#    grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${plugin}
#    else
#      echo "Plugin $plugin already installed"
#    fi
#  done
# fi

# fi
# End Pluging install

# echo "default.paths.data: '" ${GF_PATHS_DATA}"'"
# Start grafana with gosu
exec gosu grafana /usr/share/grafana/bin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data="$GF_PATHS_DATA"   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"   \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS" &

sleep 5
###############################################################
# Set new Data Source name
INFLUXDB_DATA_SOURCE="myinflux"
INFLUXDB_DATA_SOURCE_WEB=`echo ${INFLUXDB_DATA_SOURCE} | sed 's/ /%20/g'`

# Set information about grafana host
GRAFANA_URL=`hostname -i`
#GRAFANA_URL=`grafana1`
GRAFANA_PORT="${GRAFANA_PORT_INTERNAL}"
GRAFANA_USER="${GF_SECURITY_ADMIN_USER}"
GRAFANA_PASSWORD="${GF_SECURITY_ADMIN_PASSWORD}"


# Check $INFLUXDB_DATA_SOURCE status
INFLUXDB_DATA_SOURCE_STATUS=`curl -s -L -i \
 -H "Accept: application/json" \
 -H "Content-Type: application/json" \
 -X GET http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT_INTERNAL}/api/datasources/name/${INFLUXDB_DATA_SOURCE_WEB} | head -1 | awk '{print $2}'`
 
# echo ""
# echo "datasource estatus: '" ${INFLUXDB_DATA_SOURCE_STATUS}"'"
# echo "grafana user: '" ${GRAFANA_USER}"'"
# echo "grafana password: '" ${GRAFANA_PASSWORD}"'"
# echo "grafana url: '" ${GRAFANA_URL}"'"
# echo "grafana port: '" ${GRAFANA_PORT}"'"
# echo "influx datasource: '" ${INFLUXDB_DATA_SOURCE}"'"
#echo ""

#Debug Time!
curl -s -L -i \
 -H "Accept: application/json" \
 -H "Content-Type: application/json" \
 -X GET http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT}/api/datasources/name/${INFLUXDB_DATA_SOURCE_WEB} >>$GF_PATHS_LOGS/grafana.log 2>>$GF_PATHS_LOGS/grafana.log 
echo "http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT}/api/datasources/name/${INFLUXDB_DATA_SOURCE_WEB}" >> $GF_PATHS_LOGS/grafana.log
echo "INFLUXDB_DATA_SOURCE_STATUS: "$INFLUXDB_DATA_SOURCE_STATUS >> $GF_PATHS_LOGS/grafana.log
echo "GRAFANA_URL: "$GRAFANA_URL >> $GF_PATHS_LOGS/grafana.log
echo "GRAFANA_PORT: "$GRAFANA_PORT >> $GF_PATHS_LOGS/grafana.log
echo "GRAFANA_USER: "$GRAFANA_USER >> $GF_PATHS_LOGS/grafana.log
echo "GRAFANA_PASSWORD: "$GRAFANA_PASSWORD >> $GF_PATHS_LOGS/grafana.log
echo "End debug secction.. going to check if datasourse exist.."
sleep 5

# Check if $INFLUXDB_DATA_SOURCE exists
if [ ${INFLUXDB_DATA_SOURCE_STATUS} != 200 ]
then
  # If not exists, create one 
  echo "Data Source: '"${INFLUXDB_DATA_SOURCE}"' not found in Grafana configuration"
  echo "Creating Data Source: '"$INFLUXDB_DATA_SOURCE"'"
  echo " url : '"http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT}/api/datasources"'"
  curl -L -i \
   -H "Accept: application/json" \
   -H "Content-Type: application/json" \
   -X POST -d '{
    "name":"'"${INFLUXDB_DATA_SOURCE}"'",
    "type":"influxdb",
    "url":"'"http://"${INFLUXDB_HOST}":"${INFLUXDB_API_PORT}""'",
    "access":"proxy",
    "basicAuth":false,
    "basicAuthUser": "notset",
    "secureJsonData": {
    "basicAuthPassword": "notset"},  
    "database":"'"${DATABASE}"'",
    "user":"'"${INFLUXDB_ADMIN_USER}"'",
    "password":"'"${INFLUXDB_ADMIN_PASSWORD}"'"}
  ' \
  http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT}/api/datasources
  echo " "
  echo "Done Creating new datasource name : '"${INFLUXDB_DATA_SOURCE}"'" 
  sleep 1
  
  else
  #Continue if it doesn't exists
  echo "Data Source '"${INFLUXDB_DATA_SOURCE}"' already exists."
  
fi
sleep 20 
echo " "
echo " Now lets set  Main_Dashboard as default  ID=1"
  curl -L -i \
   -H "Accept: application/json" \
   -H "Content-Type: application/json" \
   -X PUT -d '{"theme": "","homeDashboardId":1,"timezone":""}   
  ' \
  http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@${GRAFANA_URL}:${GRAFANA_PORT}/api/user/preferences

echo "Done settingdefault dashboard"

echo " "
echo "***************************"
echo "Enjoy TIMG  with Mobusbox"
echo "For more information please visit www.iotbits.net"
echo "Special thanks to @chenryhabana for contributing to this repo"
echo "***************************"
tail -f $GF_PATHS_LOGS/grafana.log