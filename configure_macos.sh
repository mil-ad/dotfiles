# Checkout links below for more examples:
#   https://gist.github.com/garethrees/2470157
#   https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh

# Stop "Last login" messages from appearing in the terminal
[[ ! -e ~/.hushlogin ]] && touch ~/.hushlogin

# Disable the delay for Auto-Hide & Auto-Show of Dock
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock

# Disable dock animation
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
