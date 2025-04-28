#!/bin/bash

#ask the user if they are having issues with RPM
echo "Are you having issues with RPM/DNF tools?"  
read -p "[Y]es/ [N]o/ [C]ancel): " confirm 

#If yes then rebuildrpm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
    sudo echo
    sudo rpm --rebuilddb --verbose
    echo "Do you want to continue?"  
    read -p "[Y]es/ [N]o: " confirm 
    
    #IF yes then continue
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
        then
        continue
    else
        exit
    fi
fi

#ask the user if they are having issues with Rdistro syncing
echo "Are you having issues with distro syncing?" 
read -p "[Y]es/ [N]o/ [C]ancel): " confirm 

#If yes then rebuildrpm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
    sudo echo
    sudo dnf distro-sync --allowerasing --verbose
    echo "Do you want to continue?" 
    read -p "[Y]es/ [N]o: " confirm 
    
    #IF yes then continue
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
        then
        continue
    else
        exit
    fi
fi

#ask the user if they are having issues with SELinux
echo "Are you having issues with SELinux?" 
read -p "[Y]es/ [N]o/ [C]ancel): " confirm 

#If yes then rebuildrpm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
    sudo echo
    sudo fixfiles -B onboot --verbose
    echo "Thank you for using this program"
    exit
else
    exit
    
fi

