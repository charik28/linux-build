# Défi 2 : Distros Linux Live Minimales pour x86/ARM


## Prérequis

- Une machine exécutant Ubuntu ou Debian.
- Connaissances de base des opérations en ligne de commande.
- `git`, `debootstrap` et `systemd` installés.

## Étape 1 : Installer les paquets requis

Installez les paquets nécessaires pour créer une distro live minimale :

```bash
sudo apt-get update
sudo apt-get install git debootstrap systemd
```

## Étape 2 : Créer un répertoire de travail

Créez un répertoire pour les fichiers de la distro live :

```bash
mkdir ~/minimal-live-distro
cd ~/minimal-live-distro
```

## Étape 4 : Chroot dans le nouvel environnement

Changez de racine dans l'environnement nouvellement créé :

```bash
sudo chroot ./rootfs
```

## Étape 5 : Configurer le système

À l'intérieur de l'environnement chroot, effectuez les actions suivantes :

1. Configurez le nom d'hôte :
   ```bash
   echo "minimal-live" > /etc/hostname
   ```

2. Configurez le fichier hosts :
   ```bash
   echo "127.0.0.1   localhost" >> /etc/hosts
   echo "127.0.1.1   minimal-live" >> /etc/hosts
   ```

3. Installez les paquets nécessaires :
   ```bash
   apt-get update
   apt-get install linux-image-generic
   apt-get install systemd-sysv
   ```

4. Quittez le chroot :
   ```bash
   exit
   ```

## Étape 6 : Créer l'image live

### Installer `genisoimage`

```bash
sudo apt-get install genisoimage
```

### Générer l'ISO

```bash
sudo genisoimage -o minimal-live.iso -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table ./rootfs
```

## Étape 7 : Tester l'ISO live avec VirtualBox

### Ou en créant une clé USB bootable

Utilisez `dd` pour écrire l'ISO sur une clé USB :

```bash
sudo dd if=minimal-live.iso of=/dev/sdX bs=4M
```
