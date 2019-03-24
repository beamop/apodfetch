#!/bin/bash
# by Beam OP <beamop[at]pm.me>

green="\033[0;92m"
apiKey="" # get yours at https://api.nasa.gov
apiUrl="https://api.nasa.gov/planetary/apod?api_key=${apiKey}"
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
        echo -e "${green}[apodfetch] Not connected to Internet ☹"
        exit 1
    elif [ "$checkConnection" == 1 ]; then
        if [ "$getUrl" == null ]; then
            clear
            getUrl=$(curl -s "${apiUrl}" | jq '.url')
            videoId="${getUrl#*/embed/}"
            videoThumbnailUrl="https://images.weserv.nl/?url=https://i3.ytimg.com/vi/${videoId:0:-7}/maxresdefault.jpg"
            tiv -h 60 -w 60 "${videoThumbnailUrl}"
            exit 1
        else
            clear
            tiv -h 60 -w 60 "${getUrl}"
            exit 1
        fi
    fi
}

checkConnection
showAPOD
