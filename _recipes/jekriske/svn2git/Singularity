BootStrap: docker
From: alpine:latest

%post
  echo http://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories
  echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
  apk --no-cache add man openssh-client git git-doc git-subtree git-subtree-doc git-svn perl-git-svn git-perl subversion ruby git-bash-completion git-fast-import openssl jq
  gitlfs_version=`wget -qO- 'https://raw.githubusercontent.com/git-lfs/git-lfs/master/versioninfo.json' | jq -r '.StringFileInfo.ProductVersion'`
  wget -qO- https://github.com/git-lfs/git-lfs/releases/download/v${gitlfs_version}/git-lfs-linux-amd64-${gitlfs_version}.tar.gz | tar -xz
  mv git-lfs*/git-lfs /usr/bin/ && rm -rf git-lfs-* && git lfs install
  apk del jq
  gem install svn2git --no-ri --no-rdoc

%apprun git
  exec git "$@"

%apprun svn
  exec svn "$@"

%apprun svn2git
  exec svn2git "$@"

%runscript
  exec svn2git "$@"

%help
  For help use --help
