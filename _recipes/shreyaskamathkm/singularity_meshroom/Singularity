Bootstrap: docker
From: nvidia/cuda:10.1-base-centos7



%files
./requirements.txt /meshroom/
./files/Meshroom-2020.1.0-linux-cuda10.tar.gz /opt/



%post
yum install -y gcc python3-devel wget python3-pip python3 \
&& pip3 install --user -r /meshroom/requirements.txt \
&& yum remove -y gcc

%post
cd /opt && tar zxf Meshroom-2020.1.0-linux-cuda10.tar.gz && rm Meshroom-2020.1.0-linux-cuda10.tar.gz

yum install -y yum-utils && yum-config-manager --add-repo \
https://download.docker.com/linux/centos/docker-ce.repo && \
yum install -y docker-ce-cli

%files
./files/github/* /meshroom/
./files/others/instant-meshes-linux/* /opt/Meshroom-2020.1.0/aliceVision/bin/
./files/others/meshroom_external_plugins-master/* /opt/Meshroom-2020.1.0/lib/meshroom/nodes/aliceVision/


%post
cp /meshroom/meshroom/nodes/aliceVision/* /opt/Meshroom-2020.1.0/lib/meshroom/nodes/aliceVision/ \
&& cp /meshroom/bin/* /meshroom \
&& chmod 755 /meshroom/meshroom_*


PATH="/opt/Meshroom-2020.1.0:/meshroom:${PATH}"
PYTHONPATH="$PYTHONPATH:/opt/Meshroom-2020.1.0"

%environment
export PATH="/opt/Meshroom-2020.1.0:/meshroom:${PATH}"
export PYTHONPATH="$PYTHONPATH:/opt/Meshroom-2020.1.0"


