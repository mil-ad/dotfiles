# Milad's dotfiles 🐣

My configuration files for Linux and macOS.

## Usage

Clone this repository into `~/.dotfiles` and create the symbolic links using [GNU Stow](https://www.gnu.org/software/stow/):

```shell
$ git clone https://github.com/mi-lad/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ stow common linux
```

On a fresh install you'd probably want to to run `install` instead of the `stow` step above as the script also sets up tools like `antigen`, `vimplug`, etc.


## TODO

```
# TODO: Checkout https://gist.github.com/garethrees/2470157
# https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh
# TODO: Remind me why you're not using a simple bash script?
# TODO: Turn off dashboard: defaults write com.apple.dashboard mcx-disabled -boolean TRUE; killall Dock


# TODO: touch .hushlogin # to remove the "Last login" message in the terminal
# See https://apple.stackexchange.com/questions/118984/why-doesnt-my-terminal-show-last-login-message

# - shell:
    # - [defaults write com.apple.Dock autohide-delay -float 0 && killall Dock, Remove the delay for Auto-Hide & Auto-Show of Dock]
    # - [defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock, Remove dock animation]
    # - [defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1, Set sidebar icon size to small"]
    # - [defaults write -g ApplePressAndHoldEnabled -bool false, Enable key repeat]
```