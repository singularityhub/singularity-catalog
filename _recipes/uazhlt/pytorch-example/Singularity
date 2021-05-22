Bootstrap:docker  
From:uazhlt/pytorch-example:pytorch-1.3.0

%labels
MAINTAINER myedibleenso

%setup
# commands to be executed on host outside container during bootstrap

%post
# commands to be executed inside container during bootstrap.
echo "Installing packages listed in requirements.txt using conda..."
while read requirement; do pip install $requirement; done < requirements.txt

%environment
# any environment variable you wish to make available to Singularity go here

%runscript
# commands to be executed when the container runs

%test
# commands to be executed within container at close of bootstrap process
python --version
python -c 'import torch; print(f"PyTorch v{torch.__version__}")'

%post  
# this section executes after bootstrapping the image.
echo "Running 'post' commands..."  
#mkdir -p /output
 
