#!/bin/env zsh

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias .....="cd ../../../../.."
alias ......="cd ../../../../../.."

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias ssh="TERM=xterm-256color ssh"

alias gcloud="TERM=xterm-256color gcloud"
alias gscat="gsutil cat"
alias gsls="gsutil ls"

alias jqpager="jq -C | less -R"

alias mm="micromamba"
alias mma="micromamba activate"
alias mmc="micromamba create --name"
alias mmd="micromamba deactivate"
alias mmls='micromamba env list'
alias mmrm='micromamba env remove --yes --name'
alias condarm='conda env remove --name'

alias gs='git status'
alias goops='git rebase -i HEAD~2'

alias gwls='git worktree list'
alias gwadd='git worktree add'
alias gwrm='git worktree remove'
alias gwmv='git worktree move'

alias icat='kitty +kitten icat'

if command -v exa &> /dev/null
then
    alias l='exa -l --group-directories-first'
    alias ls="exa"
    alias ll='exa -laH --group-directories-first'
    alias ldot='exa -ld .*'
else
    alias l='ls -lh'
    alias ll='exa -laHh'
fi
alias lsym='ls -l `find . -maxdepth 1 -type l -print`'

alias ag='ag --hidden --ignore-case --color-match="1;31" --silent'
alias agc='ag --hidden --ignore-case --color-match="1;31" --silent -C 2'
alias agf='ag --hidden --ignore .git --ignore .cache -g""'

alias more="less"
alias vi="nvim"
alias vim="nvim"
alias cal='cal -3'
#alias tmux="tmux -2" # Force 256 colour support
alias df='df -h'
alias du='du -h'

alias tmuxdump='capture-pane -pS -'

alias psmem='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3 | head -10'

alias weather='curl wttr.in/London'
alias difffolders='diff -rq'

alias present_remotely='nohup pdfpc -Ssg -w presentation'

if [[ $(uname) == 'Darwin' ]]; then
    alias yay='brew upgrade && brew upgrade --cask'
fi
