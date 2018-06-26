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

function copyto_upload_dir() {
    mv *.pkg.tar.xz ../upload
}

function make_loop() {
    mkdir upload
    for dir in */ ;
    do
        dir=${dir%*/}
        if [ "$dir" == "." ] || [ "$dir" == ".." ] || [ "$dir" == "upload" ]; then
            continue;
        fi
	    cd $dir
	    makepkg -f -s -c -d
        copyto_upload_dir
        echo "makepkg from "$dir" finished"
        cd ..
    done
}

function sign_packages(){
    cd upload
    FILES=*.pkg.tar.xz
    for f in $FILES
    do
        echo "Signing $f file..."
        gpg --detach-sign --no-armor $f
    done

    cd ..
}

function create_repo() {
    repo-add --sign upload/namibrepo.db.tar.gz upload/*.pkg.tar.xz
}

make_loop
sign_packages
create_repo
