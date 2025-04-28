# Fedorda Script repository

## Table of Contents

1.	[Fedora Script Respoitory](#fedorda-script-repository)
	1.	[Table of Contents](#table-of-contents)
	2.	[Foreword](#foreword)
	3.	[App Updates](#app-updates)
	4.	[Fedora Version Change](#fedora-version-change)
	5.	[Kernel Cleanup](#kernel-cleanup)
	6.	[Post Upgrade Tasks](#post-upgrade-tasks)
	7.	[Resolving Issues & Troubleshotting](#resolving-issues--troubleshooting)
	8.	[Upgrade Fedora (Broken)](#upgrade-fedora-broken)
	8.	[Conclusion](#conclusion)


## Foreword
Welcome to my Fedora scripts respository. This is a collecton of scripts I have created for [KDE Plasma Fedora](https://fedoraproject.org/kde/) utilizing the [Upgrading Fedora Linux Using DNF System Plugin](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/) commandlets. The idea was to simplify going through the list and autmote most of the processes. Each script performs its task with varying levels of sucess. I've elminitated most, but not all, errors. There is also plenty of room for improvement. I am sharing this on github because I won't be using fedora for work but I don't want my work to go to waste.

## App Updates
Simple Bash script to check for updates and then upgrade system packages. Also Cleans up cache and autoremoves older packages.

## Fedora Version Change
Based on [Upgrading Fedora Linux Using DNF System Plugin](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/). 
This script was made around fedora version 40 and is designed to allow the user to decide which version of fedora they can migrate to. Note, once you switch to rawhide, there is no easy way to switch back. 
I probably need to add more logic to specific sections:
	1. To see what the latest version available online
	2. To determine if the version the user is switching to is beta/ rawhide
		1. This could prevent accidnental upgrades
		2. If the verson is a normal release, provide the correct switches.

Script is still WIP	

## Kernel Cleanup
Based on [Cleaning up old Kernels](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/#sect-clean-up-old-kernels).
This Script is designed to allow the user to clean up older kernals once an upgrade is completed. since [Fedora Version Change](#fedora-version-change) has a reboot function, I seperated this out since it is post upgrade.

## Post Upgrade Tasks
Based on [Optional post upgrade tasks](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/#sect-optional-post-upgrade-tasks)
This Script is designed to allow users to run all the optional tasks after the OS has been changed. It includes updating rpmconf, updating grub bootloader, cleaning up old packages, cleaning up the kernel, cleaning up old symlinks.


## Resolving Issues & Troubleshooting
Based on [Resolving post upgrade issues](https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/#sect-resolving-post-upgrade-issues)
This Script is designed to allow users to run troubleshooting steps if they run into issues after upgrade. Looking back on the script, I need to add more logic so cancel exits the program.

## Upgrade Fedora (Broken)
My testing script for [Fedora Version Change](#fedora-version-change).
This script started out as an upgrade script (Infact I think this was my orginial upgrade script until I made Fedora Version Change). It's purpose was much the same as Fedora Version Change expect I was testing out certian logic and in the progess, broke some of its functionality. I stopped supporting it because Fedora Version Change allows more version control than this script did. You can see my failed attempt to query fedora realeases so see what is the current version online.

## Conclusion
These scripts have enabled me to automate the OS upgrade process on Fedora for a few years now. I am putting them onto github because I need to support Ubuntu for work and Fedora was more of a Red Hat learning expirence. I might come back to fedora down the road but it depends on where life takes me. If you find errors or want to make suggestions, please feel free to do so.