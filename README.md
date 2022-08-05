### Symbolic links creation

```
sudo ln -s $HOME/Workspaces/rc/.bashrc  ~/.bashrc
sudo ln -s -f $HOME/Workspaces/rc/.bashrc  ~/.bashrc
sudo ln -s -f $HOME/Workspaces/rc/.vimrc  ~/.vimrc
sudo ln -s -f $HOME/Workspaces/rc/.gitconfig  ~/.gitconfig
sudo ln -s -f $HOME/Workspaces/rc/.gitignore_global  ~/.gitignore_global
sudo ln -s -f $HOME/Workspaces/rc/i3config  ~/.config/i3/config
sudo ln -s -f $HOME/Workspaces/rc/.git-completion.bash  ~/.git-completion.bash
sudo ln -s -f $HOME/Workspaces/rc/.fzf.bash  ~/.fzf.bash
sudo ln -s -f $HOME/Workspaces/rc/ftplugin  ~/.vim/ftplugin
sudo ln -s $HOME/Workspaces/rc/Xresources ~/.Xresources
sudo ln -s $HOME/Workspaces/rc/keyboard /etc/default/keyboard
sudo ln -s $HOME/Workspaces/rc/touchpad.conf  /etc/X11/xorg.conf.d/touchpad.conf
sudo ln -s $HOME/Workspaces/rc/yamllint  ~/.config/yamllint/config
sudo ln -s $HOME/Workspaces/rc/nightly.desktop  $HOME/
sudo ln -s $HOME/Workspaces/rc/polybar ~/.config/polybar

```

### Keyboard variants
To list all variants for us layout: `localectl list-x11-keymap-variants us`

### Restore packages
The file `pkglist` can be re-generated with:
```sudo dpkg --get-selections | sed "s/.*deinstall//" | sed "s/install$//g" > ~/pkglist```

The packages can then be installed with:
```
sudo aptitude update && cat pkglist | xargs sudo aptitude install -y
```

### Low battery warning
Install https://github.com/rjekker/i3-battery-popup/blob/master/i3-battery-popup
