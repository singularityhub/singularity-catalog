Bootstrap: docker
From: alpine:3.6

%runscript

exec echo "The runscript is the containers default runtime command!"

%labels
AUTHOR ludd@cbs.dtu.dk

%post

# OS Update & Upgrade
apk update && apk upgrade

# Install packages
apk add \
  git \
  python \
  py-pip

# Clone git repo and remove git repo
git clone https://github.com/ldynia/containerized-workshop
mv /containerized-workshop/app /app
rm -rf /containerized-workshop

# Execute script as a global program
ln -s /app/main.py /usr/local/bin/fsa-analyzer
chmod +x /usr/local/bin/fsa-analyzer

echo "The post section is where you can install, and configure your container."
