source ~/.dotfiles/antigen.zsh

antigen use oh-my-zsh

antigen bundle wd
antigen bundle colored-man-pages
antigen bundle pip
antigen bundle docker
antigen bundle ssh-agent
antigen bundle zsh-users/zsh-completions

antigen apply

eval "$(starship init zsh)"

source ~/.dotfiles/aliases
source ~/.dotfiles/exports

# fzf keybinding and completion on Linux
[ -e /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -e /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
# fzf keybinding and completion on macOS
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cache -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

[ -e .zshrc_local ] && source .zshrc_local
