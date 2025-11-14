#! /bin/bash
# get_virtualbox.sh
# inspired by: https://bbs.archlinux.org/viewtopic.php?pid=2052713#p2052713

# VBLV = VirtualBoxLatestVersion
# VBGI = VirtualBoxGenericInstaller
# VBEP = VirtualBoxExtensionPack

VBLV=$(wget -qO- https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT)
VBGI=$(wget -qO- https://download.virtualbox.org/virtualbox/${VBLV}/SHA256SUMS | grep ".run" -m1 | awk '{print $2}' | sed 's/*//g')
VBEP=$(wget -qO- https://download.virtualbox.org/virtualbox/${VBLV}/SHA256SUMS | grep ".extpack" -m1 | awk '{print $2}' | sed 's/*//g')

wget "https://download.virtualbox.org/virtualbox/${VBLV}/${VBGI}"
wget "https://download.virtualbox.org/virtualbox/${VBLV}/${VBEP}"

chmod +x ${VBGI}
sudo ./${VBGI} install

sudo rcvboxdrv setup
sudo usermod -a -G vboxusers $(logname)

sudo VBoxManage extpack install --replace ${VBEP}
