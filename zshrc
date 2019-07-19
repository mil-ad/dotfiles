source ~/.dotfiles/antigen.zsh

antigen use oh-my-zsh

antigen bundle wd
antigen bundle colored-man-pages
antigen bundle pip
antigen bundle docker
antigen bundle zsh-users/zsh-completions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

source ~/.dotfiles/aliases
source ~/.dotfiles/exports
source ~/.dotfiles/functions
source ~/.dotfiles/evals

if [ -e /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [ -e /usr/share/fzf/completion.zsh ]; then
    source /usr/share/fzf/completion.zsh
fi

if [ -e .zshrc_local ]; then
    source .zshrc_local
fi

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
