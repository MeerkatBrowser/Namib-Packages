#!/bin/bash
# This file is part of the Namib GNU/Linux distribution
# Copyright (c) 2017 Meerkat Software
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

function cleanup() {
    rm -Rrf -- */
}

function cloneall() {
    git clone https://aur.archlinux.org/trizen.git
    git clone https://aur.archlinux.org/pamac-aur.git
    git clone https://aur.archlinux.org/mkinitcpio-openswap.git
    git clone https://aur.archlinux.org/package-query.git
    git clone https://aur.archlinux.org/rhythmbox-plugin-tray-icon-git.git
    git clone https://aur.archlinux.org/brisk-menu.git
    git clone https://aur.archlinux.org/pamac-tray-appindicator.git
    git clone https://aur.archlinux.org/b43-firmware.git
    git clone https://aur.archlinux.org/timeshift.git
    git clone https://aur.archlinux.org/xcursor-breeze.git
    git clone https://aur.archlinux.org/gnome-shell-extension-dash-to-panel.git
    git clone https://aur.archlinux.org/gnome-shell-extension-arc-menu-git.git
    git clone https://aur.archlinux.org/pix.git
    git clone https://aur.archlinux.org/xed.git
    git clone https://aur.archlinux.org/xviewer.git
    git clone https://aur.archlinux.org/xviewer-plugins.git
    git clone https://aur.archlinux.org/xplayer.git
    git clone https://aur.archlinux.org/vivaldi.git
    git clone https://aur.archlinux.org/whalebird-bin.git
    git clone https://aur.archlinux.org/skypeforlinux-stable-bin.git
    git clone https://aur.archlinux.org/spotify.git
    git clone https://aur.archlinux.org/gyazo.git
    git clone https://aur.archlinux.org/google-chrome.git
    git clone https://aur.archlinux.org/dropbox.git
    git clone https://aur.archlinux.org/bitwarden-bin.git
    git clone https://aur.archlinux.org/discord.git
    git clone https://aur.archlinux.org/libc++.git
    git clone https://aur.archlinux.org/slack-desktop.git
    git clone https://aur.archlinux.org/rambox-bin.git
    git clone https://aur.archlinux.org/xplayer-plparser.git
}

function get_package() {
    package=$1
    pkbuild_url=$2
    install_url=$3
    mkdir $package
    cd $package
    wget $pkbuild_url
    if [ -n "$install_url" ]; then
        wget $install_url
    fi
    cd ..
}

function delete_dotgit_dirs() {
    for dir in */ ;
    do
        dir=${dir%*/}
        if [ "$dir" == "." ] || [ "$dir" == ".." ]; then
            continue;
        fi
	    cd $dir
	    rm -rf .git
        echo "delete .git from folder "$dir
        cd ..
    done
}

cleanup
cloneall
delete_dotgit_dirs
