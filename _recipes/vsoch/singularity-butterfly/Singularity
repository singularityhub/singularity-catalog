BootStrap: docker
From: ubuntu:latest

%runscript


butterfly.server.py --generate-user-pkcs=$USER 
nohup /opt/firefox52/firefox localhost:7777 & exec butterfly.server.py --port=7777 --unsecure
#butterfly.server.py --host=localhost --port=7777


%post

export LC_ALL="en.utf-8"
DEBIAN_FRONTEND=noninteractive
LANGUAGE=en_US
LANG=en_US.UTF-8
BASE=/

apt-get update && apt-get install -y language-pack-en-base \
                  git wget cmake build-essential vim curl \
                  libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev \
                  libdbus-glib-1-2 libxt-dev unity-gtk3-module libcanberra-gtk3-module


# Install python?
apt-get install -y python3 python3-dev
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
rm get-pip.py

# Install python (anaconda)
#wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
#bash Anaconda3-4.2.0-Linux-x86_64.sh -b
#rm Anaconda2-4.2.0-Linux-x86_64.sh

apt-get install -y libgcr-3-dev libatk-adaptor libgail-common libcanberra-gtk-module
apt-get update && apt-get install -y gir1.2-zeitgeist-2.0 zeitgeist-2.0 libnss3

# Install Firefox
cd $BASE
wget https://ftp.mozilla.org/pub/firefox/releases/52.0/linux-x86_64/en-US/firefox-52.0.tar.bz2
tar -vxjf firefox-52.0.tar.bz2
mv firefox /opt/firefox52
mkdir -p /opt/firefox52/browser/defaults
echo "user_pref(\"browser.startup.homepage\", \"http://localhost:57575\");" >> /opt/firefox52/browser/defaults/prefs.js

# Certutils to add certificates (not using, but maybe)
cd $BASE
wget http://launchpadlibrarian.net/211106554/libnss3-tools_3.19.2-1ubuntu1_amd64.deb
dpkg -i libnss3-tools_3.19.2-1ubuntu1_amd64.deb

mkdir -p /run/user/1000
chmod -R 775 /run/user/1000

# Install butterfly
pip install butterfly[systemd]

cd /etc/systemd/system
curl -O https://raw.githubusercontent.com/paradoxxxzero/butterfly/master/butterfly.service
curl -O https://raw.githubusercontent.com/paradoxxxzero/butterfly/master/butterfly.socket
systemctl enable butterfly.socket
systemctl start butterfly.socket

butterfly.server.py --generate-certs --host="127.0.0.1"
cp /etc/butterfly/ssl/butterfly_ca.crt /etc/ssl/certs/butterfly_ca.crt
cp /etc/butterfly/ssl/butterfly_127.0.0.1.crt /etc/ssl/certs/butterfly_localhost.crt
update-ca-certificates
#certutil -A /etc/ssl/certs/butterfly_ca.crt -n Butterfly-Main -t "TCu,Cu,Tuw"

#butterfly.server.py --host=localhost --port=77777 &&
#butterfly.server.py --generate-certs --host=localhost
#butterfly.server.py --generate-user-pkcs=$USER
