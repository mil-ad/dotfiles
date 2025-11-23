eval "$(starship init zsh)"

source $ZDOTDIR/bindkey.zsh
source $ZDOTDIR/wd.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/s.zsh

#source <(av completion zsh)

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local

# bun completions
# [ -s "/home/milad/.bun/_bun" ] && source "/home/milad/.bun/_bun"
