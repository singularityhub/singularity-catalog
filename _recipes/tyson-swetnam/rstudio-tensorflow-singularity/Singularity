Bootstrap: docker
From: rocker/r-ver:3.5.3

%environment
    LC_ALL=en_US.UTF-8 
    LANG=en_US.UTF-8 
    TERM=xterm

%post
    apt-get update
    apt-get -y install systemd systemd-sysv gdebi-core procps libssl1.1 ed wget curl libqt5webkit5 libqt5core5a
    apt-get -y install r-base r-base-dev

    curl https://download1.rstudio.org/rstudio-xenial-1.1.456-amd64.deb > /rstudio-1.1.456-amd64.deb
    apt-get -y install /rstudio-1.1.456-amd64.deb

    wget -O /rstudio-server-stretch-1.1.456-amd64.deb \
      https://download2.rstudio.org/rstudio-server-stretch-1.1.456-amd64.deb
    gdebi -n /rstudio-server-stretch-1.1.456-amd64.deb

    # Setup the "general" CRAN repo
    echo 'local({
 r <- getOption("repos")
 r["CRAN"] = "https://cran.us.r-project.org"
 options(repos = r)
})' >> /etc/R/Rprofile.site

    # We are setting up a normal user for access
    # Login: rstudio  Password: rstudio
    useradd -c "RStudio Account" -u 500 -d /home/rstudio -s /bin/bash rstudio
    echo "rstudio:rstudio" | /usr/sbin/chpasswd

    # Move systemd service file into place
    cp /usr/lib/rstudio-server/extras/systemd/rstudio-server.service /lib/systemd/system/
    systemctl enable rstudio-server

    # Remove unneeded source packages
    rm -f /rstudio-1.1.456-amd64.deb
    rm -f /rstudio-server-stretch-1.1.456-amd64.deb
    
    # Install R packages
    R -e "install.packages('littler', dependencies=TRUE,repos='http://cran.rstudio.com/')"
 
    # Install Tensorflow
    echo "\nTENSORFLOW_PYTHON=/usr/bin/python3" >> /usr/local/lib/R/etc/Renviron

    ## Python
    apt-get update -qq 
    apt-get -y --no-install-recommends install python3-dev python3-setuptools python3-pip

    ## Install Keras
    pip3 install \
    h5py==2.9.0 \
    pyyaml==3.13 \
    requests==2.21.0 \
    Pillow==5.4.1 \
    tensorflow-gpu==1.12.0 \
    keras==2.2.4 \
    --no-cache-dir \
    && install2.r keras

    ## Python Xgboost for CPU
    pip3 install \
    wheel==0.33.0 \
    setuptools==40.8.0 \
    scipy==1.2.1 --upgrade
    pip3 install xgboost==0.81

    ## Get Java (for h2o R package)
    apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    cmake \
    default-jdk \
    default-jre \
    && R CMD javareconf

    ## h2o requires Java
    install2.r h2o
    install2.r greta

%runscript
    /usr/bin/rstudio "$@"

%startscript
    /usr/lib/rstudio-server/bin/rserver
