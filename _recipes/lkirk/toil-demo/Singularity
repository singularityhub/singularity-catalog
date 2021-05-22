Bootstrap: docker
From: python:3.8-slim

%files
    demo /opt/toil_demo/demo
    setup.py /opt/toil_demo/setup.py


%post
	set -e

	# Install Deps
	apt-get update
	apt-get install -y --no-install-recommends \
		gcc \
		libc6-dev \
		locales \
		libssl-dev \
		libffi-dev

	# Fix locale
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	locale-gen en_US.utf8
	/usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

	# install packages
	pip install --upgrade --no-cache-dir pip setuptools
	pip install --upgrade --no-cache-dir /opt/toil_demo

%runscript
	python -m demo.workflows.something
