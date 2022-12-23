function arch-setup
cd $HOME/chroot
sudo mount --rbind /dev arch/dev
sudo mount -t sysfs /sys arch/sys
sudo mount -t proc /proc arch/proc
sudo mount --rbind /var arch/var
sudo chroot arch
end
