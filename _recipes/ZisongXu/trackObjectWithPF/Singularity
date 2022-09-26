bootstrap:docker
From:ubuntu:20.04

%labels

AUTHOR Rafael Papallas (rpapallas.com)

%environment
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
    export LD_LIBRARY_PATH="/home/.mujoco/mjpro200/bin:$LD_LIBRARY_PATH"

    ROS_ROOT=/opt/ros/noetic/share/ros
    export ROS_ROOT
    ROS_PACKAGE_PATH=/opt/ros/noetic/share:/opt/ros/noetic/stacks
    export ROS_PACKAGE_PATH
    ROS_MASTER_URI=http://localhost:11311
    export ROS_MASTER_URI
    LD_LIBRARY_PATH=/opt/ros/noetic/lib:/.singularity.d/libs
    export LD_LIBRARY_PATH
    CPATH=/opt/ros/noetic/include
    export CPATH
    PATH=/opt/ros/noetic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    export PATH
    PYTHONPATH=/opt/ros/noetic/lib/python2.7/dist-packages
    export PYTHONPATH
    PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig
    export PKG_CONFIG_PATH
    CMAKE_PREFIX_PATH=/opt/ros/noetic
    export CMAKE_PREFIX_PATH
    ROS_ETC_DIR=/opt/ros/noetic/etc/ros
    export ROS_ETC_DIR
%files
  scripts /scripts

%post
  /scripts/post_script.sh

%runscript
  exec /bin/bash "$@" --rcfile /scripts/run_script.sh
