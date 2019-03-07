#!/bin/bash

RESDIR=~/.resources

cd $RESDIR

# Copy dot files and sync
cp ~/.bashrc $RESDIR/dots/bashrc
cp ~/.bash_logout $RESDIR/dots/bash_logout
cp ~/.bash_profile $RESDIR/dots/bash_profile
cp ~/.gtkrc-2.0 $RESDIR/dots/gtkrc-2.0
cp ~/.xinitrc $RESDIR/dots/xinitrc
cp ~/.xprofile $RESDIR/dots/xprofile
cp ~/.Xresources $RESDIR/dots/Xresources
cp ~/.conkyrc $RESDIR/dots/conkyrc
cp /etc/nanorc $RESDIR/dots/nanorc

# Copy config
mkdir -p $RESDIR/config/xfce4/xfconf
cp -R ~/.config/xfce4/xfconf/xfce-perchannel-xml $RESDIR/config/xfce4/xfconf
cp -R ~/.config/autostart $RESDIR/config
cp -R ~/.config/deadbeef $RESDIR/config
cp -R ~/.config/gedit $RESDIR/config
cp -R ~/.config/GIMP $RESDIR/config
cp -R ~/.config/inkscape $RESDIR/config
cp -R ~/.config/polybar $RESDIR/config
cp -R ~/.config/rofi $RESDIR/config
cp -R ~/.devilspie $RESDIR/config

# Themes
cp -R ~/.themes/* $RESDIR/themes/

# Applications
cp ~/.local/share/applications/chrome-https___mail.yandex.com_neo2.desktop $RESDIR/share/applications
cp ~/.local/share/applications/chrome-https___mediainfo.slack.com.desktop $RESDIR/share/applications
cp ~/.local/share/applications/chrome-https___toggl.com_app.desktop $RESDIR/share/applications
cp ~/.local/share/applications/chrome-https___translate.yandex.com_.desktop $RESDIR/share/applications
cp ~/.local/share/applications/com.viber.Viber.desktop $RESDIR/share/applications

# Sync Scripts Directory
rsync -avzh $RESDIR/* marko@mistik-pi.local:/home/marko/External/Dump/Home/Resources --delete --progress

# Sync Documents
rsync -avzh ~/Documents/Notes/* marko@mistik-pi.local:/home/marko/External/Documents/Notes --progress 

# Sync Projects
rsync -avzh ~/Projects/ marko@mistik-pi.local:/home/marko/External/Projects/Current/ --delete --progress

# Sync E-Books
# rsync -avzh /home/marko/.calibre/ marko@mystic-server:/home/Primary/E-books/ --delete --progress

exit 0
