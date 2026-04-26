# History storage and behavior. Big sizes because disk is cheap and
# `Ctrl-R` against a long history is occasionally a lifesaver.
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$HOME/.cache/zsh_history"

# setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # don't record consecutive duplicates
setopt hist_ignore_space        # don't record commands that start with a space
setopt hist_verify              # show command with history expansion before running it
setopt share_history            # interleave history across concurrent shells
