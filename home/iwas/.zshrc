# === ZSH Configuration by iWas <3 === #


#########################
# === POWERLEVEL10K === #
#########################
# Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Prompt Init
autoload -Uz promptinit
promptinit
prompt adam1
setopt histignorealldups sharehistory
# Theme
. /home/iwas/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# Modules
. /home/iwas/.zsh/.p10k.zsh
. /home/iwas/.zsh/.fzf.zsh


###############
# === ZSH === #
###############
# History
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=/home/iwas/.zsh/.zsh_history
# Completition System
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# Plugins
. /home/iwas/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /home/iwas/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
. /home/iwas/.zsh/zsh-sudo/sudo.plugin.zsh


#######################
# === KEYBINDINGS === #
#######################
bindkey -e
# Home Key
bindkey "^[[H" beginning-of-line
# End Key
bindkey "^[[F" end-of-line
# Delete Key
bindkey "^[[3~" delete-char
# Moving word-by-word with Ctrl Key
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


###################
# === ALIASES === #
###################
# Basic
alias sudo='sudo '
alias ls='lsd -v --group-dirs=first'
alias l='lsd -vlh --group-dirs=first'
alias ll='lsd -vlha --group-dirs=first'
alias cat='bat'
alias icat='kitty +kitten icat'
alias gdb='LC_ALL=en.US.UTF-8 gdb'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner -x 1280 -y 720'
alias cpu-x='sudo cpu-x -N'
alias cal='cal -m'
alias idiff='kitty +kitten diff'
alias arp-scan='sudo arp-scan -I enp5s0 --localnet -g'
alias upx='upx --color --best'
alias gdb='gdb-gef'
alias grep='grep --color=auto'
alias html2text='pyhtml2text'
alias venv.create='python3 -m venv .venv'
alias venv.activate='. .venv/bin/activate'
alias dmesg='dmesg --color=always'
alias loc='cloc'
# Custom
alias mount.vault='sudo mount -t cifs //penny.swa2.ml/wasym /home/iwas/vault -o vers=3.0,credentials=/home/iwas/.smb/penny.key,uid=1000,forceuid,gid=1000,forcegid,file_mode=0664,dir_mode=0775,sec=ntlmv2i,rw'
alias umount.vault='sudo umount /home/iwas/vault'
alias picom.start='cat /home/iwas/.xprofile | grep -i picom | bash'
alias picom.restart='killall picom; picom.start'
alias perms='stat -c "%n -> %a (%A)"'
alias rsync.mv='rsync -aP --remove-source-files'
alias rsync.cp='rsync -aP'
alias eclean-all='sudo eclean-pkg -d && sudo eclean-dist -d'
alias wttr="curl 'wttr.in/Barcelona'"
alias wttr.moon="curl 'wttr.in/moon'"
alias wttr.rich="curl 'v2d.wttr.in/Barcelona'"
alias wttr.map="curl 'v3.wttr.in/Barcelona.sxl'"
alias ffprobe.id_codec='ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1'
# Pingu
alias pingu='git --git-dir=/home/iwas/.pingu --work-tree=/'
alias pgfetch='pingu fetch --all -p -P && echo; pingu status -sb'
alias pgpush='ggtoken && pingu push'
alias pgls='pingu ls-tree --full-tree --name-only -r HEAD'
alias pglog='pingu log --graph --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%as%C(reset) %C(bold green)(%ar)%C(reset) %C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim italic white)~ %an%C(reset)" --all'
alias pgundo='pingu reset --soft HEAD@{1}'
alias pgst='pingu status -sb 2>/dev/null'
alias pgadd='pingu add -vu'
# Git
alias ggtoken='cat /home/iwas/.git/github-token.key | xclip -sel clip && echo "[+] GitHub Access Token copied successfully to the clipboard :)"'
alias ggfetch='git fetch --all -p -P && echo; ggst'
alias ggpush='ggtoken && git push'
alias ggls='git ls-tree --full-tree --name-only -r HEAD'
alias gglog='git log --graph --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%as%C(reset) %C(bold green)(%ar)%C(reset) %C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim italic white)~ %an%C(reset)" --all'
alias ggundo='git reset --soft HEAD@{1}'
alias ggst='git status -sb'
alias ggadd='git add -vu'
alias ggclean='git reset --hard && git clean -fxd'


#####################
# === FUNCTIONS === #
#####################
# Start X server from /etc/X11/xinit/xinitrc file
startx () {
  echo -n "Loading X"
  for _ in $(seq 13); do
    echo -n .
    sleep 0.2
  done
  echo -e " ok\n"
  sleep 1.25
  /bin/startx
}
# Start the Hyprland Wayland Compositor (WM + Compositing capabilities)
startw () {
  echo -n "Loading Wayland"
  for _ in $(seq 13); do
    echo -n .
    sleep 0.2
  done
  echo -e " ok\n"
  sleep 1.25
  /home/iwas/.wprofile
}
# Vi/Vim/Neovim start functions (ask if not better to straight open GNU Emacs and call it a day :D)
_prefer-emacs-over-nvim_ () { dialog --clear --title 'GNU Emacs v Neovim?' --defaultno --yesno 'Are you sure you want to use Neovim? You could open GNU Emacs (M-Return) and start working right ahead! Choose wisely...' 0 0 && /usr/bin/nvim $1; }
vi () { _prefer-emacs-over-nvim_ $1; clear; }
vim () { _prefer-emacs-over-nvim_ $1; clear; }
nvim () { _prefer-emacs-over-nvim_ $1; clear; }
# Mount and umount USBs easily!
mount.usb () { sudo mount $1 /mnt/USB --mkdir; }
umount.usb () { sudo umount /mnt/USB && sudo rmdir /mnt/USB; }
# Improved man command
man () {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}
# Create working directories for pentesting
mkt () { mkdir {nmap,content,exploits}; }
# Extract and show open ports from grepeable nmap capture.
extractPorts () {
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n"
	sleep 2
	echo -e "\t[*] IP Address: $ip_address"
	echo -e "\t[*] Open ports: $ports\n"
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"
}
# Delete file securely, avoiding its recovery using forensic procedures.
rmk () { scrub -p dod $1; shred -zun 10 -v $1; }
# Open Evince PDF Viewer in the background and detach from shell session
evince () { /usr/bin/evince "$*" &>/dev/null & disown; }
# Open Foliate E-BOOK Reader in the background and detach from shell session
foliate () { /bin/com.github.johnfactotum.Foliate "$*" &>/dev/null & disown; }
# Git branch management (wrapper for git switch && git branch)
ggbrnch () {
  # Return to previous branch
  if [ -z "$1" ]; then
    git switch -
  # List branches in local repository
  elif [ "$1" = "-l" ] && [ -z "$2" ]; then
    git branch
  # List branches in both local and remote repositories
  elif [ "$1" = "-la" ] && [ -z "$2" ]; then
    git branch -a
  # Create and switch to given branch
  elif [ "$1" = "-c" ] && [ ! -z "$2" ]; then
    git switch "$1" "$2"
  # Delete given branch (can be a remote one, if stated)
  elif [ "$1" = "-d" ] && [ ! -z "$2" ]; then
    git branch "$1" "$2"
  # Switch to given branch
  elif [ ! -z "$1" ] && [ -z "$2" ]; then
    git switch "$1"
  else
    echo "[-] Incorrect syntax :("
  fi
}
# Add an annotated tag to current commit pointed by local HEAD
ggtag () {
  if [ ! -z "$1" ] && [ ! -z "$2" ] && [ $# -eq 2 ]; then
    git tag -s -a "$1" -m "$2"
  else
    echo "[-] Incorrect syntax :("
  fi
}
# List or init/update registered submodules
ggmod () {
  if [ -z "$1" ]; then
    git submodule status --recursive
  elif [ "$1" = "fetch" ]; then
    git submodule update --init --recursive
  elif [ "$1" = "pull" ]; then
    git submodule update --init --recursive --remote --merge
  else
    echo "[-] Incorrect syntax :("
  fi
}
# Show CWD as shell's title instead of 'zsh'
precmd () { print -Pn "\e]0;%~\a" }
# Games
games () {
  if [ -z "$1" ]; then
    ls /usr/local/games -I '*.*'
  elif [ "$1" = "-v" ] && [ -z "$2" ]; then
    ls -1 /usr/local/games -I '*.*'
  elif [ "$1" = "-vv" ] && [ -z "$2" ]; then
    for game in $(ls /usr/local/games -I '*.*'); do
      ls -1 /usr/local/games/$game 
      realpath /usr/local/games/$game &>/dev/null \
        && du -sh $(dirname $(realpath /usr/local/games/$game))
    done
  fi
}
# FFMPEG Plex Transcoding
ffmpeg.plex_transcoding () {
  if [ "$2" = "-o" ] && [ ! -z "$3" ]; then
    ffmpeg               \
      -hwaccel cuda      \
      -i "$1"            \
      -map 0             \
      -crf 18            \
      -vf format=yuv420p \
      -c:v h264_nvenc    \
      -c:a copy          \
      -c:s copy          \
      -preset medium     \
      -b:v 12M           \
      "$3"
  else
    echo "[-] Incorrect syntax :("
  fi
}
# FFMPEG (ffplay) with NVIDIA's CUVID (decode) codecs support
ffplay.cuvid () {
  codec=$(ffprobe.id_codec "$1")
  if [[ "$codec" =~ ^(av1|h264|hevc|mjpeg|mpeg1|mpeg2|mpeg4|vc1|vp8|vp9)$ ]]; then
    ffplay -vcodec "${codec}_cuvid" "$1"
  else
    echo "[-] Codec not supported (try plain 'ffplay') :("
  fi
}
# 7z list archive's content without additional information (clean format)
7z.ls () { 7z l -ba "$1" | grep -oP '\S+$'; }
# Podman save repository (image with all tags) to tar.gz with progress (tqdm)
podman.save () {
  podman save "$1" | tqdm --bytes --total $(
    podman inspect "$1" --format='{{.Size}}'
  ) | gzip > "$1".tar.gz
}
# Podman load repository (image with all tags) from tar.gz with progress (tqdm)
podman.load () {
  pv "$1" | podman load
}
# Podman create a vanilla Debian instance
podman.deb () {
  podman run                             \
    --rm                                 \
    -it                                  \
    --name debian-ct                     \
    -v /etc/bash/bashrc-ct:/root/.bashrc \
    debian                               \
    /bin/bash
  podman rmi debian
}
# Podman create a Gentoo stage3 shell environment
podman.gentoo_shell () {
  xhost +
  podman run                                                                        \
    --rm                                                                            \
    -it                                                                             \
    --name "$(hostname)-ct"                                                         \
    --hostname "$(hostname)-ct"                                                     \
    -e DISPLAY=$DISPLAY                                                             \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro                                             \
    -v /etc/portage/make.conf:/etc/portage/make.conf:ro                             \
    -v /etc/portage/package.accept_keywords:/etc/portage/package.accept_keywords:ro \
    -v /etc/portage/package.license:/etc/portage/package.license:ro                 \
    -v /etc/portage/package.mask:/etc/portage/package.mask:ro                       \
    -v /etc/portage/package.use:/etc/portage/package.use:ro                         \
    -v /etc/portage/patches:/etc/portage/patches:ro                                 \
    gentoo/stage3                                                                   \
    sh -c "emerge-webrsync && /bin/bash -i"
  xhost -
  podman rmi gentoo/stage3
}
# Podman create a Haskell dev environment (devcontainer)
podman.dev.haskell () {
  podman run                             \
    --rm                                 \
    -it                                  \
    --name "haskell-dev-ct"              \
    --hostname "haskell-dev-ct"          \
    -v /etc/bash/bashrc-ct:/root/.bashrc \
    -v $(pwd):/root/dev                  \
    -w /root/dev                         \
    haskell                              \
    /bin/bash
  podman rmi haskell
}
# Podman create a Java dev environment (devcontainer)
podman.dev.java () {
  podman run                             \
    --rm                                 \
    -it                                  \
    --name "java-dev-ct"                 \
    --hostname "java-dev-ct"             \
    -v $(pwd):/root/dev                  \
    -w /root/dev                         \
    mcr.microsoft.com/devcontainers/java \
    sh -c "apt update && apt install -y maven && /bin/bash -i"
  podman rmi mcr.microsoft.com/devcontainers/java
}
# Podman create a Nim dev environment (devcontainer)
podman.dev.nim () {
  podman run                             \
    --rm                                 \
    -it                                  \
    --name "nim-dev-ct"                  \
    --hostname "nim-dev-ct"              \
    -v /etc/bash/bashrc-ct:/root/.bashrc \
    -v $(pwd):/root/dev                  \
    -w /root/dev                         \
    nimlang/nim                          \
    /bin/bash
  podman rmi nimlang/nim
}
# Minikube create custom cluster
minikube.start () {
  [ "$#" -ne 4 ] && echo "[-] Incorrect syntax :(" && return 1
  minikube start                                             \
    --driver qemu2                                           \
    --qemu-firmware-path "/usr/share/edk2-ovmf/OVMF_CODE.fd" \
    --nodes "$1"                                             \
    --cpus "$2"                                              \
    --memory "${3}g"                                         \
    --disk-size "${4}g"                                      \
    --network builtin                                        \
    --kvm-gpu true                                           \
    --bootstrapper kubeadm                                   \
    --container-runtime cri-o                                \
    --kubernetes-version stable                              \
    --delete-on-failure true                                 \
    --keep-context true
}


################
# === PATH === #
################
# Base PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin
# Adding AppImages to PATH
export PATH=$PATH:/usr/local/appimages
# Adding Games to PATH
export PATH=$PATH:/usr/local/games
# Adding CUDA to PATH
export PATH=$PATH:/opt/cuda/bin
# Adding local binaries to PATH
export PATH=$PATH:/home/iwas/.local/bin
# Adding Wine to PATH
export PATH=$PATH:/etc/eselect/wine/bin


#################
# === OTHER === #
#################
# Add GPG key to tty
export GPG_TTY=$(tty)


###############
# === END === #
###############
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

