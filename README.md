### Dependencies

- xcwd https://github.com/schischi/xcwd
A simple tool that prints the current working directory of the currently focused window 

### Symbolic links creation

```
sudo ln -s $HOME/Workspaces/rc/.bashrc  ~/.bashrc
sudo ln -s -f $HOME/Workspaces/rc/.bashrc  ~/.bashrc
sudo ln -s -f $HOME/Workspaces/rc/.vimrc  ~/.vimrc
sudo ln -s -f $HOME/Workspaces/rc/nvim/init.vim ~/.config/nvim/init.vim
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
sudo ln -s $HOME/Workspaces/rc/.psqlrc ~/.psqlrc
sudo ln -s $HOME/Workspaces/rc/.alacritty.toml ~/.alacritty.toml
sudo ln -s $HOME/Workspaces/rc/starship.toml ~/.config/starship.toml
sudo ln -s $HOME/Workspaces/rc/.ideavimrc ~/.ideavimrc
sudo ln -s $HOME/Workspaces/rc/profile ~/.profile

```

### Keyboard variants
To list all variants for us layout: `localectl list-x11-keymap-variants us`

IBus can also sometimes override settings from /etc/default/keyboard. You can use the ibus-setup command to modify the settings for IBus. To force it to defer to the settings from /etc/default/keyboard, run ibus-setup, go to the Advanced tab, and check Use system keyboard layout.

### Restore packages
The file `pkglist` can be re-generated with:
```sudo dpkg --get-selections | sed "s/.*deinstall//" | sed "s/install$//g" > ~/pkglist```

The packages can then be installed with:
```
sudo aptitude update && cat pkglist | xargs sudo aptitude install -y
```

### Low battery warning
Install https://github.com/rjekker/i3-battery-popup/blob/master/i3-battery-popup


### Point `docker-compose` to `docker compose`

1. Create a little script /bin/docker-compose
with content `docker compose "$@"`

2. Make the script executable: sudo chmod +x /bin/docker-compose

3. Check that it works with `docker-compose version`


### Disable screen saver timeout and power saving
https://askubuntu.com/questions/763994/screen-times-out-in-i3-wm


### Copy-pasting with nvim / X11
`sudo apt install xclip`
