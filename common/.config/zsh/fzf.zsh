# Cache `fzf --zsh` output; regenerate only when the fzf binary is newer.
_fzf_init="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/fzf-init.zsh"
[[ $_fzf_init -nt $commands[fzf] ]] || fzf --zsh > "$_fzf_init"
source "$_fzf_init"
unset _fzf_init

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude .cache .'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--color=pointer:#d79921 --prompt="⚡"'

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

bindkey ${FZF_WD_BINDKEY:-'^B'} wd_browse_widget
