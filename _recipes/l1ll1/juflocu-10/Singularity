Bootstrap: shub
From: Characterisation-Virtual-Laboratory/CharacterisationVL-Software:1804-cuda10.1

%labels
MAINTAINER chris.hines@monash.edu

%files
jupyter_start /start
jupyter_params.py /params

%post
#export LC_ALL=en_AU.UTF-8
#export LANGUAGE=en_AU.UTF-8
#export DEBIAN_FRONTEND=noninteractive

cat << EOF > /etc/apt/sources.list.d/au_archive_ubuntu_com_ubuntu.list
deb http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse
EOF

apt -y update
apt -y upgrade
apt install -y python3-dev
apt -y install sudo
apt -y install curl
apt -y install python2.7-dev
apt install -y python3-pip
apt -y install python3-venv
apt install -y pandoc
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt -y update
apt -y upgrade
apt -y install nodejs
apt -y install texlive-xetex
apt -y install pandoc
apt -y install python3-pypandoc python3-pandocfilters

curl https://swift.rc.nectar.org.au/v1/AUTH_810/CVL-Singularity-External-Files/cudnn-10.1-linux-x64-v7.6.5.32.tgz -o /tmp/cudnn.tgz
cd /usr/local
tar zxf /tmp/cudnn.tgz


mkdir -p /opt/
python3 -m venv /opt/jupyter
. /opt/jupyter/bin/activate
pip3 install --upgrade pip
pip3 install jupyterlab
pip3 install pandas
pip3 install bokeh
pip3 install bokeh-plot
pip3 install jupyter-bokeh
pip3 install scipy
pip3 install tensorflow-gpu
pip3 install modin[ray]
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @bokeh/jupyter_bokeh

