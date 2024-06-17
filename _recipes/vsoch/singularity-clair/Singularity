From: golang:1.8-alpine
Bootstrap: docker

%setup
cp entrypoint.sh ${SINGULARITY_ROOTFS}/entrypoint.sh
mkdir -p ${SINGULARITY_ROOTFS}/etc/clair
cp config.yaml ${SINGULARITY_ROOTFS}/etc/clair/config.yaml

%environment
POSTGRES_PASSWORD=postgres
LANG=en_US.utf8
PGDATA=/var/lib/postgresql/data

%runscript
gosu postgres pg_ctl -D "$PGDATA" \
        -o "-c listen_addresses=''" \
        -w start

exec clair "$@"

%post

POSTGRES_PASSWORD=postgres
LANG=en_US.utf8
PGDATA=/var/lib/postgresql/data

export POSTGRES_PASSWORD LANG PGDATA

# Install Clair
apk add --no-cache git 
mkdir -p /usr/local/go/src/github.com/coreos
cd /usr/local/go/src/github.com/coreos && git clone https://github.com/coreos/clair

apk add --no-cache git bzr rpm xz
/usr/local/go/bin/go install -v github.com/coreos/clair/cmd/clair

# Install postgres for it
apk add --update curl
apk add --no-cache tzdata
apk add "libpq" "postgresql-client" "postgresql" "postgresql-contrib" 
mkdir /entrypoint-initdb.d
curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64"
chmod +x /usr/local/bin/gosu

mkdir -p $PGDATA
chmod u+x /entrypoint.sh
/bin/sh /entrypoint.sh
