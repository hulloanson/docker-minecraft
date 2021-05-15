FROM debian:10

RUN apt-get update
RUN apt-get install wget curl -y
ENV DEBIAN_FRONTEND=noninteractive
RUN wget https://launcher.mojang.com/download/Minecraft.deb -O /tmp/Minecraft.deb
RUN dpkg -i /tmp/Minecraft.deb; apt-get -f install -y
RUN rm /tmp/Minecraft.deb

# TODO: NVIDIA

# AMD
RUN \
  apt-get update && \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri && \
  rm -rf /var/lib/apt/lists/*

# Pulseaudio
RUN sed -i 's/main$/main contrib/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install pulseaudio-utils -y

COPY ./copy/pulse-client.conf /etc/pulse/client.conf

RUN groupadd -g 1000 debian
RUN useradd -d /home/debian -s /bin/bash -m debian -u 1000 -g 1000
RUN usermod -aG audio debian
USER debian
ENV HOME /home/debian
RUN mkdir /home/debian/.minecraft
RUN chown -R debian:debian /home/debian/.minecraft

WORKDIR /home/debian/.minecraft

USER root

RUN [ "wget", "https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.1.0/forge-1.16.5-36.1.0-installer.jar", "-O", "/opt/forge-installer.jar" ]

COPY ./copy/scripts /scripts

RUN chmod a+x /scripts/*

USER debian

CMD /usr/bin/minecraft-launcher

