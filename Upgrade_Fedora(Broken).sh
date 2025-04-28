#########################################################################
#									                                                      #
#		Fedora Upgrade Task Script				                                  #
#								                                                      	#
#   https://docs.fedoraproject.org/en-US/quick-docs/dnf-system-upgrade/	#
#									                                                      #
#	  By Justin Prosser	                                            		#
#								                                                      	#
#########################################################################

#!/bin/bash

echo "Made for fedora, check https://docs.fedoraproject.org/en-US/quick-docs/dnf-system-upgrade/ for latest instructions"

#########################################################################
#start script

echo "Welcome to the automated downgrade task script for Fedora"

#Checking DNF for upgrades
echo "Checking DNF for version downgrades"
sudo dnf upgrade --refresh

#Verify/ install dnf-plugin-system-upgrade
echo "Verify/ install dnf-plugin-system-upgrade"
sudo dnf install dnf-plugin-system-upgrade -y

#Check Fedora releases for new version
#echo "Checking online to see if there is a new version" 
#curl "https://getfedora.org/releases.json" \ | jq ".[] | select(.version==\"${VERSION_ID}\" \ and .arch==\"$(uname -m)\" and .variant==\"${VARIANT_ID^}\")"
#if [ "${VERSION_ID}" -eq "${VERSION_GET}" ]; then exit 0; fi

#ask the user to input the version number
echo "You are currently on:"
cat /etc/fedora-release
cat /etc/fedora-release | grep -o -E "[0-9]+" > ~/Scripts/Version_Number.txt
VER=$( cat Version_Number.txt )

#ask if the user wants to upgrade
echo "Do you want to upgrade to Fedora release" $((VER+1))? 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]

#IF yes then upgrade to the version passed to VER
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
  VER=$((VER+1))
  sudo dnf system-upgrade download --releasever=$VER --allowerasing -y
  continue
elif
  echo "Do you want to upgrade to Fedora release" $((VER+1))? 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
else
  exit
fi

#Checking DNF that it is on the right version now
echo "Checking DNF for version upgrades"
sudo dnf upgrade --refresh

#ask if the user wants to upgrade
echo "Do you want to restart fedora?" 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
  #reboot to finish the upgrade process
  echo "Rebooting to finish the upgrade process"
  sudo dnf system-upgrade reboot
else
  exit
fi

