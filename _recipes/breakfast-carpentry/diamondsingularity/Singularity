Bootstrap: docker
From: ubuntu

%post
    apt-get update
    apt-get install -y python3

%files
   script.py /tmp

%runscript
   python3 /tmp/script.py

