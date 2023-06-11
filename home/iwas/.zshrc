# === ZSH Configuration by iWas <3 === #


#########################
# === POWERLEVEL10K === #
#########################
# Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Prompt Init
autoload -Uz promptinit
promptinit
prompt adam1
setopt histignorealldups sharehistory
# Theme
source /usr/share/custom-zsh/powerlevel10k/powerlevel10k.zsh-theme
# Modules
[[ -f /usr/share/custom-zsh/.p10k.zsh ]] && source /usr/share/custom-zsh/.p10k.zsh
[[ -f /usr/share/custom-zsh/.fzf.zsh ]] && source /usr/share/custom-zsh/.fzf.zsh


###############
# === ZSH === #
###############
# History
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=/usr/share/custom-zsh/.zsh_history
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
source /usr/share/custom-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/custom-zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/custom-zsh/zsh-sudo/sudo.plugin.zsh


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
alias vi='nvim'
alias vim='nvim'
alias gdb='LC_ALL=en.US.UTF-8 gdb'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'
alias mpv='mpv --hwdec=nvdec-copy --vo=gpu'
alias cpu-x='sudo cpu-x -N'
alias cal='cal -m'
alias idiff='kitty +kitten diff'
alias arp-scan='sudo arp-scan -I enp5s0 --localnet -g'
alias upx='upx --color --best'
alias gdb='gdb-gef'
alias grep='grep --color=auto'
alias startx='echo "[*] Preparing X environment..." && for _ in $(seq 1000); do echo -n . && sleep 0.0078125; done && echo -e "\n[*] Starting X...\n" && sleep 1 && /bin/startx'
alias startw='echo "[*] Preparing Wayland environment..." && for _ in $(seq 1000); do echo -n . && sleep 0.0078125; done && echo -e "\n[*] Starting Wayland...\n" && sleep 1 && /home/iwas/.wprofile'
alias html2text='pyhtml2text'
alias venv.create='python3 -m venv .venv'
alias venv.activate='source .venv/bin/activate'
alias dmesg='dmesg --color=always'
alias loc='cloc'
alias emacs='emacsclient -c'
# Custom
alias stopx='killall kitty && killall X'
alias lock='/usr/share/lockscreen/lock'
alias mount.vault='sudo mount -t cifs //penny.swa2.ml/wasym /home/iwas/vault -o credentials=/home/iwas/.smb/penny.key,uid=1000,forceuid,gid=1000,forcegid,file_mode=0664,dir_mode=0775,sec=ntlmv2i,rw'
alias umount.vault='sudo umount /home/iwas/vault'
alias picom.restart="pidof picom | xargs kill -9 &>/dev/null; cat /home/iwas/.xprofile | grep -i picom | bash"
alias perms='stat -c "%n -> %a (%A)"'
alias pdfview='evince'
alias reset.shell="source $HOME/.zshrc && reset"
alias mksquashfs.backup="sudo mksquashfs / sheldon-$(date +'%Y%m%d').bak -processors 10 -e /boot /dev /lost+found /media /mnt /proc /run /sys /tmp /var /home/iwas/data /home/iwas/vault /home/iwas/.config/chromium"
alias rsync.mv='rsync -aP --remove-source-files'
alias rsync.cp='rsync -aP'
alias eclean-all='sudo eclean-pkg -d && sudo eclean-dist -d'
alias libreoffice-cli='/usr/bin/libreoffice "-env:UserInstallation=file:///tmp/LibreOffice_Conversion_${USER}" --headless'
alias chromium.backup="tar -zcvf /home/iwas/vault/backups/chromium.bak/chromium-config.inc-$(date +'%Y%m%d').tar.gz -g /home/iwas/vault/backups/chromium.bak/incremental.diff /home/iwas/.config/chromium /home/iwas/.config/chromium-flags.conf"
# Pingu
alias pingu='git --git-dir=/home/iwas/.pingu --work-tree=/'
alias pingu-fetch='pingu fetch --all -p -P && echo; pingu status'
alias pingu-push='ggtoken && pingu push'
alias pingu-list='pingu ls-tree --full-tree --name-only -r HEAD'
alias pingu-update='pingu add -v -u'
alias pingu-log='pingu log --graph --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%as%C(reset) %C(bold green)(%ar)%C(reset) %C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim italic white)~ %an%C(reset)"'
# Git Custom
alias ggtoken='cat /home/iwas/.git/github-token.key | xclip -sel clip && echo "[+] GitHub Access Token copied successfully to the clipboard :)"'
alias ggfetch='git fetch --all -p -P && echo; git status'
alias ggpush='ggtoken && git push'
alias ggadd='git add -A; git status'
alias gglog='git log --graph --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%as%C(reset) %C(bold green)(%ar)%C(reset) %C(bold yellow)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim italic white)~ %an%C(reset)"'
alias ggundo='git reset --soft HEAD@{1}'
alias ggst='git status'
alias ggmod='git submodule update --init --recursive'


# === FUNCTIONS === #
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
# Libreoffice Suite
libreoffice () { /usr/bin/libreoffice "$*" &>/dev/null & disown; }
# Start working in a Git repository (ggfetch && open VSCode)
ggcode () { ggfetch && code $(git rev-parse --show-toplevel) }
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
ggtag () {
  if [ ! -z "$1" ] && [ ! -z "$2" ] && [ $# -eq 2 ]; then
    git tag -s -a "$1" -m "$2"
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
  if [ ! -z "$2" ] && [ "$2" = "-o" ] && [ ! -z "$3" ]; then
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
# 7z list archive's content without additional information (clean format)
7z.ls () { 7z l -ba "$1" | grep -oP '\S+$'; }
# Docker build image from Dockerfile in CWD
docker.build () {
  sudo docker build -t "$1" . && sudo docker image prune -f
}
# Docker save repository (image with all tags) to tar.gz with progress (tqdm)
docker.save () {
  sudo docker save "$1" | tqdm --bytes --total $(
    sudo docker inspect "$1" --format='{{.Size}}'
  ) | gzip > "$1".tar.gz
}
# Docker load repository (image with all tags) from tar.gz with progress (tqdm)
docker.load () {
  pv "$1" | sudo docker load
}


# === PATH === #
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


# === OTHER === #
# Add GPG key to tty
export GPG_TTY=$(tty)
# Set Kubernetes contexts (in .kube directory)
for context in $(ls /home/iwas/.kube | grep .yaml); do
  if [ -z "$KUBECONFIG" ]; then
    export KUBECONFIG=/home/iwas/.kube/"$context"
  else
    export KUBECONFIG=$KUBECONFIG:/home/iwas/.kube/"$context"
  fi
done


# === END === #
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

