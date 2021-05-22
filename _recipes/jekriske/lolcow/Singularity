BootStrap: docker
From: busybox:latest
IncludeCmd: no

%labels
  Maintainer: Jeff Kriske

%help
  A low fat version of lolcow

%setup
    wget https://tukaani.org/xz/xz-5.2.3.tar.gz
    tar -xf xz-5.2.3.tar.gz
    cd xz-5.2.3 && ./configure && make && cd ..
    cp xz-5.2.3/src/xz/xz .
    export PATH=`pwd`:$PATH
    wget https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz
    tar -xf upx-3.94-amd64_linux.tar.xz upx-3.94-amd64_linux/upx --strip-components=1
    wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
    tar -xf go1.9.2.linux-amd64.tar.gz
    export PATH=`pwd`/go/bin:$PATH
    export GOROOT=`pwd`/go
    export GOPATH=`pwd`/go_tmp
    export CGO_ENABLED=0
    go get -ldflags="-s -w" -installsuffix cgo -u github.com/bmc/fortune-go
    mv go_tmp/bin/fortune-go fortune
    go get -ldflags="-s -w" -installsuffix cgo -u github.com/syohex/gowsay
    mv go_tmp/bin/gowsay cowsay
    go get -ldflags="-s -w" -installsuffix cgo -u github.com/cezarsa/glolcat
    mv go_tmp/bin/glolcat lolcat
    git clone https://github.com/shlomif/fortune-mod.git
    cd fortune-mod/fortune-mod/datfiles
    cat [a-z]* >> Fortunes || true
    mv Fortunes ../../../fortunes
    cd ../../../
    upx cowsay
    upx lolcat
    upx fortune
    rm -rf go* *.tar.[xg]z fortune-mod xz* upx .libs 

%apprun lolcat
  exec lolcat "$@"

%apprun cowsay
  exec cowsay "$@"

%apprun fortune
  exec fortune "$@"

%apprun lolcow
  fortune | cowsay | lolcat

%environment
    export FORTUNE_FILE=/fortunes

%runscript
    fortune | cowsay | lolcat

%files
   lolcat   /bin
   cowsay   /bin
   fortune  /bin
   fortunes /
