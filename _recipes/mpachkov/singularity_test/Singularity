Bootstrap: shub
From: singularityhub/ubuntu

%runscript
    exec echo "The runscript is the containers default runtime command!" && cat /opt/mytest/test.txt

%files
   
%environment
    VARIABLE=MEATBALLVALUE
    export VARIABLE

%labels
   AUTHOR mike

%post
    mkdir -p /opt/mytest
    echo 'Mike: MyTest!!!' > /opt/mytest/test.txt
