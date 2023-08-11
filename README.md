[//]: # (Title of the project)

<img src="https://i.pinimg.com/originals/4d/df/9f/4ddf9fe1136a06629a3c6fc629a8b66d.png" alt="Pingu" width=400/>

# Pingu: DE & dotfiles

[//]: # (Repository badges)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

[//]: # (README Body)

Pingu is my personal `dotfiles` repository, which creates a Desktop Environment (DE) based on Gentoo's Portage package management tool, which manages packages from its source code; thus, building from source the entire GNU/Linux system.

The layout of this repository is based on a technique I've recently taken to calling it the **Git bare dotfiles organization strategy**, which is extensively explained and discussed both in this 2016 [Hacker News thread](https://news.ycombinator.com/item?id=11070797) by the user *StreakyCobra*, and in an [article published by Atlassian](https://www.atlassian.com/git/tutorials/dotfiles), in their Git tutorials section.

This technique, then, consists in creating a bare repository (the `.git` directory in a complete repo with its worktree there as well) in `$HOME/.pingu`, and defining the worktree as the `/` (root) of the entire filesystem. This is specified command-based, as such:
```shell
$  git --git-dir=$HOME/.pingu --work-tree=/
```
But, for the sake of convenience, this command is aliased to the `pingu` keyword, which can be used to issue commands to perform normal Git operations under the dotfiles repository, located in this case under `$HOME/.pingu`.

> This work and all its documentation is licensed under the Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) License.\
> This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.\
> This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Table of Contents

- [Install media](#install-media)
    - [Official Gentoo Minimal Installation ISO](#official-gentoo-minimal-installation-iso)
    - [Alternative GNU/Linux LiveCD ISO](#alternative-gnu-linux-livecd-iso)
- [Installation](#installation)
    - [Disks preparation](#disks-preparation)
		- [Partitioning](#partitioning)
		- [Formatting and mounting root partition](#formatting-and-mounting-root-partition)
    - [Stage-3 Base System](#stage-3-base-system)
    - [Building Target System](#building-target-system)
		- [Compile options](#compile-options)
		- [Copy DNS info](#copy-dns-info)
		- [Mounting necessary filesystems](#mounting-necessary-filesystems)
		- [Entering the new environment](#entering-the-new-environment)
		- [Configuring Portage](#configuring-portage)
    - [Building Kernel](#building-kernel)
    - [Basic system configuration](#basic-system-configuration)
- [Pingu environment](#pingu-environment)
- [Main components](#main-components)
    - [i3](#i3)
    - [Kitty](#kitty)
    - [GNU Emacs](#gnu-emacs)
- [Kernel maintenance](#kernel-maintenance)
	- [New kernel version](#new-kernel-version)
		- [Install stage](#install-stage)
		- [Build stage](#build-stage)
	- [Reconfigure current kernel version](#reconfigure-current-kernel-version)

## Install media

(...)

### Official Gentoo Minimal Installation ISO

This is the URL pattern where the ISO lives (updated periodically): `https://distfiles.gentoo.org/releases/amd64/autobuilds/current-install-amd64-minimal/install-amd64-minimal-*.iso`, where `*` is the timestamp taken when that particular ISO was built.

Assume `$ISO` is the previous URL.

A `$ISO.DIGESTS` file is available, which provides a set of hashes to verify the integrity of the downloaded ISO. If only wanted a SHA256 hash, the file `$ISO.sha256` file can be downloaded instead.

Also, a `$ISO.asc` file is available, which contains the PGP signature of the downloaded ISO. In order to verify the authenticity of the signature, one must do:

```shell
$  gpg --auto-key-locate=clear,nodefault,wkd --locate-key releng@gentoo.org
$  gpg --verify install-amd64-minimal-*.iso.asc
```

### Alternative GNU/Linux LiveCD ISO

(...)

## Installation

Installation guide of the GNU/Linux distribution offered by Gentoo.

(...)

### Disks preparation

(...)

#### Partitioning

(...)

```shell
#  cfdisk /dev/vda
```

(...)

| LABEL | MOUNTPOINT | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------|------------------|--------|------|
| EFI   | /boot/EFI  | EFI System       | fat32  | 128M |
| BOOT  | /boot      | Linux filesystem | ext4   | 896M |
| SYS   | /          | Linux filesystem | ext4   | REST |

(...)

```shell
#  cfdisk /dev/vdb
```

(...)

| LABEL | MOUNTPOINT       | PARTITION TYPE   | FORMAT | SIZE |
|-------|------------------|------------------|--------|------|
| DATA  | $HOME/data       | Linux filesystem | ext4   | ALL  |

(...)

#### Formatting and mounting root partition

(...)

```shell
#  mkfs.vfat -F 32 -n EFI /dev/vda1
#  mkfs.ext4 -L BOOT /dev/vda2
#  mkfs.ext4 -L SYS /dev/vda3
#  mkfs.ext4 -L DATA /dev/vdb1
```

(...)

```shell
#  wipefs /dev/{vda*,vdb*}
```

(...)

```shell
#  mount -L SYS /mnt/system --mkdir
```

### Stage-3 Base System

(...)

```shell
#  cd /mnt/system
```

This is the URL pattern where the Stage-3 tarball lives (updated periodically): `https://distfiles.gentoo.org/releases/amd64/autobuilds/*/stage3-amd64-desktop-openrc-*.tar.xz`, where `*` is the timestamp taken when that particular tarball was built.

Assume `$STAGE3` is the previous URL.

A `$STAGE3.DIGESTS` file is available, which provides a set of hashes to verify the integrity of the downloaded tarball. If only wanted a SHA256 hash, the file `$STAGE3.sha256` file can be downloaded instead.

Also, a `$STAGE3.asc` file is available, which contains the PGP signature of the downloaded tarball. In order to verify the authenticity of the signature, one must do:

```shell
$  gpg --auto-key-locate=clear,nodefault,wkd --locate-key releng@gentoo.org
$  gpg --verify stage3-amd64-desktop-openrc-*.tar.xz.asc
```

After all is on check, unpack the downloaded tarball (from within `/mnt/system` root's mountpoint) by doing:

```shell
#  tar -xpvf stage3-amd64-desktop-openrc-*.tar.xz --xattrs-include='*.*' --numeric-owner
```
The `--xattrs-include='*.*'` argument is used to include preservation of the the extended attributes in all namespaces stored in the archive. Also, the `--numeric-owner` argument is used to ensure that the user and group IDs of the files being extracted from the tarball will remain the same as Gentoo's release engineering team intended (even if adventurous users are not using official Gentoo live environments).

### Building Target System

(...)

#### Compile options

Edit the file `/mnt/system/etc/portage/make.conf` accordingly to the specific hardware. This is [the proposed skeleton](etc/portage/make.conf):
```
COMMON_FLAGS="-march=<EDIT> -O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"

MAKEOPTS="-j<EDIT>"
PORTAGE_NICENESS="10"

VIDEO_CARDS="<EDIT>"
LC_MESSAGES=C
ACCEPT_LICENSE="<EDIT>"

USE="X icu pulseaudio widevine vaapi wayland -bluetooth -gnome -kde -systemd"
```
There are several things that might need a change, marked with a `<EDIT>` symbol. Let's go through them, discussing for each one its possible values:

- `-march=`: This setting specifies the name of the target architecture. With this setting set, GCC will be free to generate instructions that work on the specified CPU, but (typically) not on earlier CPUs in the architecture family. A commonly used value is `native`, as that tells the compiler to select the target architecture of the current system (if GCC is able to detect it). Other common values are `znver1` (*Ryzen 1000 and 2000 series*), `znver2` (*Ryzen 3000, 4000, 5000, and EPYC 7xx2 series*), `znver3` (*5000 and EPYC 7xx3 series*), `alderlake` (*Intel 12th Gen*), `skylake` (*Intel 6-11th Gen*), etc. This also can be searched [online](https://wiki.gentoo.org/wiki/Safe_CFLAGS), or guessed by GCC itself (issuing `gcc -Q -march=native --help=target | grep march | head -n 1`).

- `-j`: This setting sets the number of jobs that `make` will try to execute in a parallel manner. This can be equal to the number of CPUs (threads) seen by the kernel, but I enjoy setting it to a lower number to be able to multitask quite efficiently while emerging (compiling/building) a set of packages, e.g. `-j10` with 16 CPUs.

- `VIDEO_CARDS`: This setting should be configured appropriately depending on the available GPU(s). Common choices include `nouveau` (*NVIDIA GPU - Reverse Engineered FOSS Driver*), `nvidia` (*NVIDIA GPU - Privative Driver*), `amdgpu radeonsi` (*AMD Modern GPU*), `radeon` (*AMD Old GPU*), `intel` (*Intel GPU*), `virgl` (*Virtio GPU*), `vmware` (*VMware SVGA GPU*), `virtualbox` (*Virtualbox GPU*), etc.

- `ACCEPT_LICENSE`: This setting can be set to override the system wide accepted default licenses in the profiles. The license groups defined in the Gentoo repository, managed by the Gentoo Licenses project, are:
	- `@GPL-COMPATIBLE`: GPL compatible licenses approved by the Free Software Foundation ([ref](https://www.gnu.org/licenses/license-list.html)).
	- `@FSF-APPROVED`: Free software licenses approved by the FSF. Includes `@GPL-COMPATIBLE`.
	- `@OSI-APPROVED`: Licenses approved by the Open Source Initiative ([ref](https://www.opensource.org/licenses)).
	- `@MISC-FREE`: Misc licenses that are probably free software, i.e. follow the Free Software Definition, but are not approved by either FSF or OSI ([ref](https://www.gnu.org/philosophy/free-sw.html)).
	- `@FREE-SOFTWARE`: Combines `@FSF-APPROVED`, `@OSI-APPROVED` and `@MISC-FREE`.
	- `@FSF-APPROVED-OTHER`: FSF-approved licenses for "free documentation" and "works of practical use besides software and documentation" (including fonts).
	- `@MISC-FREE-DOCS`: Misc licenses for free documents and other works (including fonts) that follow the free definition, but are NOT listed in `@FSF-APPROVED-OTHER` ([ref](https://freedomdefined.org/)).
	- `@FREE-DOCUMENTS`: Combines `@FSF-APPROVED-OTHER` and `@MISC-FREE-DOCS`.
	- `@FREE`: Metaset of all licenses with the freedom to use, share, modify and share modifications. Combines `@FREE-SOFTWARE` and `@FREE-DOCUMENTS`.
	- `@BINARY-REDISTRIBUTABLE`: Licenses that at least permit free redistribution of the software in binary form. Includes `@FREE`.
	- `@EULA`: License agreements that try to take away your rights. These are more restrictive than "all-rights-reserved" or require explicit approval.

#### Copy DNS info

One thing still remains to be done before entering the new environment and that is copying over the DNS information in `/etc/resolv.conf`. This needs to be done to ensure that networking still works even after entering the new environment. `/etc/resolv.conf` contains the name servers for the network.

To copy this information, it is recommended to pass the `-L, --dereference` option to the cp command. This ensures that, if `/etc/resolv.conf` is a symbolic link, that the link's target file is copied instead of the symbolic link itself. Otherwise in the new environment the symbolic link would point to a non-existing file (as the link's target is most likely not available inside the new environment).

```shell
#  cp -L /etc/resolv.conf /mnt/system/etc/
```

#### Mounting necessary filesystems

In a few moments, the Linux root will be changed towards the new location. The filesystems that need to be made available are:

- `/proc`: Pseudo-filesystem that it looks like regular files, but is generated on-the-fly by the Linux kernel.
```shell
#  mount -t proc /proc /mnt/system/proc
```
- `/sys`: Pseudo-filesystem, like `/proc`, which it was once meant to replace, and is more structured than `/proc`.
```shell
#  mount -R /sys /mnt/system/sys
#  mount --make-rslave /mnt/system/sys
```
- `/dev`: Regular file system which contains all devices, and it is partially managed by the Linux device manager (usually *udev*).
```shell
#  mount -R /dev /mnt/system/dev
#  mount --make-rslave /mnt/system/dev
```
- `/run`: Temporary file system used for files generated at runtime, such as PID files or locks.
```shell
#  mount -B /run /mnt/system/run
#  mount --make-slave /mnt/system/run
```

The `/proc` location will be mounted on `/mnt/system/proc` whereas the others are *bind-mounted*. The latter means that, for instance, `/mnt/system/sys` will actually be `/sys` (it is just a second entry point to the same filesystem) whereas `/mnt/system/proc` is a new mount (instance so to speak) of the filesystem.

When using **non-Gentoo installation media**, this might not be sufficient. Some distributions make `/dev/shm` a symbolic link to `/run/shm` which, after the chroot, becomes invalid. Making `/dev/shm` a proper tmpfs mount up front can fix this:
```shell
#  test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
#  mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm
```
Also ensure that **mode 1777** is set:
```shell
#  chmod 1777 /dev/shm /run/shm
```

#### Entering the new environment

(...)

```shell
#  chroot /mnt/system /bin/bash
#  source /etc/profile
#  export PS1="(chroot) ${PS1}"
```

(...)

```shell
(chroot) #  mount -L BOOT /boot
(chroot) #  mount -L EFI /boot/EFI --mkdir
```

#### Configuring Portage

(...)

```shell
(chroot) #  emerge-webrsync
```

(...)

```shell
(chroot) #  emerge --sync
```

(...)

```shell
(chroot) #  emerge -vauDU @world
```

(...)

```shell
(chroot) #  eselect news read
```

(...)

```shell
(chroot) #  ls /usr/share/zoneinfo
(chroot) #  echo "Europe/Madrid" > /etc/timezone
(chroot) #  emerge --config sys-libs/timezone-data
```

(...)

```shell
(chroot) #  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
(chroot) #  locale-gen
(chroot) #  eselect locale list
(chroot) #  eselect locale set <N>
```

(...)

```shell
(chroot) #  env-update
(chroot) #  source /etc/profile
#  export PS1="(chroot) ${PS1}"
```

### Building Kernel

(...)

```shell
(chroot) #  emerge -va linux-firmware gentoo-sources
(chroot) #  eselect kernel list
(chroot) #  eselect kernel set <N>
```

### Basic system configuration

(...)

## Pingu environment

(...)

```shell
$  git clone --bare https://github.com/iwas-coder/pingu $HOME/.pingu
```

(...)

```shell
#  git --git-dir=$HOME/.pingu --work-tree=/ checkout -f
```

(...)

## Main components

(...)

### i3

<img src="home/iwas/.config/i3/screenshot-desktop.png" alt="i3" width=100%>

(...)

As an add-on, I use the `picom` compositor (a fork of the initial `compton` project) to add transparency, shadows and animations to all windows and apps. Specifically, I am using the [pijulius's fork](https://github.com/pijulius/picom), which includes ***fantastic animation code*** to the project (the only one I tried that works perfectly for production).

For this reason, I'd like to give a ***shoutout*** to *Istvan Petres* for this fork and all its contributions, thank you!

```shell
$  cd ~/data/git/external
$  git clone https://github.com/pijulius/picom picom.pijulius
$  cd !$
$  git submodule update --init --recursive
$  meson setup --buildtype=release . build
$  ninja -C build
#  ln -s $(pwd)/build/src/picom /usr/local/bin
```

If wanted to reduce file size of the binary, using the `upx` utility, do:
```shell
$  upx --color --best build/src/picom
```

### Kitty

<img src="home/iwas/.config/kitty/screenshot-terminal.png" alt="Kitty" width=100%>

(...)

### GNU Emacs

<img src="home/iwas/.emacs.d/screenshot-dashboard.png" alt="GNU Emacs (dashboard)" width=100%>
<img src="home/iwas/.emacs.d/screenshot-editor.png" alt="GNU Emacs (editor)" width=100%>

(...)

## Kernel maintenance

(...)

### New kernel version

(...)

#### Install stage

(...)

#### Build stage

Check current `/usr/src/linux` symlink:
```shell
$  eselect kernel list
```

Change the symlink to the new version by doing:
```shell
#  eselect kernel set <N>
```

Ensure the source tree is properly cleaned up:
```shell
#  make mrproper
```

Copy the previous kernel configuration file to the source tree:
```shell
#  cp -v /boot/config-<VERSION> .config
```

Adapt the previous configuration to the new version, and open up the kernel `.config` file with the `menuconfig` editor:
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

Create the first iteration of the initial ramdisk FS (i.e. `initramfs` or `initrd`):
```shell
#  dracut --kver=<VERSION> --hostonly --early-microcode
```

Once booted to the newly built kernel, create the second and last iteration of the initrd image (same command as the previous one).

### Reconfigure current kernel version

Open up `/usr/src/linux` directory (where the current installed kernel source tree lives) and open the kernel `.config` file with the `menuconfig` editor:

```shell
#  make menuconfig
```

Pass the unit test suite (pytest) to check for config errors:
```shell
#  make testconfig
```

(...)

Make a backup of the current initramfs file (`/boot/initramfs-<VERSION>.img`):
```shell
#  cp -v /boot/initramfs-<VERSION>.img /boot/initramfs-<VERSION>.img.old
```

Create the first iteration of the initial ramdisk FS (i.e. `initramfs` or `initrd`):
```shell
#  dracut --kver=<VERSION> --hostonly --early-microcode --force
```
The argument `--force` needs to be specified as it already exists an initramfs file (`/boot/initramfs-<VERSION>.img`).

(...)
