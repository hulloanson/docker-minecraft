#!/usr/bin/env bash

USER_VAR=USER
if [[ ! -z "${SUDO_USER}" ]]; then
  HOME="$(bash -c "cd ~$(printf %q $SUDO_USER) && pwd")"
  USER_VAR=SUDO_USER
fi

if [[ -z "${IMAGE_NAME}" ]];then
  IMAGE_NAME="minecraft"
fi

if [[ -z "${MC_DIR}" ]];then
  MC_DIR=".minecraft"
fi

mkdir -p "${MC_DIR}"
chown -R "${USER}" "${MC_DIR}"

args=(
  --name "minecraft-${USER}" --rm
  -v /tmp/.X11-unix:/tmp/.X11-unix
  -v "$HOME/.Xauthority:/home/debian/.Xauthority"
  -v "$HOME/.minecraft:/home/debian/.minecraft"
  -e DISPLAY=$DISPLAY
  # TODO: activating IM. the lines below does not work (yet! need more figuring out).
  #-e GTK_IM_MODULE=$GTK_IM_MODULE
  #-e QT4_IM_MODULE=$QT4_IM_MODULE
  #-e CLUTTER_IM_MODULE=$CLUTTER_IM_MODULE
  #-e QT_IM_MODULE=$QT_IM_MODULE
  -h "$HOSTNAME"
  # So container can connect to host's X11 server
  --network=host
  # TODO: pulseaudio
  --device=/dev/dri
  --group-add video
  ${IMAGE_NAME}
)

docker run ${args[@]}
