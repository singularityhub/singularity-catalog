BootStrap: docker
From: continuumio/miniconda3

%files

    framework/ /tmp
    faoinput/ /tmp
    datetimefilter/ /tmp
    pathfilter/ /tmp
    nasainput /tmp
    run-workflow-stage.sh /usr/local/bin/

%environment
    export PYTHONPATH=/usr/local/lib/python3.7/dist-packages:/usr/lib/python3/dist-packages:$PYTHONPATH
    export PATH=/opt/conda/bin:/opt/conda/envs/faoinput/bin:/opt/conda/envs/datetimefilter/bin:/opt/conda/envs/nasainput/bin:/opt/conda/envs/pathfilter/bin:$PATH

%post

    apt-get update && apt-get -y install python3-pip wget curl

    cd /tmp/framework && pip3 install .

    chmod -R go+rX /usr/local/lib/python3.7/dist-packages

    chmod a+x /usr/local/bin/run-workflow-stage.sh

    chmod a+x /usr/local/bin/merge.py

    chmod a+x /usr/local/bin/collect.py

    chmod a+x /usr/local/bin/gen-keypair.py

    export PATH=/opt/conda/bin:$PATH
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

    conda create --name faoinput python=3.7

    cd /tmp/faoinput && conda install -n faoinput pip && conda run -n faoinput /opt/conda/envs/faoinput/bin/pip install .

    conda create --name datetimefilter python=3.7
    
    cd /tmp/datetimefilter && conda install -n datetimefilter pip && conda run -n datetimefilter /opt/conda/envs/datetimefilter/bin/pip install .

    conda create --name pathfilter python=3.7
    
    cd /tmp/pathfilter && conda install -n pathfilter pip && conda run -n pathfilter /opt/conda/envs/pathfilter/bin/pip install .

    conda create --name nasainput python=3.7

    cd /tmp/nasainput && conda install -n nasainput pip && conda run -n nasainput /opt/conda/envs/nasainput/bin/pip install .
