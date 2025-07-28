Bootstrap: docker
From: python:3.11-slim

%post
    apt-get update && apt-get install -y build-essential git
    pip install --upgrade pip
    pip install -r /app/requirements.txt

%files
    requirements.txt /app/requirements.txt
    src/ /app/src/
    scripts/ /app/scripts/

%environment
    export PYTHONPATH=/app/src

%runscript
    exec python /app/scripts/run_cosine.py "$@"