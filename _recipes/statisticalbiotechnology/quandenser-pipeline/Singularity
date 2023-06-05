Bootstrap:docker
From:chambm/wine-dotnet:4.7-x64  # Prebuilt, WIP trying to convert to Ubuntu 18.04

%environment
    # Fixing wine variables
    export LC_ALL=C

    export WINEPREFIX=/wineprefix64  # Get a clean prefix
    export WINEDISTRO=devel
    export WINEPATH="C:\pwiz"  # Location where the pwiz files will be
    export WINEDEBUG=-all,err+all  # Hide all wine related output

    # Check if WINE_TMPDIR exist and set to /tmp if it is not set
    export WINE_TMPDIR=${WINE_TMPDIR:-/tmp}

    # Making so user who logs into the image can use wine
    mkdir -p "$WINE_TMPDIR/wineprefix64_$USER"
    random_name=$(date +%s | sha256sum | base64 | head -c 32)
    mkdir -p "$WINE_TMPDIR/wineprefix64_$USER/wineprefix64_$random_name"  # Create folder, so you are owner
    link_wine.sh $random_name # This script will link all files in $WINEPREFIX and input them in /var/local/shared_wine/wineprefix64
    export WINEPREFIX="$WINE_TMPDIR/wineprefix64_$USER/wineprefix64_$random_name"  # Change prefix, so wine will know you are the owner

    mkdir -p $WINE_TMPDIR/runtime-$USER
    export XDG_RUNTIME_DIR=$WINE_TMPDIR/runtime-$USER
    export XDG_CONFIG_HOME=$WINE_TMPDIR/runtime-$USER

%labels
   website https://github.com/statisticalbiotechnology/quandenser-pipeline
   description Quandenser-pipeline image
   license http://proteowizard.sourceforge.net/licenses.html
   tags quandenser
   documentation https://github.com/statisticalbiotechnology/quandenser-pipeline
   AUTHOR lukas.kall@scilifelab.se and timothy.bergstrom@gmail.com

%files
   # Needed for triqler preprocess
   dependencies/percolator.py /usr/local/bin/percolator.py
   # Needed for triqler preprocess
   dependencies/prepare_input.py /usr/local/bin/prepare_input.py
   # Needed for triqler preprocess
   dependencies/normalize_intensities.py /usr/local/bin/normalize_intensities.py
   # Comments on the line below breaks it for some reason
   dependencies/pwiz.tar.bz2 /pwiz.tar.bz2
   # A script that links all file in wineprefix64 to a directory owned by you --> anybody can use wine
   dependencies/link_wine.sh /usr/local/bin/link_wine.sh
   dependencies/ui /
   # Due to some bugs in quandenser, the modified quandenser version will be used instead in an effort to fix the bugs
   # This comes from quandenser-pipeline branch of quandenser
   # dependencies/quandenser-v200508-linux-amd64.deb /
   # Boxcar converter
   dependencies/boxcar_converter.py /usr/local/bin/boxcar_converter.py
   # Command wrapper, which prevents some errors from occuring
   dependencies/command_wrapper.py /usr/local/bin/command_wrapper.py

%post
    export DEBIAN_FRONTEND=noninteractive
    echo "Placing ui files in the correct directories"
    rm -rf /var/local/quandenser_ui  # Clear prev folder, if it exist
    mkdir -p /var/local/quandenser_ui
    mv /ui/* /var/local/quandenser_ui
    rm -r ui/
    chmod -R a+x /var/local/quandenser_ui/*  # So everybody can access the files

    echo "Installing packages with apt-get"
    apt-get update
    apt-get -y install wget
    wget -nc https://dl.winehq.org/wine-builds/winehq.key  # Add key, since it does not exist in image.
    apt-key add winehq.key  # Add the key to prevent update crash
    apt-get update
    apt-get -y install default-jre git unzip bzip2 nano curl zip gcc
    apt-get -y install libcanberra-gtk-module libcanberra-gtk3-module
    apt-get -y install build-essential zlib1g-dev libssl-dev  # For building python
    apt-get -y install maven  # For building quandenser

    echo "Updating nextflow"
    #curl -s https://get.nextflow.io | bash
    #rm -f /var/local/quandenser_ui/config/nextflow
    #mv nextflow /var/local/quandenser_ui/config
    chmod a+rx /var/local/quandenser_ui/config/nextflow

    echo "Installing proteowizard 32 BIT (FULL VENDOR CAPABILITIES)"
    export LC_ALL=C
    export WINEPREFIX=/wineprefix64  # Get a clean prefix
    export WINEDISTRO=devel
    export WINEPATH="C:\pwiz"

    mkdir -p $WINEPREFIX/drive_c/pwiz
    tar xjvf /pwiz.tar.bz2 -C $WINEPREFIX/drive_c/pwiz  # Unpack all pwiz files in the created directory
    rm /pwiz.tar.bz2  # Clean the tar file
    chmod -R a+rx $WINEPREFIX   # ALL USERS NEED ACCESS TO THIS DIRECORY AND FILES TO CREATE SYMLINKS
    chmod a+rx /usr/local/bin/link_wine.sh  # also set so everybody can link with the script

    echo "Installing python 3.6"
    cd $(mktemp -d)
    wget -nc https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
    tar -xvf Python-3.6.3.tgz
    cd Python-3.6.3
    ./configure
    make
    make install
    # DEBIAN_FRONTEND=noninteractive apt-get -y install python3.6 python3.6-dev
    wget -nc https://bootstrap.pypa.io/get-pip.py
    python3.6 get-pip.py
    ln -sf /usr/local/bin/python3 /usr/local/bin/python
    ln -sf /usr/local/bin/pip /usr/local/bin/pip3

    echo "Installing packages with pip"
    # psutil requires gcc
    pip install psutil
    pip install PySide2
    pip install colorama
    pip install qdarkstyle
    pip install matplotlib
    pip install numpy
    pip install tqdm
    #apt-get -y install python3.6-tk

    echo "Installing dependencies for OpenGL and X11"
    # Qt dependencies
    apt-get -y install build-essential cmake qt5-default libxml2 libxslt1.1 qtbase5-dev libxcb-xinerama0 gcc
    apt-get -y install qttools5-dev-tools libqt5clucene5 libqt5concurrent5 libqt5core5a libqt5dbus5 libqt5designer5 libqt5designercomponents5 libqt5feedback5 libqt5gui5 libqt5help5 libqt5multimedia5 libqt5network5 libqt5opengl5 libqt5opengl5-dev libqt5organizer5 libqt5positioning5 libqt5printsupport5 libqt5qml5 libqt5quick5 libqt5quickwidgets5 libqt5script5 libqt5scripttools5 libqt5sql5 libqt5sql5-sqlite libqt5svg5 libqt5test5 libqt5webkit5 libqt5widgets5 libqt5xml5 libqt5xmlpatterns5 libqt5xmlpatterns5-dev

    # Downloading tmp files here
    cd $(mktemp -d)

    echo "Installing quandenser"
    # wget -nc https://github.com/statisticalbiotechnology/quandenser/releases/download/rel-0-01/quandenser-v0-01-linux-amd64.deb
    git clone --recursive https://github.com/statisticalbiotechnology/quandenser.git
    cd quandenser
    # git checkout e07136fdc1ba5fd61f2b41462ef19a82847824aa
    git checkout quandenser-pipeline
    git submodule update --recursive
    ./quickbuild.sh
    cd ..
    dpkg -i ./release/ubuntu64/quandenser-*-linux-amd64.deb
    # Weird stuff with permissions. Fixing
    chmod 755 /usr/bin/quandenser
    chmod 755 /usr/share/java/advParams_dinosaur_targeted.txt
    chmod 755 /usr/share/java/Dinosaur-*.free.jar
    apt-get install -f

    echo "Installing triqler (quandenser-pipeline version)"
    pip install triqler

    echo "Installing crux"
    wget -nc https://noble.gs.washington.edu/crux-downloads/crux-3.2/crux-3.2.Linux.x86_64.zip  # -nc checks if it exist
    unzip -uq crux-3.2.Linux.x86_64.zip
    cp -f crux-3.2.Linux.x86_64/bin/crux /usr/local/bin/

    echo "Fixing timezones"
    offset=1
    ln -fs /usr/share/zoneinfo/Etc/GMT$offset /etc/localtime

    echo "Cleaning image"
    apt-get clean

    echo "IMAGE BUILT SUCCESSFULLY"

%appenv quandenser_ui
    export LC_ALL=C
    # Check if WINE_TMPDIR exist and set to /tmp if it is not set
    export WINE_TMPDIR=${WINE_TMPDIR:-/tmp}

    mkdir -p $WINE_TMPDIR/runtime-$USER
    export XDG_RUNTIME_DIR=$WINE_TMPDIR/runtime-$USER
    export XDG_CONFIG_HOME=$WINE_TMPDIR/runtime-$USER
    cd /var/local/quandenser_ui

%apprun quandenser_ui
    python /var/local/quandenser_ui/main.py

%runscript
    GREEN="\033[1;92m"
    RESET="\033[0m\n"
    VERSION="v0.0837"
    printf "${GREEN}Quandenser-pipeline ${VERSION}${RESET}"
