# Cache starship's init script; regenerate only when the binary is newer.
_starship_init="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/starship-init.zsh"
[[ $_starship_init -nt $commands[starship] ]] || starship init zsh --print-full-init > "$_starship_init"
source "$_starship_init"
unset _starship_init

source $ZDOTDIR/exports.zsh
source $ZDOTDIR/options.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/keybindings.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/wd.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/hooks.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/s.zsh

[ -e $HOME/.zshrc_local ] && source $HOME/.zshrc_local
