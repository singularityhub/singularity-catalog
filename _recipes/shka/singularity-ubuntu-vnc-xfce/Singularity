Bootstrap: library
From: ubuntu:20.04

%help
	This is a singularity container of a headless Ubuntu 20.04.
	See also https://github.com/shka/singularity-ubuntu-vnc-xfce .

%labels
	MAINTAINER "Shintaro KATAYAMA - https://github.com/shka"

%environment
	LANG=C.UTF-8
	export LANG

%files
	./*.sh /usr/local/bin

%post

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y software-properties-common
add-apt-repository universe
apt-get upgrade -y
apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common x11-xserver-utils xfonts-base xfce4 xfce4-goodies desktop-base tango-icon-theme thunar-volman xfce4-notifyd dbus-x11 novnc websockify python-numpy net-tools openssh-client gawk less at-spi2-core
apt-get clean -y
