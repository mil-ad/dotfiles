source ~/.dotfiles/antigen.zsh

antigen use oh-my-zsh

antigen bundle wd
antigen bundle colored-man-pages
# antigen bundle pip
#antigen bundle docker
antigen bundle zsh-users/zsh-completions

antigen apply

eval "$(starship init zsh)"

source ~/.dotfiles/aliases
source ~/.dotfiles/exports
source ~/.dotfiles/fzf

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
