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

cpy_to() { # table, tmp, cwhere, rupd
		mysql $defaultopts -e "drop table if exists $2"
		mysql $defaultopts -e "create table $2 as select * from $1 $3"
		mysql $defaultopts -e "update $2 $4"
}

cpy_to map map_vide "" "set royaume = 0 where type != 1"

## Dump table structures
defaultopts="--no-create-db $defaultopts"
mysqldump --add-drop-table --no-data $defaultopts > starshine.sql

## Get static tables content
tables="comp_combat comp_jeu accessoire arme armure classe classe_comp_permet classe_permet classe_requis gemme monstre objet quete recette sort_combat sort_jeu taverne terrain_batiment pnj royaume grade map_event"
tmp_tables="map_vide"
mysqldump --no-create-info $defaultopts $tables $tmp_tables >> starshine.sql

cat >> starshine.sql <<EOF
--
-- Finalisation
--

-- Generation de la map (vide)
insert into \`map\` select * from \`map_vide\`

-- RAZ des royaumes
update \`royaume\` set ministre_economie = 0, ministre_militaire = 0, capitale_hp = 30000, fin_raz_capitale = 0, bourg = 0, pierre = 10000, bois = 10000, eau = 10000, sable = 10000, charbon = 10000, essence = 10000, food = 10000, alchimie = 0 ;

-- Initialisation des constructions des villes
insert into construction_ville select null, royaume.id, minref.id_batiment, 'actif', 0, hp, 0 from royaume, (select min(id) as id_batiment, nom, cout, entretien, type, level, hp from batiment_ville group by type) minref ;
EOF

for tbl in $tmp_tables ; do
		echo "-- drop table $tbl ;" >> starshine.sql
done

## Commit it
rm -f starshine.sql.bz2
bzip2 starshine.sql
rm -f starshine.sql
svn commit --non-interactive -m "auto-generation de la base SSO" starshine.sql.bz2 make_empty_db_dump.sh
