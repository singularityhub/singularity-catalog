Bootstrap: docker
From: kitware/paraviewweb:pv-osmesa-v5.6.0

# This container is intended for those *without* nvidia graphics cards!
# If you have an nvidia graphics card, see the Singularity.nv recipe
# Usage:

%help
    To start:
        singularity instance start -B data_dir:/data pv.simg visualizer
        singularity instance start pv.simg visualizer

    To stop:
        singularity instance stop visualizer

    To login into the running instance:
        singularity shell instance://visualizer

%setup
    mkdir -p $SINGULARITY_ROOTFS/data
    mkdir -p $SINGULARITY_ROOTFS/usr/local/bin
    exit 0

%environment
    export EXTRA_PVPYTHON_ARGS="-dr --mesa-swr"
    export LANG=C
    PORT=8080
    ALLOW_HTTP=true
    URL=localhost
    export PORT ALLOW_HTTP URL

%post
    pwd
    cat > /usr/local/bin/start.sh << EOF
#! /bin/bash
/opt/paraview/install/bin/pvpython ${EXTRA_PVPYTHON_ARGS} \
    /opt/paraview/install/share/paraview-5.6/web/visualizer/server/pvw-visualizer.py \
    --content /opt/paraview/install/share/paraview-5.6/web/visualizer/www \
    --port 8080 \
    --data /data \
    --viewport-max-width 1920 \
    --viewport-max-height 1080 \
    --timeout 30
EOF
    chmod ugo+x /usr/local/bin/start.sh

%startscript
    nohup /usr/local/bin/start.sh &
