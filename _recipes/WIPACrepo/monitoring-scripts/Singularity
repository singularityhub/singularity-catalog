BootStrap: docker
From: centos:8

%files
condor_history_to_elasticsearch.py

%post
mkdir /data

dnf -y install epel-release
dnf -y upgrade ca-certificates --disablerepo=epel
dnf install -y python3-pip
pip3 install 'elasticsearch>=6.0.0,<7.0.0' 'elasticsearch-dsl>=6.0.0,<7.0.0' htcondor requests
