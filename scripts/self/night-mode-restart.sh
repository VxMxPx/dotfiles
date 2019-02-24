#!/bin/bash

# Reset gnome-shell night mode.

gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
sleep 1
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
