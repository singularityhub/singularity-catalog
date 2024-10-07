Bootstrap: docker
From: python:3.11

%post
    mkdir -p /app
    pip install -r /app/requirements.txt

%files
    requirements.txt /app/requirements.txt

%runscript
    exec python /app/main.py --batch-size 128 --epochs 1
