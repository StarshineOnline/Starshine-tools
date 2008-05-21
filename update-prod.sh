#!/bin/sh
if id -un | grep -q root ; then
    echo switching to starshine user
    exec sudo -u starshine sh $0 $*
fi
if ! id -un | grep -q starshine ; then
    echo Error: you must be starshine
    exit 1
fi
function do_patch
{
    url="http://tools.assembla.com/svn/starshine/tags/$1"
    svn sw $url prod
    exit 0
}
echo Recherche des tags disponibles :
TAGS=`svn ls http://tools.assembla.com/svn/starshine/tags`
echo $TAGS
if [ -z $1 ]; then
    echo -n "Quel tag voulez-vous mettre en production ? "
    read TAG
else
    TAG=$1
fi
for pos in $TAGS ; do
    if [ "$TAG/" = "$pos" ]; then
        echo ok
        do_patch $pos
    fi
    if [ "$TAG" = "$pos" ]; then
	echo ok
	do_patch $pos
    fi
done
echo Tag invalide, reessayez
exit 1