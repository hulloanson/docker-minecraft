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
RUN groupadd -g 1000 debian
RUN useradd -d /home/debian -s /bin/bash -m debian -u 1000 -g 1000
USER debian
ENV HOME /home/debian
RUN mkdir /home/debian/.minecraft
RUN chown -R debian:debian /home/debian/.minecraft
CMD /usr/bin/minecraft-launcher

