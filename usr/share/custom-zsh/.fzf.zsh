# === Ensure PATH === #
if [[ ! "$PATH" == */usr/share/custom-zsh/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/share/custom-zsh/fzf/bin"
fi

# === Auto-completion === #
[[ $- == *i* ]] && source "/usr/share/custom-zsh/fzf/shell/completion.zsh" 2> /dev/null

# === Key bindings === #
source "/usr/share/custom-zsh/fzf/shell/key-bindings.zsh"
