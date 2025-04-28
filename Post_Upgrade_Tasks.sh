#########################################################################
#									#
#		Fedora Post Upgrade Task Script				#
#									#
#  https://docs.fedoraproject.org/en-US/quick-docs/sudo dnf-system-upgrade/	#
#									#
#			By Justin Prosser				#
#									#
#########################################################################

#!/bin/bash

echo "Made for fedora, check https://docs.fedoraproject.org/en-US/quick-docs/sudo dnf-system-upgrade/ for latest instructions"

#########################################################################
#start script

echo "Welcome to the automated post upgrade task script for Fedora"

#Update the system config
sudo echo
echo "Updating system confg"
sudo dnf install rpmconf -y
rpmconf -a

#Update Grub bootloader
echo "Updating Grub Bootloader"
mount | grep "/boot "
#grub2-install /dev/sda

#Cleanup old packages
sudo echo
echo "Cleaning up old packages"
sudo dnf install remove-retired-packages
remove-retired-packages 

#Cleanup old packages
sudo echo
echo "Cleaning up sudo dnf"
sudo dnf repoquery --unsatisfied -y
sudo dnf repoquery --duplicates -y
sudo dnf list extras -y
sudo dnf remove $(sudo sudo dnf repoquery --extras --exclude=kernel,kernel-\*) -y
sudo dnf autoremove -y

#Run Kernel cleanup
echo "Cleaning up the kernel"
./Kernel_Cleanup.sh -y

#cleanup old symlinks
sudo echo
echo "cleaning up old symlinks"
sudo dnf install symlinks -y
sudo symlinks -r /usr | grep dangling
sudo symlinks -r -d /usr

#end
echo "Thank you for choosing fedora, m'lady"
