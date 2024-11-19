# Full process to create a complete Debian installation of sid (unstable):
```bash
export MY_CHROOT=/sid-root
cd /
mkdir $MY_CHROOT
#debootstrap --arch i386 sid $MY_CHROOT http://deb.debian.org/debian/
debootstrap --arch i386 sid $MY_CHROOT http://10.216.1.85/deb.debian.org/debian/
#debootstrap stable /stable-chroot http://10.216.1.85/deb.debian.org/debian/
```
[Full process to create a complete Debian installation of sid .sh.md](Full%20process%20to%20create%20a%20complete%20Debian%20installation%20of%20sid%20.sh.md)
#[ ... watch it download the whole system ]

![Capture d'écran 2024-11-10 181327.png](Capture%20d%27%C3%A9cran%202024-11-10%20181327.png)
```bash
echo "proc $MY_CHROOT/proc proc defaults 0 0" >> /etc/fstab
mount proc $MY_CHROOT/proc -t proc
echo "sysfs $MY_CHROOT/sys sysfs defaults 0 0" >> /etc/fstab
mount sysfs $MY_CHROOT/sys -t sysfs
cp /etc/hosts $MY_CHROOT/etc/hosts
cp /proc/mounts $MY_CHROOT/etc/mtab
chroot $MY_CHROOT /bin/bash
chroot # dselect
#[ you may use aptitude, install mc and vim ... ]
 echo "8:23:respawn:/usr/sbin/chroot $MY_CHROOT " \
        "/sbin/getty 38400 tty8"  >> /etc/inittab
#[ define a login tty that will use this system ]
#[ i.e. create tty8 with `mknod tty8 c 4 8' and run `passwd' ]
 init q
#[ reload init ]
```

---------
ref:  https://wiki.debian.org/Debootstrap
