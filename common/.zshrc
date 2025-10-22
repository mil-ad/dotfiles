eval "$(starship init zsh)"

source ~/.dotfiles/bindkey.zsh
source ~/.dotfiles/wd.zsh
source ~/.dotfiles/s.zsh
source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/functions.zsh
source ~/.dotfiles/exports.zsh
source ~/.dotfiles/fzf.zsh

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
