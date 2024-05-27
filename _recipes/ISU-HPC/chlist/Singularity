Bootstrap: docker
FROM: centos:centos7.7.1908

%help
Moira list managment via singularity
Assumes you have kerberos tickets in memory.
Usage: singularity shell  chlist.simg
Usage: chlist.simg args go here
 
%labels
MAINTAINER orman@iastate.edu

%files
chlist-rhel7 /usr/bin/chlist
krb5.conf /etc/krb5.conf

%post
yum -y install krb5-workstation hesiod bind-utils ssh-clients
echo "sms             775/tcp sms_db          # SMS database ISU" >> /etc/services
mkdir -p /usr/athena/lib; touch /usr/athena/lib/chlist.info


%runscript
exec chlist "$@"

