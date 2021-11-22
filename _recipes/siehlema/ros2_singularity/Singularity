# Singularity definition file for ROS2 container
Bootstrap: docker
From: ubuntu:bionic

%setup
        # Create folders if needed

%files
        # Copy local files to folder if needed

%post
        # Set Timezone
        echo 'Europe/Berlin' > /etc/timezone && \
        ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
        apt-get update && apt-get install -q -y tzdata && rm -rf /var/lib/apt/lists/*
        
        # Install basic dependencies
        apt-get update && apt-get install -q -y \
        bash-completion \
        dirmngr \
        git \
        gnupg2 \
        libasio-dev \
        libtinyxml2-dev \
        lsb-release \
        python3-pip \
        wget \
        && rm -rf /var/lib/apt/lists/*
        
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
        
        echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros2-latest.list
        
        apt-get update && apt-get install -y --no-install-recommends \
        python3-catkin-pkg-modules \
        python3-colcon-common-extensions \
        python3-rosdep \
        python3-vcstool \
        && rm -rf /var/lib/apt/lists/*
        
        pip3 install -U \
        argcomplete \
        flake8 \
        flake8-blind-except \
        flake8-builtins \
        flake8-class-newline \
        flake8-comprehensions \
        flake8-deprecated \
        flake8-docstrings \
        flake8-import-order \
        flake8-quotes \
        pytest-repeat \
        pytest-rerunfailures
        
        export ROSDISTRO_INDEX_URL=https://raw.githubusercontent.com/ros/rosdistro/master/index.yaml
        
        rosdep init && rosdep update
        
        export ROS2_WS=/opt/ros2_ws
        mkdir -p $ROS2_WS/src
        cd $ROS2_WS
        
        wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos \
        && vcs import src < ros2.repos
        
        apt-get update && rosdep install -y \
        --from-paths src \
        --ignore-src \
        --rosdistro dashing \
        --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers" \
        && rm -rf /var/lib/apt/lists/*
        
        colcon build \
        --cmake-args -DSECURITY=ON --no-warn-unused-cli \
        --symlink-install

%environment
        # set locale
        export LANG=C.UTF-8
        export LC_ALL=C.UTF-8
        
        # Set default RMW if needed
        # export RMW_IMPLEMENTATION=rmw_opensplice_cpp

%apprun example_talker
        bash -c "cd /opt/ros2_ws && . install/local_setup.sh && ros2 run demo_nodes_cpp talker"

%apprun example_listener
        bash -c "cd /opt/ros2_ws && . install/local_setup.sh && ros2 run demo_nodes_cpp listener"
