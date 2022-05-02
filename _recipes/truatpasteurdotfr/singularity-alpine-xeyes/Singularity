BootStrap: docker
From: alpine:latest

%runscript
xeyes "$@"

%post
echo "Hello from inside the container"
apk update && apk upgrade && apk add xeyes
touch /`date -u -Iseconds`

%labels
MAINTAINER truatpasteurdotfr
