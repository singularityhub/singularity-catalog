Bootstrap: docker
From: alpine:latest

%setup
	cp *.sh /tmp/


%post
    apk add emacs
    apk add nodejs
    apk add npm
	apk add bash
	
    npm install -g typescript @types/node ts-node
    npm install -g typedoc jsdoc
    npm install -g yarn
    yarn global add tslint

	cd /tmp
	bash /tmp/emacs_setupTypeScriptEnvironment.sh

%runscript
    emacs -nw $1
