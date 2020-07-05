#!/bin/bash  -e

: "${GF_PATHS_LOGS:=/var/log/grafana}"
: "${GF_PATHS_DATA:=/var/lib/grafana}"
chown -R grafana:grafana  "$GF_PATHS_LOGS"
chown -R grafana:grafana /etc/grafana
exec gosu grafana /usr/share/grafana/bin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data="$GF_PATHS_DATA"   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"   &  

GRAFANA_URL=`hostname -i`
GRAFANA_PORT="3000"
GRAFANA_USER="${GF_SECURITY_ADMIN_USER}"
GRAFANA_PASSWORD="${GF_SECURITY_ADMIN_PASSWORD}"
DASHB_UID="${GRAFANA_HOME_DASHBOARD_UID}"
#dashboard_uid="ro1RxckMk"
sleep 5 
# echo "starting scrips1.."
# echo "grafana url is : ${GRAFANA_URL}"
# echo " "
# echo "Grafana username is : ${GRAFANA_USER}"
# echo " "
# echo "starting scrips3.."
id=$(curl -s -H 'Accept: application/json' -X GET --user "${GRAFANA_USER}:${GRAFANA_PASSWORD}" "http://localhost:3000/api/dashboards/uid/${DASHB_UID}" | grep -Po '"dashboard":.*?"id":\K\d+')
echo " "
echo "ID IS ${id} "
sleep 5 
curl -q -H 'Accept: application/json' -H 'Content-type: application/json' -X PUT --data "{ \"homeDashboardId\": $id }" --user "${GRAFANA_USER}:${GRAFANA_PASSWORD}" 'http://localhost:3000/api/org/preferences'
#wait
echo " "
echo "Done settingdefault dashboard 06/29/2020"
echo " "
tail -f $GF_PATHS_LOGS/grafana.log

