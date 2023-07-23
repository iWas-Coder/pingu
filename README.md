[//]: # (Title of the project)

<img src="https://i.pinimg.com/originals/4d/df/9f/4ddf9fe1136a06629a3c6fc629a8b66d.png" alt="Pingu" width=400/>

# Pingu: DE & dotfiles

[//]: # (GPLv3 License indicator)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

[//]: # (README Body)

(...)

## Table of Contents

- [Install media](#install-media)
    - [Official Gentoo Minimal Installation ISO](#official-gentoo-minimal-installation-iso)
    - [Alternative GNU/Linux LiveCD ISO](#alternative-gnu-linux-livecd-iso)
- [Installation](#installation)
    - [Disks partitioning](#disks-partitioning)
    - [Stage-3 (Bootstrap) Base System](#stage-3-base-system)
    - [Building (Target) Base System](#building-target-base-system)
    - [Building Kernel](#building-kernel)
    - [Basic system configuration](#basic-system-configuration)
- [Pingu environment](#pingu-environment)
- [Main components](#main-components)
    - [i3](#i3)
    - [Kitty](#kitty)
    - [GNU Emacs](#gnu-emacs)
- [Kernel maintenance](#kernel-maintenance)

## Install media

(...)

### Official Gentoo Minimal Installation ISO

This is the URL pattern where the ISO lives (updated periodically): `https://distfiles.gentoo.org/releases/amd64/autobuilds/current-install-amd64-minimal/install-amd64-minimal-*.iso`, where `*` is the timestamp taken when that particular ISO was built.

Assume `$ISO` is the previous URL.

A `$ISO.DIGESTS` file is available, which provides a set of hashes to verify the integrity of the downloaded ISO. If only wanted a SHA256 hash, the file `$ISO.sha256` file can be downloaded instead.

Also, a `$ISO.asc` file is available, which contains the PGP signature of the downloaded ISO
. In order to verify the authenticity of the signature, one must do:

```shell
$  gpg --auto-key-locate=clear,nodefault,wkd --locate-key releng@gentoo.org
$  gpg --verify install-amd64-minimal-*.iso.asc
```

### Alternative GNU/Linux LiveCD ISO

(...)

## Installation

Installation guide of the GNU/Linux distribution offered by Gentoo.

(...)

### Disks partitioning

(...)

```shell
$  cfdisk /dev/$DISK1
```

(...)

| LABEL | MOUNTPOINT | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------|------------------|--------|------|
| EFI   | /boot/EFI  | EFI System       | fat32  | 128M |
| BOOT  | /boot      | Linux filesystem | ext4   | 896M |
| SYS   | /          | Linux filesystem | ext4   | REST |

(...)

```shell
$  cfdisk /dev/$DISK2
```

(...)

| LABEL | MOUNTPOINT       | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------------|------------------|--------|------|
| DATA  | /home/$USER/data | Linux filesystem | ext4   | ALL  |

(...)

### Stage-3 Base System

(...)

### Building (Target) Base System

(...)

### Building Kernel

(...)

### Basic system configuration

(...)

## Pingu environment

(...)

```shell
$  git clone --bare https://github.com/iwas-coder/pingu /home/$USER/.pingu
```

(...)

```shell
#  git --git-dir=/home/$USER/.pingu --work-tree=/ checkout -f
```

(...)

## Main components

(...)

### i3

<img src="home/iwas/.config/i3/screenshot-desktop.png" alt="i3" width=100%>

(...)

### Kitty

<img src="home/iwas/.config/kitty/screenshot-terminal.png" alt="Kitty" width=100%>

(...)

### GNU Emacs

<img src="home/iwas/.emacs.d/screenshot-dashboard.png" alt="GNU Emacs (dashboard)" width=100%>
<img src="home/iwas/.emacs.d/screenshot-editor.png" alt="GNU Emacs (editor)" width=100%>

(...)

## Kernel maintenance

(...)

Check current `/usr/src/linux` symlink:
```shell
$  eselect kernel list
```

Configure the kernel `.config` file with:
```shell
#  make menuconfig
```

Pass the unit test suite (pytest) to check for config errors:
```shell
#  make testconfig
```

Build the kernel (`vmlinux`), its selected modules (`*.ko`) and the kernel compressed image (`bzImage`).
```shell
#  KCFLAGS="-march=<ARCH> -O2 -pipe" nice make [-j<N>]
```
Add the `-j<N>` flag so that GNU Make can parallelize jobs, where `N` is the number of jobs to handle in parallel.

Replace `<ARCH>` with the CPU's architecture name that GNU GCC handles (e.g. `znver2` for Zen2; `znver3` for Zen3). This can be searched online, or guessed by GCC itself doing:
```shell
$  gcc -Q -march=native --help=target | grep march | head -n 1
```

Install the built modules into `/lib/modules/<VERSION>`:
```shell
#  make modules_install
```

Export the API headers into `./usr`, in case needed later on:
```shell
#  make headers
```

Install the kernel's needed resources in `/boot`, using the following mapping:
- `bzImage` -> `/boot/vmlinuz-<VERSION>`
- `System.map` -> `/boot/System.map-<VERSION>`
- `.config` -> `/boot/config-<VERSION>`
If these files already existed in `/boot` prior to this step, then it renames them to `*.old`, in order to maintain a backup until the new version gets tested.
```shell
#  make install
```

Create a initial ramdisk FS (i.e. `initramfs` or `initrd`):
```shell
#  dracut --kver=<VERSION> --hostonly --early-microcode [--force]
```
The argument `--force` needs to be specified when it already exists an initramfs (`/boot/initramfs-<VERSION>.img`). Before doing so, though, it is best to make a backup:
```shell
#  cp -v /boot/initramfs-<VERSION>.img /boot/initramfs-<VERSION>.img.old
```

If new kernel version, once booted to it, recreate the initramfs image.

(...)

