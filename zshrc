source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

antigen bundle wd
antigen bundle sublime
antigen bundle colored-man
antigen bundle sublime
antigen bundle docker
antigen bundle aws

# Load the theme.
# antigen theme refined
antigen theme agnoster

# Tell Antigen that you're done.
antigen apply

source ~/.dotfiles/aliases
source ~/.dotfiles/exports
source ~/.dotfiles/functions

if [ -e .zshrc_private ]; then
    source .zshrc_private
fi
