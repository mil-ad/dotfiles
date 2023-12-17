[ -e /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -e /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cache -g ""'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude .cache .'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}
