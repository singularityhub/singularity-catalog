BootStrap: docker
From: centos:centos7

%files
    nginx.repo /etc/yum.repos.d/

%labels
    Maintainer Yoshihiro Okuda
        Version v1.0

%runscript

%post
    echo "Hello from inside the container"
    yum -y update
    yum -y install nginx

