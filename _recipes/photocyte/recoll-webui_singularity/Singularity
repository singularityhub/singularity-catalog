Bootstrap: docker
From: ubuntu:20.04
#####Could use ubuntu:20.04, but it doesn't have python-waitress yet. Scratch that. it has python3-waitress
#####Also note, the newer that is used, the greater the chance of compatability problems w/ older kernels

%labels
MAINTAINER TRF

%files

%environment
    
%post
    apt-get update
    apt-get install locales
    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    apt-get install -y pwgen git nginx xxd apache2-utils nano
    apt-get install -y recoll python3-recoll recollcmd recollgui xvfb python3-waitress python3-ujson
    git clone https://framagit.org/medoc92/recollwebui.git
    
    sed -i 's/127.0.0.1/0.0.0.0/g' /recollwebui/webui-standalone.py
    sed -i 's/8080/13337/g' /recollwebui/webui-standalone.py
    
    ##^^Above settings make the webui exposed on all interfaces, which is handy
    ##but insecure. Should probably run with some sort of authentication
    ##Below is an incomplete bit of settings, intending to use nginx as a reverse proxy
    ##to enable basic authentication

    ##Making some files for the basic authentication
    BASICAUTHUSER="recoll-user"
    echo ${BASICAUTHUSER} > /user.txt
    BUILDKEY=$(xxd -l 16 -p /dev/urandom) ##This is only unique, for each time the container is built.
    echo ${BUILDKEY} > /buildkey.txt
    
    ###Disable nginx logging, which doesn't play nice w/ the read-only filesystem.
    ###Also put nginx.pid in a writable location.
    sed -i 's/\/var\/log\/nginx\/access.log/\/dev\/null/g' /etc/nginx/nginx.conf
    sed -i 's/\/var\/log\/nginx\/error.log/\/dev\/null/g' /etc/nginx/nginx.conf
    sed -i "s/\/run\/nginx.pid/\/tmp\/${BUILDKEY}_recoll-singularity_nginx.pid/g" /etc/nginx/nginx.conf ##This doesn't play nice w/ multiple containers on the same machine
    htpasswd -b -B -c "/tmp/${BUILDKEY}.nginx.pwd" ${BASICAUTHUSER} ${BUILDKEY}
    
    ##Adding the reverse proxy configuration for nginx
    ##There must be an easier way to do this...
    sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\nserver { \n\
      listen 13338; \n\
      location \/ { \n\
      root \/dev\/null; \n\
      } \n\
      location \/${BUILDKEY}\/ { \n\
      root \/dev\/null; \n\
      auth_basic 'Authorized users only'; \n\
      auth_basic_user_file \/tmp\/${BUILDKEY}.nginx.pwd; \n\
      proxy_pass http:\/\/127.0.0.1:4567\/; \n\
      proxy_intercept_errors on; \n\
      proxy_connect_timeout 8; \n\
      proxy_read_timeout 180; \n\    }\n  }/g"  /etc/nginx/nginx.conf ##Add the reverse proxy configuration.
    
%runscript
    #!/bin/bash
    BUILDKEY=`cat /buildkey.txt`
    BASICAUTHUSER=`cat /user.txt`
    echo "Basic authentication parameters:"
    echo "Username: ${BASICAUTHUSER}"
    echo "Key: ${BUILDKEY}"

