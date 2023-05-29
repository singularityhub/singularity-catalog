Bootstrap:shub
From:murphygroup/singularity-matlabmcr2018b

IncludeCmd: yes

%post 
    echo "Download binaries"
    cd /home/murphylab && \
    wget -nc --quiet http://www.cellorganizer.org/Downloads/v2.8.1/docker/cellorganizer-binaries-matlabmcr2018b.tgz && \
    tar -xvf cellorganizer-binaries-matlabmcr2018b.tgz && \
    rm cellorganizer-binaries-matlabmcr2018b.tgz   
 
    mv cellorganizer-binaries/ /opt/ && \
    chmod +x /opt/cellorganizer-binaries/img2slml && \
    chmod +x /opt/cellorganizer-binaries/slml2img && \
    chmod +x /opt/cellorganizer-binaries/slml2report && \
    chmod +x /opt/cellorganizer-binaries/slml2info && \
    chmod +x /opt/cellorganizer-binaries/slml2slml && \

    ln -s /opt/cellorganizer-binaries/img2slml /usr/local/bin/img2slml && \
    ln -s /opt/cellorganizer-binaries/slml2img /usr/local/bin/slml2img && \
    ln -s /opt/cellorganizer-binaries/slml2report /usr/local/bin/slml2report && \
    ln -s /opt/cellorganizer-binaries/slml2info /usr/local/bin/slml2info && \
    ln -s /opt/cellorganizer-binaries/slml2slml /usr/local/bin/slml2slml

    mv /opt/mcr/v95/bin/glnxa64/libexpat.so.1 /opt/mcr/v95/bin/glnxa64/libexpat.so.1.backup
    mv /opt/mcr/v95/bin/glnxa64/libexpat.so.1.5.0 /opt/mcr/v95/bin/glnxa64/libexpat.so.1.5.0.backup
    mv /opt/mcr/v95/bin/glnxa64/libcrypto.so.1.0.0 /opt/mcr/v95/bin/glnxa64/libcrypto.so.1.0.0.backup
    mv /opt/mcr/v95/bin/glnxa64/libssl.so.1.0.0 /opt/mcr/v95/bin/glnxa64/libssl.so.1.0.0.backup

    echo "Installing Download Demos Scripts"
	cd /home/murphylab
    mkdir /opt/cellorganizer-demos
	url='http://www.cellorganizer.org/Downloads/v2.8.0/singularity/demos.tgz'
	wget -O demo_set.tgz $url && tar xvf demo_set.tgz -C /opt/cellorganizer-demos 
	rm -rf demo_set.tgz
	

%apprun img2slml
    /usr/local/bin/img2slml "$@"

%apprun slml2img
    /usr/local/bin/slml2img "$@"

%apprun slml2report
    /usr/local/bin/slml2report "$@"

%apprun slml2info
    /usr/local/bin/slml2info "$@"

%apprun slml2slml
    /usr/local/bin/slml2slml "$@"
