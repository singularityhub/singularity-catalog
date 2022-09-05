Bootstrap: docker

From: python:3

%files
watchperf.py /

%post
    cd /    
    python3 -m pip install ntplib python-dateutil tabulate

%runscript
    exec python3 /watchperf.py "$@"

