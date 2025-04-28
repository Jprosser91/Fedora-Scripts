#########################################################################
#									                                                      #
#		Fedora Upgrade Task Script                                  				#
#									                                                      #
#   https://docs.fedoraproject.org/en-US/quick-docs/dnf-system-upgrade/	#
#									                                                      #
#	  By Justin Prosser                                           				#
#									                                                      #
#########################################################################

#!/bin/bash

echo "Made for fedora, check https://docs.fedoraproject.org/en-US/quick-docs/dnf-system-upgrade/ for latest instructions"

#########################################################################
#start script

echo "Welcome to the automated upgrade task script for Fedora"

#Verify/ install dnf-plugin-system-upgrade
echo "Verify/ install dnf-plugin-system-upgrade"
sudo dnf install dnf-plugin-system-upgrade -y

#Check Fedora releases for new version
#echo "Checking online to see if there is a new version" 
#curl "https://getfedora.org/releases.json" \ | jq ".[] | select(.version==\"${VERSION_ID}\" \ and .arch==\"$(uname -m)\" and .variant==\"${VARIANT_ID^}\")"
#if [ "${VERSION_ID}" -eq "${VERSION_GET}" ]; then exit 0; fi

#ask the user to input the version number
sudo echo
echo "You are currently on:"
cat /etc/fedora-release
cat /etc/fedora-release | grep -o -E "[0-9]+" > Version_Number.txt
VER=$( cat Version_Number.txt )

#ask what the user wants to do
echo "Do you want to upgrade to $((VER+1))?, downgrade to $((VER-1))?, or neither?"
read -p "Continue? (U/D/N): " confirm && [[ $confirm == [uU] || $confirm == [uU][pP][gG][rR][aA][dD][eE] ]]

#IF comfirm = upgrade then upgrade to the version passed to VER
if [[ $confirm == [uU] || $confirm == [uU][pP][gG][rR][aA][dD][eE] ]]
  then
  sudo echo
  echo "Pre-checking DNF for version upgrades"
  sudo dnf upgrade --refresh

  echo "Setting version to $((VER+1))"
  VER=$((VER+1))
  sudo dnf system-upgrade download --releasever=$VER --allowerasing -y 
  
  echo "Checking DNF for version upgrades"
  sudo dnf upgrade --refresh
  continue

#IF comfirm = downgrade then downgrade to the version passed to VER
elif [[ $confirm == [dD] || $confirm == [dD][oO][wW][nN][gG][rR][aA][dD][eE] ]]
  then
  sudo echo
  echo "Pre-checking DNF for version downgrades"
  sudo dnf upgrade --refresh --allow-downgrade
  sudo dnf downgrade --skip-broken --skip-unavailable --allowerasing spec -y 

  echo "Setting downgrade version to $((VER-1))"
  VER=$((VER-1))
  sudo dnf system-upgrade download --releasever=$VER --allowerasing -y
  
  echo "Checking DNF for version downgrades"
  sudo dnf upgrade --refresh --allow-downgrade --offline --allowerasing
  sudo dnf downgrade --skip-broken --skip-unavailable --allowerasing spec -y 
  continue

#IF comfirm = Neither then ask if there is a specific version or else exit
elif [[ $confirm == [nN] || $confirm == [nN][eE][iI][tT][hH][eE][rR] ]]
  then
  sudo echo
  echo "Do you want to go to a specific version"
  read -p "Yes or no? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
  
  if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
    sudo echo
    echo "Pre-checking DNF for version specific packages"
    sudo dnf upgrade --refresh --allow-downgrade

    echo "What version do you want to go to?"
    VER=$(read -p "Version Number: ") 
    sudo dnf system-upgrade download --releasever=$VER --allowerasing -y 
    sudo dnf distro-sync --releasever=$VER --refresh --disablerepo rawhide --enablerepo fedora --allowerasing --best

    echo "Checking DNF for version specific packages"
    sudo dnf upgrade --refresh --allow-downgrade --offline 
    sudo dnf downgrade --skip-broken --skip-unavailable --allowerasing spec -y 
    
    continue

  else
    exit
  fi

else
  exit

fi

#delete Version_number.txt
rm Version_Number.txt

#ask if the user wants to upgrade
echo "Do you want to restart fedora?" 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
  #reboot to finish the upgrade process
  sudo echo
  echo "Rebooting to finish the upgrade process"
  sudo dnf system-upgrade reboot

else
  exit

fi

