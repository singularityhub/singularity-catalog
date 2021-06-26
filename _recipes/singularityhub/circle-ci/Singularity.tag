Bootstrap: docker
From: centos:7

%runscript
    exec echo "Never sneeze on an ice cube tray, $@!"
