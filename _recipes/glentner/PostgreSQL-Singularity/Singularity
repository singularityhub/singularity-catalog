Bootstrap: docker
From: ubuntu:latest

%labels
	Maintainer glentner@purdue.edu

%post
	export DEBIAN_FRONTEND=noninteractive
	apt-get update && apt-get upgrade --yes
	apt-get install -y software-properties-common openssh-client

	add-apt-repository ppa:timescale/timescaledb-ppa
	apt-get update
	apt-get install -y timescaledb-postgresql-12

	mkdir -p /scratch /depot /apps
	chmod -R +rx /etc/ssl/private
	chmod -R +r  /etc/postgresql

%environment
	export LANG=C
	export PATH=$PATH:/usr/lib/postgresql/12/bin

%runscript
	postgres -c config_file=/etc/postgresql/12/main/postgresql.conf "$@"
