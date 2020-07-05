## **Contents** 
- [Introduction](#Introduction)
- [Overview]()
- [Pre-requisites]()
- [Installation & Configuration]()
    - [Install Docker & Docker compose]()
    - [Install Portainer]()
    - [The Docker compose file ]()
    - [The .env file]()
    - [Telegraf]()
        - [Telegraf conf]()
    - [InfluxDB]()    
    - [The Grafana Provisioning ]()
        - [Data sources]()
        - [Dashboards]()
        - [Plugins]()
        - [Setting home dashboard]()
    - [Additional Considerations]()
- [Deploy the TIG stack]()
- [Debug Container behavior trough portainer Logs]()
- [Accessing Grafana dashboards]()
- [Security Considerations]()    
- [Improvement’s]()
- [Acknowledgements]()
# A Telegraf - Influxdb & Grafana Docker-compose stack

### Introduction

The aim of this repo is to provide easy deployable [Grafana Monitoring](https://grafana.com/) stack  using [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) as data collector from several sources, with focus in MQTT in this repo  we subscribe to topics  from [Modbusbox](https://mbox.iotbits.net/docs/introduction)  connected to VFD,  we also include a sonoff  WI-FI temperature & Humidity sensor. There are many aspects of this guide  that can be improved , it take me while to get working properly some bash scripts, since I am not a expert in such programming language.

### Overview 

![](https://github.com/iotbits-us/tmig-pub/blob/master/images/timg.jpg)

### Prerequisites

To successfully deploy this docker stack its  require to have Linux machine or  virtual environment .

So far we have tested successfully in Ubuntu 20.004, and in a docker Desktop on windows.

Windows System requierements

- Windows 10 64-bit: Pro, Enterprise, or Education (Build 16299 or later).
- Hyper-V and Containers Windows features must be enabled.
- The following hardware prerequisites are required to successfully run Client Hyper-V on Windows 10:
  - 64 bit processor with [Second Level Address Translation (SLAT)](http://en.wikipedia.org/wiki/Second_Level_Address_Translation)
  - 4GB system RAM
  - BIOS-level hardware virtualization support must be enabled in the BIOS settings. For more information, see [Virtualization](https://docs.docker.com/docker-for-windows/troubleshoot/#virtualization-must-be-enabled).

## To be continued ...



 