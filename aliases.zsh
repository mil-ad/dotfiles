#!/bin/env zsh

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias .....="cd ../../../../.."
alias ......="cd ../../../../../.."

alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias -- -='cd -'

alias ssh="TERM=xterm-256color ssh"
alias kssh="kitten ssh"

alias gcloud="TERM=xterm-256color gcloud"
alias gscat="gsutil cat"
alias gsls="gsutil ls"
alias gsrm="gsutil -m rm"

alias ag='ag --hidden --ignore-case --color-match="1;31" --silent'
alias agc='ag --hidden --ignore-case --color-match="1;31" --silent -C 2'
alias agf='ag --hidden --ignore .git --ignore .cache -g""'

alias g="rg --hidden --smart-case -g '!.git'"
alias gc="rg --hidden --smart-case -g '!.git' --context 3"
alias f='fd --hidden --exclude .git --exclude .cache'

# micromamba
alias mm="micromamba"
alias mma="micromamba activate"
alias mmc="micromamba create --name"
alias mmd="micromamba deactivate"
alias mmls='micromamba env list'
alias mmrm='micromamba env remove --yes --name'

alias p="git pull"
alias P="git push"
alias gcm="git commit -m"
alias gs='git status'
alias goops='git rebase -i HEAD~2'

alias gwls='git worktree list'
alias gwadd='git worktree add'
alias gwrm='git worktree remove'
alias gwmv='git worktree move'

if command -v lsd &> /dev/null; then
    alias ls="lsd"
    alias l='lsd -l --group-directories-first'
    alias ll='lsd -la --group-directories-first'
    alias ldot='lsd -ld .*'
else
    alias l='ls -lh'
    alias ll='ls -lah'
fi
alias lsym='ls -l `find . -maxdepth 1 -type l -print`'

alias more="less"
alias vi="nvim"
alias vim='NVIM_APPNAME="nvim-kickstart" nvim'
alias cal='cal -3'

alias df='df -h'
alias du='du -h'
alias du0='du -h --max-depth 0 | sort -hr'
alias du1='du -h --max-depth 1 | sort -hr'
alias du2='du -h --max-depth 2 | sort -hr'
alias du3='du -h --max-depth 3 | sort -hr'
alias tree1='tree -L 1'
alias tree2='tree -L 2'
alias tree3='tree -L 3'
alias difffolders='diff -rq'

alias tmux2clipboard='tmux capture-pane -pS - | kitten clipboard'
alias weather='curl wttr.in/London'

if [[ $(uname) == 'Darwin' ]]; then
    alias yay='brew upgrade && brew upgrade --cask'
fi

alias pre-commit-file="pre-commit run --file"

alias json2jsonl="jq -c .[]"
alias jsonl2json="jq -s"

alias parquetcat="parquet-tools cat --format='json'"
