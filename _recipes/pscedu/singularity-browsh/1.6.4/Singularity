Bootstrap: docker
From: alpine:latest

%labels
    AUTHOR icaoberg
    EMAIL icaoberg@alumni.cmu.edu
    WEBSITE http://www.andrew.cmu.edu/~icaoberg
    VERSION 1.6.4

%post
    apk update
    apk add dpkg wget firefox
    wget https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_386
    mv browsh_1.6.4_linux_386 /usr/local/bin/browsh && chmod +x /usr/local/bin/browsh

####################################################################################
%apphelp browsh
    browsh --help

%apprun browsh
    browsh "$@"

####################################################################################
%apphelp lynx
    lynx --help

%apprun lynx
    lynx "$@"
