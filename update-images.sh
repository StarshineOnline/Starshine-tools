#!/bin/sh
if id -un | grep -q root ; then
    echo switching to starshine user
    exec sudo -u starshine sh $0 $*
fi
if ! id -un | grep -q starshine ; then
    echo Error: you must be starshine
    exit 1
fi

PROD=/srv/starshine-data/starshine/image

set -x

cd $PROD
git pull
if [ ! -z "$1" ] ; then
	git checkout $1
fi

chmod g+w $PROD/cart $PROD/carte $PROD/cart/carte_roy_*

exit 0

