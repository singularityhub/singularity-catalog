Bootstrap: docker
From: alpine:edge

%labels
    AUTHOR icaoberg
    EMAIL icaoberg@psc.edu
    WEBSITE http://www.andrew.cmu.edu/~icaoberg
    VERSION 2.0.2-r3

%post
    apk update
    apk search asciinema-2.0.2-r3

####################################################################################
%appinstall asciinema

%apphelp asciinema

%apprun asciinema
