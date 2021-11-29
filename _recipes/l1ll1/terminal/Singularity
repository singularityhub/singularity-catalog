Bootstrap: docker
From: ubuntu:18.04

%labels
MAINTAINER chris.hines@monash.edu

%files
smux.sbatch /start
params_cmd.py /params_cmd.py
params_exit.sh /params
watchdog.py /watchdog.py
shell_cmd.js /shell_cmd.js

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
apt install -y python3-pip
apt -y install python3-venv
curl -sL https://deb.nodesource.com/setup_8.x | bash -
#apt -y update
#apt -y upgrade
apt -y install nodejs
apt -y install gcc g++ make
#apt -y install npm
apt -y install tmux
apt -y install ruby-dev
apt -y install git
apt -y install python3-psutil
mkdir -p /opt/
cd /opt
git clone https://github.com/OSC/ood-shell.git shell
cd shell
git checkout tags/v1.4.2
npm config set unsafe-perm true
node --version
echo $HOME
export HOME=/tmp
./bin/setup
cp /shell_cmd.js /opt/shell
#npm install ws
#npm install express
