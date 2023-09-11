Bootstrap: docker
From: debian:stretch

%post
    apt-get -y update
    apt-get -y install less python3-pip man
    pip3 install PyYAML pypng requests psycopg2 openpyxl xlrd h5py fonttools mapbox lxml xport sas7bdat pandas pyshp python-dateutil visidata

%runscript
    vd