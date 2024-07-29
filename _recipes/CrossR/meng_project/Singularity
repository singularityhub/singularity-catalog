Bootstrap: docker
From: ubuntu:16.04

%post

    # Basics for building packages
    apt-get -y update && apt-get install -y build-essential
    apt-get install -y apt-utils
    apt-get install -y libopenblas-base

    # Needed to download SC2
    apt-get install -y wget

    # Needed to unzip the SC2 binary + maps
    apt-get install -y zip
    apt-get install -y unzip

    # Set correct locale
    apt-get -y update && apt-get install -y locales
    locale-gen en_GB.UTF-8
    export LANG=en_GB.UTF-8
    export LANGUAGE=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8

    # Install Git
    apt-get install -y git-all
    apt-get -y update

    # Further dev dependencies
    apt-get install -y libgtk2.0-dev

    # Install Conda and add it to the path
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
        wget --quiet https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
        /bin/bash ~/anaconda.sh -b -p /opt/conda && \
        rm ~/anaconda.sh

    export PATH=/opt/conda/bin:$PATH

    # Install Starcraft II
    wget --continue  --tries=0 http://blzdistsc2-a.akamaihd.net/Linux/SC2.4.0.2.zip -O /tmp/sc2.zip
    unzip -P iagreetotheeula /tmp/sc2.zip -d /opt/
    rm /tmp/sc2.zip

    # And the map packs
    wget --continue http://blzdistsc2-a.akamaihd.net/MapPacks/Melee.zip -O /tmp/melee.zip
    unzip -P iagreetotheeula /tmp/melee.zip -d /opt/StarCraftII/Maps/
    rm /tmp/melee.zip

    wget --continue https://github.com/deepmind/pysc2/releases/download/v1.2/mini_games.zip -O /tmp/mini_games.zip
    unzip /tmp/mini_games.zip -d /opt/StarCraftII/Maps/
    rm /tmp/mini_games.zip

    # Fix the permissions
    chmod -R 755 /opt/StarCraftII/Maps/

    # Install PySC2 and TensorFlow
    /opt/conda/bin/pip install pysc2==2.0.1
    /opt/conda/bin/conda install -y --quiet -c anaconda tensorflow-gpu==1.8

    mkdir /nobackup
    mv /tmp/*.SC2Map /opt/StarCraftII/Maps/mini_games/
    mv /tmp/*.py /opt/conda/lib/python3.6/site-packages/pysc2/maps/

%files
    CustomMaps/* /tmp/

%environment

    # Update the path to make sure SCII is discoverable.
    export PATH=/opt/conda/bin:$PATH
    export SC2PATH=/opt/StarCraftII
%runscript

