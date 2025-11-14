#! /bin/bash

### preparations ###

wrkdr="bttrsnppr-$(date +%F)"
mkdir -p ~/$wrkdr/snapper-desc/
sudo apt install -y snapper-gui inotify-tools git build-essential gawk wget btrfs-progs

### btrfs config + fix snapshots ###

cd /
sudo umount .snapshots
sudo rm -r .snapshots 
sudo snapper -c root create-config /
sudo snapper -c home create-config /home
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -av

### grub-btrfs ###

cd ~/$wrkdr/
git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs/
sudo make install
sudo systemctl enable --now grub-btrfsd
sudo sed -i 's/GRUB_BTRFS_DISABLE=/#GRUB_BTRFS_DISABLE=/g' /etc/default/grub-btrfs/config

### snapper-rollback ###

cd ~/$wrkdr/
git clone https://github.com/jrabinow/snapper-rollback.git
cd snapper-rollback/
sudo cp snapper-rollback.py /usr/local/bin/snapper-rollback
sudo cp snapper-rollback.conf /etc/

### better snapper description ###

cd ~/$wrkdr/snapper-desc/
curl -L https://gist.githubusercontent.com/imthenachoman/f722f6d08dfb404fed2a3b2d83263118/raw/e80365b525d425d5fea83d31009b2590a699c8bd/80snapper -o 80snapper
curl -L https://gist.githubusercontent.com/imthenachoman/f722f6d08dfb404fed2a3b2d83263118/raw/e80365b525d425d5fea83d31009b2590a699c8bd/dpkg-pre-post-snapper.sh -o dpkg-pre-post-snapper.sh
sudo mv /etc/apt/apt.conf.d/80snapper /etc/apt/apt.conf.d/80snapper_bak
sudo sed -i 's/^/#/g' /etc/apt/apt.conf.d/80snapper_bak
sudo sed -i 's/\/path\/to\/dpkg-pre-post-snapper.sh/\/usr\/local\/bin\/dpkg-pre-post-snapper.sh/g' 80snapper
sudo cp 80snapper /etc/apt/apt.conf.d/80snapper
sudo cp dpkg-pre-post-snapper.sh /usr/local/bin/dpkg-pre-post-snapper.sh
sudo chmod +x /usr/local/bin/dpkg-pre-post-snapper.sh
