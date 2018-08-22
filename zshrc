source ~/.dotfiles/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

antigen bundle wd
antigen bundle sublime
antigen bundle colored-man-pages
antigen bundle docker

# Pure prompt
antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure
antigen bundle mi-lad/pure # My fork until the official repo fixes the conda prompt bug

# Tell Antigen that you're done.
antigen apply

source ~/.dotfiles/aliases
source ~/.dotfiles/exports
source ~/.dotfiles/functions
source ~/.dotfiles/evals

if [ -e .zshrc_private ]; then
    source .zshrc_private
fi
