Bootstrap: docker
From: python:3.7

%help
    EEGprep preprocessing container

%setup
    python setup.py sdist

%files
    dist/eegprep-0.1.tar.gz .

%post
    pip install numpy ipython
    pip install --no-cache-dir -U https://api.github.com/repos/mne-tools/mne-python/zipball/master#egg=mne
    pip install --no-cache-dir -U https://api.github.com/repos/autoreject/autoreject/zipball/master#egg=autoreject
    pip install eegprep-0.1.tar.gz

%runscript
    exec eegprep
