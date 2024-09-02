Bootstrap: docker
From: ubuntu:14.04

%environment
PATH=$PATH:/enzo/bin
export PATH

%post

# Install vim and spack
apt-get update && apt-get install -y vim git wget
apt-get install -y python python-pip 
apt-get install -y gfortran g++
apt-get install -y libhdf5-serial-dev
apt-get install -y csh libcr-dev mpich2 
apt-get install -y  mpich2-doc mercurial

mkdir -p /data/jobs

# Download repo
git clone https://github.com/vsoch/enzo-simulation
mv enzo-simulation /code
chmod -R u+x /code/scripts

# Tell user python version
echo "Python version:"
python --version

# http://enzo-project.org/
cd / && wget https://bitbucket.org/enzo/enzo-dev/get/enzo-2.5.tar.bz2
mkdir enzo && tar xvjf enzo-2.5.tar.bz2 -C enzo --strip-components 1
cd enzo && ./configure # requires csh
cd /enzo/src/enzo

# What machine configurations are available?
# ls Make.mach.* 
# what version HDf5? 
# dpkg -l | grep hdf5

make machine-linux-gnu
make show-config
echo "Configuration with linux-gnu shown above."

%runscript

# Get job number
if [ $# -lt 1 ]; then
    echo "You must pass the job number."
    echo "Usage: singularity run -B /scratch/data:/data enzo.img 10"
    exit 1
else
    num="$1"
    case ${num} in
        -h|--help|-H)
            echo "Usage: singularity run -B /host/data:/data enzo.img [num]"
            echo "e.g.,  singularity run -B /scratch/data:/data enzo.img 10"
            exit 1;
        ''|*[!0-9]*) 
            echo "You must pass a number as the first argument."; exit 2;
        *) ;;
    esac
fi;

# Create the job directory, if doesn't exist
jobdir="/data/jobs/${num}"
if [ ! -d "${jobdir}" ]; then
    echo "Creating job directory ${num}"
    mkdir -p ${jobdir}
    cp -r /code/scripts/Init "${jobdir}"
fi

cd $jobdir
/bin/bash /code/scripts/job.pbs
