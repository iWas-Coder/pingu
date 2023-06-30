[//]: # (Title of the project)

<img src="https://i.pinimg.com/originals/4d/df/9f/4ddf9fe1136a06629a3c6fc629a8b66d.png" alt="Pingu" width=400/>

# Pingu: DE & dotfiles

[//]: # (GPLv3 License indicator)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

[//]: # (README Body)

(...)

## Table of Contents

- [Disks partitioning](#disks-partitioning)
- [Linux kernel building](#linux-kernel-building)

## Disks partitioning

(...)

```shell
cfdisk /dev/$DISK1
```

(...)

| LABEL | MOUNTPOINT | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------|------------------|--------|------|
| EFI   | /boot/EFI  | EFI System       | fat32  | 128M |
| BOOT  | /boot      | Linux filesystem | ext4   | 896M |
| SYS   | /          | Linux filesystem | ext4   | REST |

(...)

```shell
cfdisk /dev/$DISK2
```

(...)

| LABEL | MOUNTPOINT       | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------------|------------------|--------|------|
| DATA  | /home/$USER/data | Linux filesystem | ext4   | ALL  |

(...)

## Linux kernel building

(...)

```shell
cd /usr/src/linux
sudo make menuconfig
sudo KCFLAGS="-march=<ARCH> -O2 -pipe" make -j<N>
sudo make modules_install
sudo make headers
sudo make install
```

(...)

