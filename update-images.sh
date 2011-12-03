#!/bin/sh
if id -un | grep -q root ; then
    echo switching to starshine user
    exec sudo -u starshine sh $0 $*
fi
if ! id -un | grep -q starshine ; then
    echo Error: you must be starshine
    exit 1
fi

PROD_IMG=/srv/starshine-data/starshine/image

if [ -f /home/starshine/config.sh ] ; then
	. /home/starshine/config.sh
fi

set -x

cd $PROD_IMG
git pull
if [ ! -z "$1" ] ; then
	git checkout $1
fi

chmod g+w $PROD_IMG/cart $PROD_IMG/carte $PROD_IMG/cart/carte_roy_*

exit 0

