# Minecraft client in Docker

## How does it work

Passes essential X11 resources to docker:

1. `$DISPLAY`
2. `/tmp/.X11-unix` 
3. `$HOME/.Xauthority`

It also passes GPU to docker (AMD only now). See `Dockerfile` and `start-minecraft.sh` for details.

## How to use

1. Build

    ```bash
    make # or;
    make IMAGE_NAME="custom_image_name"
    ```

2. Start

    ```bash
    ./start-minecraft.sh # or;
    MC_DIR="/custom/minecraft/folder" IMAGE_NAME="custom_image_name" ./start-minecraft.sh
    ```

## TODOs

1. [ ] Pulseaudio
2. [ ] Input Method
3. [ ] NVIDIA - the tutorial is actually [right here](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration)
