Bootstrap: docker
From: debian:10

%post
# non interactive debian
DEBIAN_FRONTEND=noninteractive \
apt-get update && apt-get -y install \
	apt-transport-https \
	ca-certificates \
	coreutils \
	curl \
	gnome-keyring \
	gnupg \
	libasound2 \
	libgtk-3-0 \
	libnotify4 \
	libnss3 \
	libsecret-1-0 \
	libxkbfile1 \
	libxss1 \
	libxshmfence1 \
	libx11-xcb1

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
apt-get update && \
apt-get -y install code \
	&& apt-get -y install -f \
	&& apt-get -y upgrade

%runscript
echo "Starting code in the container"
/usr/bin/code "$@"

