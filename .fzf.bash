# Setup fzf
# ---------
if [[ ! "$PATH" == */home/carolavillo/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/carolavillo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/carolavillo/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/carolavillo/.fzf/shell/key-bindings.bash"
