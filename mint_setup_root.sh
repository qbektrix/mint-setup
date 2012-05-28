#!/bin/bash
set -e

# Update and upgrade from all repositories
apt-get update -y
apt-get upgrade -y

# Downgrade to GCC 4.5
apt-get -y purge gcc
apt-get -y install gcc-4.5 g++-4.5 build-essential
if [ -e /usr/bin/gcc ]; then rm -f /usr/bin/gcc ; fi
if [ -e /usr/bin/g++ ]; then rm -f /usr/bin/g++ ; fi
ln /usr/bin/gcc-4.5 /usr/bin/gcc
ln /usr/bin/g++-4.5 /usr/bin/g++ 

# Install StumpWM and dependencies
apt-get purge -y pulseaudio
apt-get install -y stumpwm network-manager-gnome trayer cl-swank cl-clx-sbcl xloadimage alsa-utils
cp -f $(pwd)/conf/stumpwm/stumpwm.desktop /usr/share/xsessions/stumpwm.desktop

# Install Google Chrome
if !(grep -q google /etc/apt/sources.list)
  then echo "deb http://dl.google.com/linux/deb/ stable non-free main #Google" | tee -a /etc/apt/sources.list > /dev/null
fi
apt-get update
apt-get install -y --force-yes google-chrome-stable
apt-get upgrade -y google-chrome

# Install Skype (should be in Mint repos)
apt-get install -y skype

# Install Coffeescript
apt-get install -y curl nodejs
curl http://npmjs.org/install.sh | sh
npm install -g coffee-script

# Install miscellaneous stuff
apt-get -y install emacs k3b ccrypt eclipse autoconf libusb-dev xclip pdftk gqview gimp gnome-rdp xtightvncviewer lyx latex2html lynx pwgen dosbox tofrodos gettext net-tools audacity lame php5-cli php5-curl gparted vice dia frotz inform wine curl xsane libxine1-ffmpeg git-core subversion shtool libxslt-dev libssl-dev libpq-dev inotify-tools libnotify-bin acidrip libsqlite3-dev libreadline-gplv2-dev openssh-server gitg

# Install LISP stuff
apt-get -y install guile-1.8 sbcl plt-scheme

# Configure VICE
cp -R $(pwd)/conf/vice/* /usr/lib/vice -R

# Build SBCL from source, so we're using a good version with threading enabled
apt-get -y install clisp
mkdir /tmp/sbcl
cp $(pwd)/src/sbcl-1.0.54-source.tar.gz /tmp/sbcl
pushd /tmp/sbcl
tar -zxvf sbcl-1.0.54-source.tar.gz
cd sbcl-1.0.54
sh make.sh clisp --with-sb-thread --fancy
INSTALL_ROOT=/usr/local sh install.sh
popd
rm -rf /tmp/sbcl

# Make StumpWM use SBCL, not CLISP
apt-get purge -y clisp
if !(grep -q sbcl /etc/profile)
  then echo export LISP=sbcl >> /etc/profile
fi

