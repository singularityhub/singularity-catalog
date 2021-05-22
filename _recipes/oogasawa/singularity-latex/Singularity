BootStrap: docker
From: ubuntu:20.04

%labels
    Maintainer Osamu Ogasawara
        Version    v1.0


%setup
	cp *.sty /tmp/


%post
    echo "Hello from inside the container"
    apt-get -y update
    apt-get -y upgrade

    # Noninteractive install of tzdata
	# https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

    # Install platex, xelatex, etc.
	apt install -y texlive-science
	apt install -y texlive-lang-japanese
	apt install -y texlive-xetex
	apt install -y texlive-lang-cjk xdvik-ja evince
	apt install -y texlive-fonts-recommended texlive-fonts-extra

    # Copy additional style files
	# "How to deal with a long verbatim environment across page boundaries."
	# https://muscle-keisuke.hatenablog.com/entry/2016/02/11/195004
	cp /tmp/eclbkbox.sty  /usr/share/texmf/tex/latex
	cp /tmp/emathC.sty  /usr/share/texmf/tex/latex
	cp /tmp/itembbox.sty  /usr/share/texmf/tex/latex
	cp /tmp/itembkbx.sty  /usr/share/texmf/tex/latex
	cp /tmp/jquote.sty  /usr/share/texmf/tex/latex
	mktexlsr

	# Install pandoc document converter.
	apt install -y pandoc
