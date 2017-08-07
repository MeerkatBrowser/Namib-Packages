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
    git clone https://aur.archlinux.org/yaourt.git
    git clone https://aur.archlinux.org/pamac-aur.git
    git clone https://aur.archlinux.org/ultra-flat-icons-blue.git
    git clone https://aur.archlinux.org/mkinitcpio-openswap.git
    git clone https://aur.archlinux.org/ckbcomp.git
    git clone https://aur.archlinux.org/package-query.git
	git clone https://aur.archlinux.org/gnome-mpv.git
	git clone https://aur.archlinux.org/rhythmbox-plugin-tray-icon-git.git
	

    #Get calamares package
    get_package "calamares" \
    "https://raw.githubusercontent.com/MeerkatBrowser/Namib-Calamares/master/pkg/PKGBUILD" \
""
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
