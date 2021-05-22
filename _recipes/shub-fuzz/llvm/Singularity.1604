Bootstrap: docker
From: registry.gitlab.com/fuzzing/directed-fuzzing/llvm-12:16.04

%labels
    MAINTAINER Josh Bundt
    DockerTagID 70554fa39

%environment
    AFL_SKIP_CPUFREQ=1
    LC_ALL=en_US.UTF-8
    LANG=en_US.UTF-8
    TMPDIR=/tmp
    export AFL_SKIP_CPUFREQ LC_ALL LANG TMPDIR

%post
    # In order to get locales working properly:
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    locale-gen --purge en_US.UTF-8
    dpkg-reconfigure --frontend=noninteractive locales

    echo ==== DONE ====
