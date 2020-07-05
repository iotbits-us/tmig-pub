FROM grafana/grafana:7.0.3-ubuntu
#FROM grafana/grafana:6.7.3-ubuntu
LABEL Maintainer  Luisgcu <angelgcu@gmail.com>
LABEL version="1.1"
LABEL description="Grafana docker image with custom setup"
USER root
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends curl gosu &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

COPY  datasources/influx.yml  /etc/grafana/provisioning/datasources/
COPY  plugins/plugins.yml   /etc/grafana/provisioning/plugins/
COPY  dashboards/default.yml /etc/grafana/provisioning/dashboards/
COPY  dashboards/*.json /var/lib/grafana/dashboards/
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
COPY ./fixhome.sh  /fixhome.sh
#ADD ./fixhome.sh /fixhome.sh
RUN chmod +x  /fixhome.sh
ENTRYPOINT [ "/fixhome.sh" ]
CMD ["/fixhome.sh"]


