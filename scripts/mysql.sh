#!/bin/sh

red='\033[0;31m'
green='\033[0;32m'
white='\033[0;37m'

if ! lsmod | grep 'vboxdrv' > /dev/null
then
    echo "loading vboxdrv"
    sudo modprobe vboxdrv
else
    echo -e "${green}vboxdrv allready running ${white}"
fi


if ! ps ax | grep -v grep | grep 'Ubuntu Server' > /dev/null
then
    echo "starting UbuntuServer"
    VBoxHeadless -s "Ubuntu Server" &
    sleep 1
else
    echo -e "${green}VM allready running${white}"
fi


ssh -p 2222 hassan@localhost

read -p "Do you want to shutdown the mashine?[Y/N]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${red}shutting down Ubuntu Server${white}"
    VBoxManage controlvm "Ubuntu Server" acpipowerbutton
fi
