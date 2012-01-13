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

REPO=/srv/starshine-data/git_repo/Starshine-Online
PROD=/srv/starshine-data/starshine/starshine071

if [ -f /home/starshine/config.sh ] ; then
	. /home/starshine/config.sh
fi

set -x

cd $REPO
git fetch origin '+refs/heads/*:refs/heads/*' || exit 1
git reset --soft master || exit 1
git archive $target | tar -x -C $PROD
git log | head -1 | cut -d\  -f2 > $PROD/version.txt
chmod g+w $PROD/arenes/ $PROD/arenes/admin/

cd $PROD/sql
php db_check_auto_maj.php
exit 0

