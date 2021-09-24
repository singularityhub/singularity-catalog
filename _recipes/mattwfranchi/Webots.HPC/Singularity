Bootstrap: shub
From: docker://cyberbotics/webots:latest

%runscript
exec -B $TMPDIR:$TMPDIR webots_latest.sif webots

%files

%environment

%labels
	AUTHOR mwfranc@clemson.edu

%post
pip install pandas

echo "The post section is where you can install, and configure your container."
