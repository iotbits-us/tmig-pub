## **Contents** 
- [Introduction](#Introduction)
- [Overview]()
- [Pre-requisites]()
- [Installation & Configuration]()
    - [Install Docker & Docker compose]()
    - [Install Portainner]()
    - [The Docker compose file ]()
    - [The .env file]()
    - [Telegraf]()
        - [Telegraf conf]()
    - [InfluxDB]()    
    - [The Grafana Provisioning ]()
        - [Datasources]()
        - [Dashboards]()
        - [Plugins]()
        - [Settig home dashboard]()
    - [Additional Considerations]()
- [Deploy the TIG stack]()
- [Debug Container behaviour trough portainer Logs]()
- [Accessing Grafana dashboards]()
- [Security Considerations]()    
- [Improvemments]()
- [Ackwnoledgemnts]()
# A Telegraf - Influxdb & Grafana Docker-compose stack

### Introduction

The aim of this repo is to provide easy deployable [Grafana Monitoring](https://grafana.com/) stack  using [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) as data collector from several sources, with focus in MQTT in this repo  we subscribe to topics  from [Modbusbox](https://mbox.iotbits.net/docs/introduction)  connected to VFD,  we also include a sonoff  WI-FI temperature & Humidity sensor. There are many aspects of this guide  that can be improved , it take me while to get working properly some bash scripts, since I am not a expert in such programming language.

Proposed Scheme:

![](https://github.com/iotbits-us/tmig-pub/blob/master/images/timg.jpg)

 