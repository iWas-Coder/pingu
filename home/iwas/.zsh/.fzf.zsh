# === Ensure PATH === #
if [[ ! "$PATH" == */home/iwas/.zsh/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/iwas/.zsh/fzf/bin"
fi

# === Auto-completion === #
[[ $- == *i* ]] && . "/home/iwas/.zsh/fzf/shell/completion.zsh" 2> /dev/null

# === Key bindings === #
. "/home/iwas/.zsh/fzf/shell/key-bindings.zsh"
