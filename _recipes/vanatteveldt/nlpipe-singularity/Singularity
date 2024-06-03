Bootstrap: docker
From: vanatteveldt/alpino-server
Includecmd: no

%post
  apt-get -qq update && apt-get install -y python3-flask python3-pip python3-lxml libyaml-dev
  pip3 install "nlpipe>=0.51" typing
  
%startscript
  python3 /alpinoserver.py --host 0.0.0.0 --port 5002 --debug 


%apprun worker
  python3 -m nlpipe.worker "$@"

%apprun client
  python3 -m nlpipe.client "$@"
