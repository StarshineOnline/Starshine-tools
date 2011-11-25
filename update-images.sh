#!/bin/sh
if id -un | grep -q root ; then
    echo switching to starshine user
    exec sudo -u starshine sh $0 $*
fi
if ! id -un | grep -q starshine ; then
    echo Error: you must be starshine
    exit 1
fi

if [ -z "$1" ] ; then
		target=master
else
		target="$1"
fi

REPO=/srv/starshine-data/git_repo/Starshine-images
PROD=/srv/starshine-data/starshine/image

set -x

cd $REPO
git fetch || exit 1
git reset --soft refs/remotes/origin/master || exit 1
git archive $target | tar -x -C $PROD
exit 0
