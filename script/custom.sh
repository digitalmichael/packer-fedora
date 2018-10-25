#! /usr/bin/env bash
#
# Custom configuration script - add your own commands here to configure
# your environment.
#
# For example:
# dnf install -y git tmux bash-completion libsemanage-python
# dnf remove -y alsa-firmware linux-firmware lsscsi net-tools

set -o errexit
set -o nounset
set -o pipefail

rpm -ivh https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm
rpm -ivh https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-27.noarch.rpm

sudo dnf groupinstall 'Development Tools' 'C Development Tools and Libraries' -y
sudo dnf install gnome-tweak-tool shutter cockpit lsb-core-noarch libXScrnSaver tigervnc-server -y

su -c "curl http://folkswithhats.org/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"

cd && wget https://atom.io/download/rpm && mv rpm atom.rpm && sudo rpm -Uhv atom.rpm

sudo systemctl enable --now cockpit.socket
