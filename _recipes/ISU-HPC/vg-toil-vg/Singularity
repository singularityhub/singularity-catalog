Bootstrap: docker
from: quay.io/vgteam/vg:v1.13.0

%labels

MAINTAINER ynanyam@iastate.edu

%enviroment
LC_ALL=C
export LC_ALL

%post

apt-get update -y
apt-get install -y python-pip python-virtualenv

# Install toil and toil-vg
cd /opt
virtualenv toil-vg
. toil-vg/bin/activate
pip install toil[aws,mesos]==3.18.0
pip install toil-vg
echo "export PATH=/vg/bin:/vg/scripts:/opt/toil-vg/bin:$PATH" >>$SINGULARITY_ENVIRONMENT
