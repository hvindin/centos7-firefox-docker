# Firefox Docker Container  

This container is build on centos7 and includes firefox + adobe flash player.  

To run the container run something like:

     docker run \
       --rm \
       -it \
       --net host \
       --cpuset-cpus 0 \
       --memory 2048mb \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -e DISPLAY=unix$DISPLAY \
       docker.io/hvindin/centos7-firefox-docker:latest
       # OR
       # --device /dev/snd \ if you want sound. This will also cause your container to inherit your local properties
       # docker.io/hvindin/centos7-firefox-docker:latest

