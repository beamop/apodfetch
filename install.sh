#!/bin/bash
# by Beam OP <git[at]bmop.me>

green="\033[0;92m"
nocolor="\033[0m"
dir=${PWD}

echo -e "${green}[apodfetch] The script will install all dependencies, please wait...${nocolor}"

cd /tmp
sudo apt install imagemagick jq
git clone https://github.com/stefanhaustein/TerminalImageViewer.git
cd TerminalImageViewer/src/main/cpp/
make
sudo make install
sudo cp ${dir}/apodfetch.sh /usr/local/bin/apodfetch

echo -e "${green}[apodfetch] All done, now you can use apodfetch!"

exit 1
