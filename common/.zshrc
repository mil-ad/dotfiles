#source ~/.dotfiles/antigen.zsh

# antigen use oh-my-zsh

#antigen bundle wd
#antigen bundle colored-man-pages
# antigen bundle pip
# antigen bundle docker
# antigen bundle zsh-users/zsh-completions

#antigen apply

eval "$(starship init zsh)"

source ~/.dotfiles/colored-man-pages.zsh
source ~/.dotfiles/wd.zsh
#fpath=(~/.dotfiles $fpath)

source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/exports.zsh
source ~/.dotfiles/fzf
source ~/.dotfiles/bindkey.zsh

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
