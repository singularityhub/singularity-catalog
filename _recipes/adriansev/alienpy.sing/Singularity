Bootstrap: docker
From: adriansevcenco/alienpy.dock:latest

%labels
    Author Adrian.Sevcenco@spacescience.ro
    Description self-contained distribution of alienpy ALICE GRID client

%runscript
exec python3 /usr/local/lib/python3.9/site-packages/alienpy/alien.py "${@}"

