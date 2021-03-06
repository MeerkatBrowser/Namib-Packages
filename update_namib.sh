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
    git clone https://github.com/namiblinux/namib-keyring
    git clone https://github.com/namiblinux/namib-mirrorlist
    git clone https://github.com/MeerkatBrowser/nhwd
    git clone https://github.com/MeerkatBrowser/nhwd-db
    git clone https://github.com/namiblinux/ckbcomp
    git clone https://github.com/namiblinux/materia-namib-theme
    git clone https://github.com/namiblinux/materia-namib-kde

    #Get calamares package
    get_package "calamares" \
    "https://raw.githubusercontent.com/namiblinux/Namib-Calamares/master/pkg/PKGBUILD"

    #Get Namib Wallpapers Package
    get_package "namib-wallpapers" \
    "https://raw.githubusercontent.com/namiblinux/Namib-Wallpapers/master/PKGBUILD" \
    
    #Get namib-config-system
    get_package "namib-config-system" \
    "https://raw.githubusercontent.com/namiblinux/Namib-Config-System/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/Namib-Config-System/master/pkg/namib-config-system.install"
    
    #Get namib-base-skel package
    get_package "namib-base-skel" \
    "https://raw.githubusercontent.com/namiblinux/namib-desktop-settings/master/pkg/PKGBUILD" \
	"https://raw.githubusercontent.com/namiblinux/namib-desktop-settings/master/pkg/namib-base-skel.install"
    
    #Get namib-mate-settings package
    get_package "namib-mate-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-mate-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-mate-settings/master/pkg/namib-mate-settings.install"

    #Get namib-gnome-settings package
    get_package "namib-gnome-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-gnome-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-gnome-settings/master/pkg/namib-gnome-settings.install"

    #Get namib-xfce-settings package
    get_package "namib-xfce-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-xfce-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-xfce-settings/master/pkg/namib-xfce-settings.install"

    #Get namib-kde-settings package
    get_package "namib-kde-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-kde-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-kde-settings/master/pkg/namib-kde-settings.install"

    #Get namib-budgie-settings package
    get_package "namib-budgie-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-budgie-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-budgie-settings/master/pkg/namib-budgie-settings.install"

    #Get namib-cinnamon-settings package
    get_package "namib-cinnamon-settings" \
    "https://raw.githubusercontent.com/namiblinux/namib-cinnamon-settings/master/pkg/PKGBUILD" \
    "https://raw.githubusercontent.com/namiblinux/namib-cinnamon-settings/master/pkg/namib-cinnamon-settings.install"

    #Get namib-welcome package
    get_package "namib-welcome" \
    "https://raw.githubusercontent.com/namiblinux/namib-welcome/master/pkg/PKGBUILD"

	#Get namib-settings-manager
    get_package "namib-settings-manager" \
    "https://raw.githubusercontent.com/namiblinux/namib-settings-manager/master/pkg/PKGBUILD"
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
