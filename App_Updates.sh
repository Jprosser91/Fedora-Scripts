#!/bin/bash
sudo echo
sudo dnf update -y --allowerasing && sudo dnf upgrade -y --allowerasing
sudo dnf autoremove -y
sudo dnf clean all -y
sudo dnf distro-sync --skip-broken -y
sudo echo
