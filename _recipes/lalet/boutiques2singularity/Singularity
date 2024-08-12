BootStrap: docker
From: boutiques/boutiques

%post
  pip install coveralls pytest pytest-runner boutiques
  pip install simplejson jsonschema gitpython PyGithub

%runscript
  bosh -h
