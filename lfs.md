
ssh user@172.16.4.84
user

# 5.3.1. Installation de GCC croisé 

#wget mpfr,gmp,mpc
#from this https://fr.linuxfromscratch.org/view/lfs-systemd-stable/chapter03/packages.html

tar -xf ../mpfr-4.2.1.tar.xz
mv -v mpfr-4.2.1 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc


 Sur les systèmes x86_64, définissez « lib » comme nom de répertoire par défaut pour les bibliothèques 64 bits :

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

# La documentation de GCC recommande de construire GCC dans un répertoire de construction dédié :

mkdir -v build
cd       build

# Préparez la compilation de GCC :

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.40 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++


time make -j 16
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname \
    $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

#  screenshpot 
screen/Capture d’écran du 2024-11-18 10-48-57
png
screen/Capture d’écran du 2024-11-18 10-51-00.png

    #ref : https://fr.linuxfromscratch.org/view/lfs-systemd-stable/chapter05/gcc-pass1.html

## ------------
 ls -l /mnt/lfs/tools/lib/gcc/x86_64-lfs-linux-gnu/14.2.0/install-tools/include/

screen/Capture d’écran du 2024-11-18 11-23-02.png



## 5.4.1. Installation de Linux API Headers 

d /mnt/lfs/sources/
### version stable
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.11.9.tar.xz


 Le noyau linux a besoin de montrer une interface de programmation de l'application (Application Programming Interface, API) à utiliser (Glibc dans LFS). Cela est possible en nettoyant certains fichiers d'en-tête C qui sont laissés dans le paquet des sources du noyau Linux.

Assurez-vous qu'il n'y a pas de vieux fichiers embarqués dans le paquet :

make mrproper

Maintenant extrayez les en-têtes publics du noyau depuis les sources. La cible make recommandée « headers_install » ne peut pas être utilisée car elle requiert rsync, qui n'est pas forcément disponible. On place les en-têtes dans ./usr puis on les copie vers l'emplacement requis.

make headers
find usr/include -type f ! -name '*.h' -delete
sudo cp -rv usr/include $LFS/usr


### 5.5.1. Installation de Glibc
#### créez un lien symbolique pour respecter le LSB
V-34:24

cd /mnt/lfs/lib64


case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

pass 1 
ld-linux-x86-64.so.2  ld-lsb-x86-64.so.3


pass 2 :
'/lib64/ld-linux-x86-64.so.2' -> '../lib/ld-linux-x86-64.so.2'
'/lib64/ld-lsb-x86-64.so.3' -> '../lib/ld-linux-x86-64.so.2'



wget https://ftp.gnu.org/gnu/glibc/glibc-2.40.tar.xz
->>>
tar xf glibc-2.40.tar.xz
cd glibc-2.40 

pass:2 mv removing the version from the folders

## 3.03 Correctifs ref https://fr.linuxfromscratch.org/view/lfs-systemd-stable/chapter03/patches.html

cd /mnt/lfs/sources
wget https://www.linuxfromscratch.org/patches/lfs/12.2/glibc-2.40-fhs-1.patch

cd -

patch -Np1 -i ../glibc-2.40-fhs-1.patch

mkdir -v build
cd       build
echo "rootsbindir=/usr/sbin" > configparms

 #### Ensuite, préparez la compilation de Glibc :

editing the kernel version ; from 4. -> 
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=6.1              \
      --with-headers=$LFS/usr/include    \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib
undersource/glibc/build
time make -j 16



sudo make DESTDIR=$LFS install
>> ERROR 2 --> sudo permissions
Execution of gcc failed!
The script has found some problems with your installation!

>> Erreur de segmentation
<<<skip>>>

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

>>ERRors 

go to step 5.5