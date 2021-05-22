BootStrap: docker
From: nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04

################################################################################
%labels
################################################################################
MAINTAINER Ovcharenko Group 

################################################################################
%environment
################################################################################
export PATH=/usr/local/sbin:/usr/sbin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/cuda/bin:
export PYTHONPATH=/usr/share/pdb2pqr:

################################################################################
%post
################################################################################

###
### install keras + tensorflow + other useful packages
###
apt-get update
apt-get install -y graphviz locales python python-pip git python-vtk pdb2pqr python-pandas zlib1g-dev
locale-gen en_US.UTF-8
apt-get clean

pip install --upgrade pip
pip install absl-py==0.10.0
pip install ansiwrap==0.8.4
pip install arrow==0.15.5
pip install astor==0.8.1
pip install attrs==19.3.0
pip install backports-abc==0.5
pip install backports.functools-lru-cache==1.6.1
pip install backports.shutil-get-terminal-size==1.0.0
pip install backports.shutil-which==3.5.2
pip install backports.tempfile==1.0
pip install backports.weakref==1.0.post1
pip install bcolz==1.2.1
pip install binaryornot==0.4.4
pip install bleach==3.1.0
pip install boto==2.44.0
pip install cachetools==3.1.1
pip install certifi==2019.11.28
pip install chardet==3.0.4
pip install Click==7.0
pip install cloudpickle==1.2.2
pip install colorama==0.4.3
pip install configparser==4.0.2
pip install contextlib2==0.6.0.post1
pip install cookiecutter==1.7.0
pip install crcmod==1.7
pip install cryptography==1.7.1
pip install cycler==0.10.0
pip install daal==2019.0
pip install datalab==1.1.5
pip install decorator==4.4.1
pip install defusedxml==0.6.0
pip install entrypoints==0.3
pip install enum34==1.1.6
pip install funcsigs==1.0.2
pip install functools32==3.2.3.post2
pip install future==0.18.2
pip install futures==3.3.0
pip install gast==0.2.2
pip install gcsfs==0.2.3
pip install gitdb2==2.0.6
pip install GitPython==2.1.14
pip install h5py==2.10.0
pip install html5lib==1.0.1
pip install httplib2==0.17.0
pip install icc-rt==2020.0.133
pip install idna==2.8
pip install importlib-metadata==1.4.0
pip install intel-numpy==1.15.1
pip install intel-openmp==2020.0.133
pip install intel-scikit-learn==0.19.2
pip install intel-scipy==1.1.0
pip install ipaddress==1.0.17
pip install ipykernel==4.10.1
pip install ipython==5.8.0
pip install ipython-genutils==0.2.0
pip install ipython-sql==0.3.9
pip install ipywidgets==7.5.1
pip install jedi==0.16.0
pip install Jinja2==2.11.0
pip install jinja2-time==0.2.0
pip install jsonschema==3.2.0
pip install jupyter==1.0.0
pip install jupyter-aihub-deploy-extension==0.1
pip install jupyter-client==5.3.4
pip install jupyter-console==5.2.0
pip install jupyter-contrib-core==0.3.3
pip install jupyter-contrib-nbextensions==0.5.1
pip install jupyter-core==4.6.1
pip install jupyter-highlight-selected-word==0.2.0
pip install jupyter-http-over-ws==0.0.7
pip install jupyter-latex-envs==1.4.6
pip install jupyter-nbextensions-configurator==0.4.1
pip install Keras-Applications==1.0.8
pip install Keras-Preprocessing==1.1.2
pip install keyring==10.1
pip install keyrings.alt==1.3
pip install kiwisolver==1.1.0
pip install lxml==4.4.2
pip install Markdown==3.1.1
pip install MarkupSafe==1.1.1
pip install matplotlib==2.2.4
pip install mistune==0.8.4
pip install mkl==2019.0
pip install mkl-fft==1.0.6
pip install mkl-random==1.0.1.1
pip install mock==3.0.5
pip install monotonic==1.5
pip install nbconvert==5.6.1
pip install nbdime==1.1.0
pip install nbformat==4.4.0
pip install networkx==2.2
pip install nltk==3.4.5
pip install notebook==5.7.8
pip install numpy==1.16.6
pip install oauth2client==4.1.3
pip install oauthlib==3.1.0
pip install opencv-python==4.1.2.30
pip install opt-einsum==2.3.2
pip install pandas==0.24.2
pip install pandas-profiling==1.4.0
pip install pandocfilters==1.4.2
pip install papermill==1.2.1
pip install parso==0.6.0
pip install pathlib2==2.3.5
pip install pexpect==4.8.0
pip install pickleshare==0.7.5
pip install Pillow-SIMD==6.2.2.post1
pip install plotly==4.5.0
pip install poyo==0.5.0
pip install prettytable==0.7.2
pip install prometheus-client==0.7.1
pip install prompt-toolkit==1.0.15
pip install protobuf==3.11.2
pip install psutil==5.6.7
pip install ptyprocess==0.6.0
pip install pyarrow==0.15.1
pip install pyasn1==0.4.8
pip install pyasn1-modules==0.2.8
pip install pycrypto==2.6.1
pip install pydaal==2019.0.0.20180713
pip install pydot==1.4.1
pip install Pygments==2.5.2
pip install pygobject==3.22.0
pip install pyparsing==2.4.6
pip install pyrsistent==0.15.7
pip install python-dateutil==2.8.1
pip install pytz==2019.3
pip install PyWavelets==1.0.3
pip install pyxdg==0.25
pip install PyYAML==5.3
pip install pyzmq==18.1.1
pip install qtconsole==4.6.0
pip install requests==2.22.0
pip install requests-oauthlib==1.3.0
pip install retrying==1.3.3
pip install rsa==4.0
pip install scandir==1.10.0
pip install scikit-image==0.14.5
pip install scikit-learn==0.19.2
pip install scipy==1.1.0
pip install seaborn==0.9.1
pip install SecretStorage==2.3.1
pip install Send2Trash==1.5.0
pip install simplegeneric==0.8.1
pip install singledispatch==3.4.0.3
pip install six==1.14.0
pip install sklearn==0.0
pip install smmap2==2.0.5
pip install SQLAlchemy==1.3.13
pip install sqlparse==0.3.0
pip install subprocess32==3.5.4
pip install tbb==2019.0
pip install tbb4py==2019.0
pip install tenacity==6.0.0
pip install tensorboard==1.15.0
pip install tensorflow==1.15.0
pip install tensorflow-estimator==1.15.1
pip install tensorflow-gpu==1.15.0
pip install termcolor==1.1.0
pip install terminado==0.8.3
pip install testpath==0.4.4
pip install textwrap3==0.9.2
pip install tornado==5.1.1
pip install tqdm==4.42.0
pip install traitlets==4.3.3
pip install uritemplate==3.0.1
pip install urllib3==1.25.8
pip install virtualenv==16.7.9
pip install wcwidth==0.1.8
pip install webencodings==0.5.1
pip install Werkzeug==0.16.1
pip install whichcraft==0.6.1
pip install widgetsnbextension==3.5.1
pip install wrapt==1.12.1
pip install zipp==1.1.0
###
### destination for NIH HPC bind mounts
###
mkdir /gpfs /spin1 /gs2 /gs3 /gs4 /gs5 /gs6 /gs7 /gs8 /data /scratch /fdb /lscratch /pdb
