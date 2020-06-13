FROM telegraf:1.14.2-alpine
MAINTAINER luisgcu <angelgcu@gmail.com>
LABEL version="1.0"
LABEL description="Telegraf docker image with custom setup"

USER root

ADD telegraf.template.conf /telegraf.template.conf

ADD run.sh /run.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]

