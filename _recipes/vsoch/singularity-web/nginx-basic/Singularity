Bootstrap: docker
From: ubuntu:16.04

%runscript

     cd /data
     exec python3 -m http.server 9999

%post

     mkdir /data
     echo "<h2>Hello World!</h2>" >> /data/index.html
     apt-get update
     apt-get -y install python3     
