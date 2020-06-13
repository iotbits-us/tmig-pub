FROM grafana/grafana:7.0.0-ubuntu
#FROM grafana/grafana:6.7.3-ubuntu
MAINTAINER Luisgcu <angelgcu@gmail.com>
LABEL version="1.1"
LABEL description="Grafana docker image with custom setup"
USER root
ADD run.sh /run.sh
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends curl gosu &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
#RUN mkdir -p /data/grafana/plugins && chown -R grafana:grafana /data/grafana/plugins

RUN grafana-cli --pluginsDir "/var/lib/grafana/plugins"  --pluginUrl https://github.com/geeks-r-us/mqtt-panel/releases/download/v1.0.2/geeksrus-mqtt-panel-1.0.2.zip plugins install geeksrus-mqtt-panel
RUN grafana-cli plugins install grafana-worldmap-panel    
RUN grafana-cli plugins install ryantxu-ajax-panel
RUN grafana-cli plugins install btplc-alarm-box-panel
RUN grafana-cli plugins install farski-blendstat-panel
RUN grafana-cli plugins install aidanmountford-html-panel
RUN grafana-cli plugins install natel-influx-admin-panel
RUN grafana-cli plugins install natel-plotly-panel
RUN grafana-cli plugins install pr0ps-trackmap-panel
RUN grafana-cli plugins install grafana-clock-panel
RUN grafana-cli plugins install digiapulssi-organisations-panel
RUN grafana-cli plugins install vonage-status-panel
RUN grafana-cli plugins install michaeldmoore-multistat-panel
RUN grafana-cli plugins install natel-discrete-panel
RUN grafana-cli plugins install macropower-analytics-panel
RUN grafana-cli plugins install farski-blendstat-panel
RUN grafana-cli plugins install grafana-image-renderer 

ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN mkdir -p /opt/grafana/dashboards
ADD ["*.json", "/opt/grafana/dashboards/"]
ADD ["default-dashboard.yaml", "/etc/grafana/provisioning/dashboards/"]
COPY preplugins.sh /root/
RUN chmod +x /root/preplugins.sh
RUN /root/preplugins.sh

CMD ["/run.sh"]
