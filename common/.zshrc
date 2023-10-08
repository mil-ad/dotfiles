eval "$(starship init zsh)"

source ~/.dotfiles/colored-man-pages.zsh
source ~/.dotfiles/wd.zsh
#fpath=(~/.dotfiles $fpath)

source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/exports.zsh
source ~/.dotfiles/bindkey.zsh
source ~/.dotfiles/fzf

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
