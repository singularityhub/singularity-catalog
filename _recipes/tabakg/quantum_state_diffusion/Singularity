BootStrap: docker
From: tabakg/quantum_state_diffusion

%runscript

    exec /usr/local/anaconda3/bin/python /code/make_quantum_trajectory.py "$@"


%post

    mkdir -p /share/PI
    mkdir -p /scratch
    mkdir -p /local-scratch
    sudo chmod -R 777 /data
    echo "To run, ./qsd.img --help"
