BootStrap: docker
From: alpine:latest

%post
  echo http://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories
  echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
  apk --no-cache add man openssh-client git git-doc git-subtree git-subtree-doc git-bash-completion git-fast-import openssl jq
  gitlfs_version=`wget -qO- 'https://raw.githubusercontent.com/git-lfs/git-lfs/master/versioninfo.json' | jq -r '.StringFileInfo.ProductVersion'`
  wget -qO- https://github.com/git-lfs/git-lfs/releases/download/v${gitlfs_version}/git-lfs-linux-amd64-${gitlfs_version}.tar.gz | tar -xz
  mv git-lfs*/git-lfs /usr/bin/ && rm -rf git-lfs-* && git lfs install
  apk del jq

%apprun git
  exec git "$@"

%runscript
  exec git "$@"

%help
  For help use --help
