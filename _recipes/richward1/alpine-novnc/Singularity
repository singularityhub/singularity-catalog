bootstrap: docker
from: alpine

%files -p
	launch.sh /launch.sh

%post
	apk add --update \
	xvfb \
	fluxbox \
	tmux \
	x11vnc \
	st \
	xterm \
	chromium \
	git \
	python \
	procps \
	desktop-file-utils\
	gtk-engines \
	consolekit \
	gtk-murrine-engine \
	caja \
	caja-extensions \
	marco \
	dbus \
	dbus-x11 \
	lxdm \
	udev \
	hicolor-icon-theme \
	sudo && \
	mate_pkgs=$(apk search mate -q | grep -v '\-dev' | grep -v '\-lang' | grep -v '\-doc') && \
	apk add $mate_pkgs && \
	echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
	chmod 777 /launch.sh

###Websockify###
%post	
	apk add \
	gfortran \
	python \
	python-dev \
	py-pip \
	build-base && \
	pip install numpy && \
	cd / && \
	wget https://github.com/novnc/websockify/archive/v0.9.0.zip && \
	unzip /v0.9.0.zip && \
	rm /v0.9.0.zip && \
	cd /websockify-0.9.0 && \
	python setup.py install
	
###noVNC###
%post
	cd / && \
	wget https://github.com/novnc/noVNC/archive/v1.1.0.zip && \
	unzip v1.1.0.zip && rm v1.1.0.zip

%runscript
	/./launch.sh
