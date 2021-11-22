BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/x86_64/
Include: yum

# If you want the updates (available at the bootstrap date) to be installed
# inside the container during the bootstrap instead of the General Availability
# point release (7.x) then uncomment the following line
UpdateURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/updates/x86_64/

%runscript
    exec "$@"

%startscript
    echo 172.17.0.1 lami.hpc.cineca.it >> /etc/hosts
    rm -f /run/httpd/httpd.pid; /usr/sbin/httpd -D FOREGROUND   

%setup
    mkdir ${SINGULARITY_ROOTFS}/tmpstorage
    cp match-alias.conf ${SINGULARITY_ROOTFS}/tmpstorage

%post
    yum install -y epel-release
    yum install -y yum-plugin-ovl yum-plugin-copr
    yum -y copr enable simc/arkiweb
    yum install -y arkiweb httpd

    mkdir -p /var/www/html/arkiweb/
    cp /usr/share/doc/arkiweb/html/example/index.html /var/www/html/arkiweb/

# copy local files
    cp -pf /tmpstorage/match-alias.conf /etc/arkimet/match-alias.conf
    rm -rf /tmpstorage

# start with:
# singularity instance start --writable-tmpfs -B $HOME/arkiweb-docker/config:/mnt/arkiweb -B $HOME/arkiweb-docker/httpd:/etc/httpd/conf.d --net --network-args "portmap=8080:80/tcp" arkiweb-docker-singularity arkiweb

