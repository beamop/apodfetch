#!/bin/bash
# by Beam OP <beamop[at]pm.me>

green="\033[0;92m"
apiKey="" # get yours at https://api.nasa.gov
apiUrl="https://api.nasa.gov/planetary/apod?api_key=$apiKey"
getUrl=$(curl -s "${apiUrl}" | jq '.hdurl')

checkConnection() {
    if [[ "$(ping -c 1 1.1.1.1 | grep '100% packet loss' )" != "" ]]; then
        checkConnection=0
    else
        checkConnection=1
    fi
}

showAPOD() {
    if [ "$checkConnection" == 0 ]; then
        clear
        echo "${green}[apodfetch] Not connected to Internet ☹"
        exit 1
    elif [ "$checkConnection" == 1 ]; then
        clear
        tiv -h 60 -w 60 "${getUrl:1:-1}"
        exit 1
    fi
}

checkConnection
showAPOD
