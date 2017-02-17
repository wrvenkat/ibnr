#!/bin/bash

if ! type git; then
    sudo apt-get install git -y
fi

release="$(lsb_release --release | awk '{print $2}')"

if [ "$release" == "14.10" ] || [ "$release" == "15.04" ] || [ "$release" == "15.10" ]; then
    release="14.04"
elif [ "$release" == "16.10" ] || [ "$release" == "17.04" ]; then
    release="16.04"
fi

git clone https://github.com/wrvenkat/ibnr.git && cd ibnr && chmod +x install &&\
    git clone https://github.com/wrvenkat/bash_helper_scripts.git && cd bash_helper_scripts && chmod +x *.sh && cd .. &&\
    git clone https://github.com/wrvenkat/ibnr-conf.git && cd ibnr-conf && git checkout "$release" && cd .. &&\
    git clone https://github.com/wrvenkat/install_scripts.git && cd install_scripts && git checkout "$release" && chmod +x *.sh && cd ..
