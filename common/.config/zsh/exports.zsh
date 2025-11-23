export EDITOR=vim
export KEYTIMEOUT=5

# Without this the SSH remote environment in VS Code has a hard time prompting
# for passphrase when signing git commits
export GPG_TTY=$(tty)

if [[ $(uname) == 'Darwin' ]]; then
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
fi
