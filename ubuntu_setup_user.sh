#!/bin/bash

# Link custom config
if [ ! -f ~/.xinitrc   ]; then ln -s $(pwd)/conf/fvwm/x/xinitrc ~/.xinitrc      ; fi  
if [ ! -f ~/.emacs     ]; then ln -s $(pwd)/conf/emacs/emacs ~/.emacs           ; fi
if [ ! -d ~/.emacs.d   ]; then ln -s $(pwd)/conf/emacs/emacs.d ~/.emacs.d       ; fi
if [ ! -f ~/.Xkbmap    ]; then ln -s $(pwd)/conf/gnome/Xkbmap ~/.Xkbmap         ; fi
if [ ! -f ~/.stumpwmrc ]; then ln -s $(pwd)/conf/stumpwm/stumpwmrc ~/.stumpwmrc ; fi

# Custom Bash setup, but only once (edit bash_extras to make changes)
if grep -q "037b7c29-5804-43e2-8054-d1ebfb0f3293" ~/.bashrc ;
then
    echo Bash confugration extras already added to ~/.bashrc.
else
    mkdir ~/bin
    echo >> ~/.bashrc
    echo \# Personal Bash configuration extras, added by ubuntu_setup.sh >> ~/.bashrc
    echo \# 037b7c29-5804-43e2-8054-d1ebfb0f3293 >> ~/.bashrc
    echo . $(pwd)/conf/bash_extras.sh >> ~/.bashrc
    echo >> ~/.bashrc
fi

# Get WineTricks for future use
if [ -f ~/bin/winetricks.sh ]; then rm -f ~/bin/winetricks.sh ; fi  
wget http://www.kegel.com/wine/winetricks
mv $(pwd)/winetricks ~/bin/winetricks.sh
chmod a+x ~/bin/winetricks.sh


