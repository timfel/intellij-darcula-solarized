#!/bin/bash

find_intellij() {
    read -e -p "Please type the location of IntelliJ installation: " location
    location="${location/#\~\//$HOME\/}"
    echo $location
}

location="$(find_intellij)"
ideajar="$(find "$location" -name idea.jar)"

# backup
if [ ! -d backup ]; then
    mkdir -p backup
    pushd backup
    jar -xfv "$ideajar" com/intellij/ide/ui/laf/darcula/darcula.properties 
    popd
fi

case "$1" in
    "dark")
	folder=solarized-dark
	;;
    "light")
	folder=solarized-light
	;;
    "restore")
	folder=backup
	;;
    *)
	echo "You must specify $1 (dark|light|restore)"
	exit 0
esac

pushd $folder
jar -ufv "$ideajar" com/intellij/ide/ui/laf/darcula/darcula.properties 
popd
