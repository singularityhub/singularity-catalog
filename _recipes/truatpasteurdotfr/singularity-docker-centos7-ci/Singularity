BootStrap: docker
From: centos:centos7

%post
yum -y update && yum -y upgrade && yum -y clean all
date +"%Y-%m-%d-%H%M" > /last_update
