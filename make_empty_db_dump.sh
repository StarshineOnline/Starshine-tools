#!/bin/sh

## Get connect info
pushd ../trunk
if [ ! -f connect.php ] ; then
	echo "Cannot get connection info"
	exit 1
fi
user=`cat ./connect.php | grep \'user\' | cut -d\" -f4`
db=`cat ./connect.php | grep \'db\' | cut -d\" -f4`
password=`cat ./connect.php | grep \'pass\' | cut -d\" -f4`
host=`cat ./connect.php | grep \'host\' | cut -d\" -f4`
if [ ! -z $password ]; then
    pass="-p$password"
fi
if [ ! -z $host ]; then
    conn="-h $host"
fi
popd

defaultopts="--default-character-set=utf8 $conn -u $user $pass $db"

mysql $defaultopts -e "drop table if exists map_vide"
mysql $defaultopts -e "create table map_vide as select * from map"
mysql $defaultopts -e "update map_vide set royaume = 0 where type != 1"

## Dump table structures
defaultopts="--no-create-db $defaultopts"
mysqldump --add-drop-table --no-data $defaultopts > starshine.sql

## Get static tables content
tables="comp_combat comp_jeu accessoire arme armure classe classe_comp_permet classe_permet classe_requis gemme monstre objet quete recette sort_combat sort_jeu taverne terrain_batiment pnj map_vide royaume"
mysqldump --no-create-info $defaultopts $tables >> starshine.sql

echo "insert into \`map\` select * from \`map_vide\` ;" >> starshine.sql

## Commit it
rm -f starshine.sql.bz2
bzip2 starshine.sql
rm -f starshine.sql
svn commit --non-interactive -m "auto-generation de la base SSO" starshine.sql.bz2 make_empty_db_dump.sh
