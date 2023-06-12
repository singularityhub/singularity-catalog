Bootstrap: docker
From:biocontainers/blast

%runscript

  # No arguments, tell user what is available
  if [ $# -eq 0 ]; then
    echo "\nThis container provides the following executables:"
    ls /opt/conda/bin
    echo "\nExample usage: blastx.img blast [args] [options]"  
  else
    exec /opt/conda/bin/"$@"
  fi
