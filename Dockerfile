FROM openjdk:8-jdk-alpine

#copy file into docker
COPY / /tmp/file 
RUN mv /tmp/file     /AE

# set env variable
ENV IP IP
ENV outport outport
ENV server server
WORKDIR /AE/

RUN echo "#!/bin/sh"  >> /startFromDocker.sh
RUN echo 'sed -i "s/192.168.99.100/$IP/g" /AE/http_server.java'  >> /startFromDocker.sh
RUN echo "javac http_server.java" >> /startFromDocker.sh
RUN echo 'nohup java http_server &' >> /startFromDocker.sh
RUN echo 'top' >>/startFromDocker.sh

RUN chmod +x /startFromDocker.sh
CMD ["/startFromDocker.sh"]