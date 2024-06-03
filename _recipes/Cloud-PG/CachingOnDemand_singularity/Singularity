Bootstrap: docker
From: cloudpg/centos-7-grid

%help
The log directory should have the correct permisions:
- sudo chown -R 998:996 /var/log/xrootd
Start the service with:
- sudo singularity instance start -B /var/log/xrootd/:/var/log/xrootd/ shub://Cloud-PG/CachingOnDemand_singularity:latest proxy

%post
    yum -y install epel-release
    yum -y install sudo xrootd-server 
    # ca-policy-egi-core ca-policy-lcg
    #/usr/sbin/fetch-crl -q

%files
    config/proxy.cfg /etc/xrootd/xrootd-proxy.cfg
    scripts/entrypoint.sh /opt


%post
    chmod +x /opt/entrypoint.sh

%startscript
    echo -e "Starting XROOTD proxy vs $REMOTE_HOST:$REMOTE_PORT \n Listening on $PROXY_PORT"
    exec /opt/entrypoint.sh

%labels
    Maintainer Diego Ciangottini
    Version v1.0
