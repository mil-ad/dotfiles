eval "$(starship init zsh)"

source $ZDOTDIR/exports.zsh
source $ZDOTDIR/options.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/keybindings.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/wd.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/s.zsh

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local

#source <(av completion zsh)

# bun completions
# [ -s "/home/milad/.bun/_bun" ] && source "/home/milad/.bun/_bun"
