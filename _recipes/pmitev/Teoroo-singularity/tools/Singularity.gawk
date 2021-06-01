Bootstrap:  docker
From: alpine

%runscript
  /usr/bin/gawk "$@"
%setup
%files
%environment
%labels
%post
  apk --no-cache --update add gawk
