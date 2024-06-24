#This is a dockerfile that sets up a full Gym install with test dependencies
Bootstrap: docker

# Here we ll build our container upon the pytorch container
From: pytorch/pytorch:1.0-cuda10.0-cudnn7-runtime

# Now we'll copy the mjkey file located in the current directory inside the container's root
# directory
%files
        mjkey.txt

# Then we put everything we need to install
%post
        export PATH=$PATH:/opt/conda/bin
        apt-get -y update && \
        apt-get install -y keyboard-configuration && \
        apt-get install -y \
        python3-dev \
        python-pyglet \
        python3-opengl \
        libhdf5-dev \
        libjpeg-dev \
        libboost-all-dev \
        libsdl2-dev \
        libosmesa6-dev \
        patchelf \
        ffmpeg \
        xvfb \
        libhdf5-dev \
        openjdk-8-jdk \
        wget \
        git \
        unzip && \
        apt clean && \
        rm -rf /var/lib/apt/lists/*

        pip install h5py

        # Download Gym and Mujoco
        mkdir /Gym && cd /Gym
        git clone https://github.com/openai/gym.git || true && \
        mkdir /Gym/.mujoco && cd /Gym/.mujoco
        wget https://www.roboti.us/download/mjpro150_linux.zip  && \
        unzip mjpro150_linux.zip && \
        wget https://www.roboti.us/download/mujoco200_linux.zip && \
        unzip mujoco200_linux.zip && \
        mv mujoco200_linux mujoco200

        # Export global environment variables
        export MUJOCO_PY_MJKEY_PATH=/Gym/.mujoco/mjkey.txt
        export MUJOCO_PY_MUJOCO_PATH=/Gym/.mujoco/mujoco200/
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Gym/.mujoco/mjpro150/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Gym/.mujoco/mujoco200/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/bin
        cp /mjkey.txt /Gym/.mujoco/mjkey.txt

        # Install python dependencies
        wget https://raw.githubusercontent.com/openai/mujoco-py/master/requirements.txt
        pip install -r requirements.txt

        # Install Gym and Mujoco
        cd /Gym/gym
        pip install -e '.[all]'

        # Change permission to use mujoco_py as non sudoer user
        chmod -R 777 /opt/conda/lib/python3.6/site-packages/mujoco_py/
        pip install --upgrade minerl

        # install the prob_mbrl code
        conda install qt matplotlib ipython jupyter
        cd /usr/local
        git clone https://github.com/mcgillmrl/prob_mbrl
        cd prob_mbrl
        pip install -e .

        mkdir /dataset
        mkdir /tmp_log
        mkdir /final_log
        chmod -R 777 /dataset
        chmod -R 777 /tmp_log
        chmod -R 777 /final_log

# Export global environment variables
%environment
        export SHELL=/bin/sh
        export MUJOCO_PY_MJKEY_PATH=/Gym/.mujoco/mjkey.txt
        export MUJOCO_PY_MUJOCO_PATH=/Gym/.mujoco/mujoco200/
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Gym/.mujoco/mjpro150/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Gym/.mujoco/mujoco200/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/bin
        export PATH=/Gym/gym/.tox/py3/bin:$PATH
%runscript
        exec /bin/sh "$@"

