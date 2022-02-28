Bootstrap: docker
From: kitware/paraviewweb:pvw-osmesa-demo-v5.6.0

# This image is not intended for nvidia - for the other version, see README
# sudo singularity build paraview-web.simg Singularity
# mkdir -p /tmp/apache2
# sudo singularity instance.start --bind /tmp/apache2:/var/run/apache2 paraview-web.simg apache
# sudo singularity instance start --bind /tmp/apache2:/var/run/apache2 paraview-web.simg apache # v3.0 and up

# singularity instance.list
# DAEMON NAME      PID      CONTAINER IMAGE
# apache           13743    /home/vanessa/Documents/Dropbox/Code/shub/containers/apache/paraview-web.simg

%startscript
    cd /opt/paraview
    exec /opt/paraviewweb/scripts/start.sh
