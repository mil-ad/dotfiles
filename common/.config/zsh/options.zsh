# General shell behavior options that don't fit in history/completion/keys.

# Directory navigation: type a path with no `cd`, and push every cd onto a
# stack you can navigate with `cd -<TAB>` / aliases like `1`, `2`, ...
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Disable Ctrl-S / Ctrl-Q flow control so those keys are free for bindings.
unsetopt flowcontrol

# Allow `# comments` typed at the interactive prompt (handy for parking
# a command in history with a note).
setopt interactive_comments
