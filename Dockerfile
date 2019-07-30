FROM i386/ubuntu
MAINTAINER Martin Nakladal <nakladal@intravps.cz>

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y libmysql++ make g++ gcc git unzip && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/SphereServer/Source.git /tmp/sphere && \
    cd /tmp/sphere && \
    ls -al && \
    make NIGHTLY=1

RUN ls -alh /tmp/sphere

RUN mkdir /Sphere  
WORKDIR /Sphere

ADD https://forum.spherecommunity.net/sshare.php?downproj=56 Sphere.tar.gz
ADD https://github.com/Sphereserver/Scripts/archive/master.zip scripts.zip

RUN tar -zxvf Sphere.tar.gz && rmdir scripts 
RUN unzip scripts.zip && mv Scripts-master scripts

RUN cp /tmp/sphere/spheresvr /Sphere/spheresvr

RUN echo "[eof]">/Sphere/save/sphereworld.scp 
RUN echo "[eof]">/Sphere/save/spheredata.scp
RUN echo "[eof]">/Sphere/save/spherechars.scp 
RUN echo "[eof]">/Sphere/save/spheremultis.scp 
RUN echo "[eof]">/Sphere/save/spherestatics.scp 
RUN touch /Sphere/accounts/sphereaccu.scp
EXPOSE 2593
WORKDIR /Sphere
