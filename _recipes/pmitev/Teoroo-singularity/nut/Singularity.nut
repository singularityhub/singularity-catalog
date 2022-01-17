Bootstrap:  docker
From: alpine:3.15

# recipe template https://github.com/instantlinux/docker-tools/blob/master/images/nut-upsd/Dockerfile 

%post
  export NUT_VERSION=2.7.4-r10

  echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing'  >>/etc/apk/repositories && \
  apk add --update nut@testing=$NUT_VERSION \
  libcrypto1.1 libssl1.1 musl net-snmp-libs

%runscript
  /bin/ash "$@"
