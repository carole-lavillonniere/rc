### Symbolic links creation

```
ln -s $HOME/Workspaces/rc/Xresources ~/.Xresources
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
