source ~/.dotfiles/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle pip
antigen bundle wd
antigen bundle sublime
antigen bundle colored-man-pages
antigen bundle docker

antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-history-substring-search

# Prompt
antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure
antigen bundle mi-lad/pure # My fork until the official repo fixes the conda prompt bug

antigen apply

source ~/.dotfiles/aliases
source ~/.dotfiles/exports
source ~/.dotfiles/functions
source ~/.dotfiles/evals

if [ -e .zshrc_private ]; then
    source .zshrc_private
fi
