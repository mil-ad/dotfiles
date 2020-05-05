# Milad's dotfiles 🐣

My dotfiles configure Linux/macOS the way I like them.

## Usage

Clone this repository into `~/.dotfiles` and create the symbolic links using [GNU Stow](https://www.gnu.org/software/stow/):

```shell
$ git clone https://github.com/mi-lad/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ stow common linux
```

## TODO


- [curl -L git.io/antigen > antigen.zsh, Installing Antigen]
- ["curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim", Installing vim-plug]
- ["curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim", Installing vim-plug for NeoVim]
