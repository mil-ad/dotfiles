eval "$(starship init zsh)"

source ~/.dotfiles/colored-man-pages.zsh
source ~/.dotfiles/wd.zsh
source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/exports.zsh
source ~/.dotfiles/bindkey.zsh
source ~/.dotfiles/fzf.zsh

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
