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
