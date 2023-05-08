bootstrap: docker
from: neurodebian:jessie

%post
    apt-get update
    apt-get install -y eatmydata wget
    wget -O- http://neuro.debian.net/lists/jessie.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
    apt-get update
    eatmydata apt-get install -y --no-install-recommends \
      python-mvpa2 fsl-core fsl-mni152-templates ants python-pip \
      python-datalad python-scipy python-numpy \
      python-sklearn python-dateutil convert3d
    eatmydata apt-get install -y python-nipype=0.11.0-1~nd80+1 
    mkdir /data /scripts /derivatives /ihome /idata

    # make entrypoint
    ENTRYPOINT="/startup.sh"
    if [ ! -f "$ENTRYPOINT" ]; then \
       echo '#!/usr/bin/env bash' >> $ENTRYPOINT \
       && echo 'set +x' >> $ENTRYPOINT \
       && echo 'source /etc/fsl/fsl.sh' >> $ENTRYPOINT \
       && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ENTRYPOINT;
    fi
    chmod 777 $ENTRYPOINT

%runscript
    exec /startup.sh "$*"
