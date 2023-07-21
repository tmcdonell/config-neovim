NeoVim Settings
===============

Settings for NeoVim

http://neovim.io

To install, clone the repository to `~/.config/nvim`.


Caveats
-------

In order to render the screen quickly (i.e. sub-millisecond) we need to
coordinate with the terminal emulator a little. Both my terminal emulator and
this NeoVim configuration use the 'Tomorrow' and 'Tomorrow Night' themes in
light and dark mode, respectively.

When using the [Kitty](https://sw.kovidgoyal.net/kitty/) shell this
configuration will automatically detect which theme is currently active in the
terminal and change the NeoVim colour scheme appropriately. There may be a way
to do this more generally (e.g. by using CSI codes).

Assumes several external tools are installed:

  * [bottom](https://clementtsang.github.io/bottom/)
  * [lazygit](https://github.com/jesseduffield/lazygit/)
  * [tree-sitter](https://tree-sitter.github.io/)

as well as a working C compiler, and maybe some other things besides...

