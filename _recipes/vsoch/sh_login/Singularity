Bootstrap: docker
From: continuumio/miniconda3

# sudo singularity build vanessa/sh_container Singularity

%help
To run the container. since we need to create services you should start it as
an instance. We also need to define a bind to a temporary directory for nginx.

mkdir -p /tmp/logs 
singularity instance.start --bind /tmp/logs:/var/log/nginx sh_container web
singularity instance.list


%files
    . /code

%labels
    MAINTAINER vsochat@stanford.edu

%environment
    DEBIAN_FRONTEND=noninteractive
    LC_ALL=C.UTF-8
    LANG=C.UTF-8

%post
    apt-get update
    apt-get -y install apt-utils cmake wget unzip libffi-dev libssl-dev \
                       vim nginx nginx-extras uuid-runtime

    DEBIAN_FRONTEND=noninteractive
    LC_ALL=C.UTF-8
    LANG=C.UTF-8

    PATH=/opt/conda/bin:$PATH

    cd /code

    # Set up nginx
    cp /code/script/nginx/nginx.conf /etc/nginx/nginx.conf && \
    chmod a+w -R /etc/nginx/sites-available && \
    cp /code/sh_login/config_dummy.py /code/sh_login/config.py && \
    chmod u+x /code/script/generate_key.sh && \
    /bin/bash /code/script/generate_key.sh /code/sh_login/config.py && \

    /opt/conda/bin/python setup.py install && \
    /opt/conda/bin/pip install --upgrade pip && \
    /opt/conda/bin/pip install gunicorn

    # Clean up
    apt-get autoremove -y && \
    apt-get clean

%environment
    export DEBIAN_FRONTEND=noninteractive
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export PATH=/opt/conda/bin:$PATH

%startscript
    exec /opt/conda/bin/sh_login start "$@"
%runscript
    exec /opt/conda/bin/sh_login start "$@"
