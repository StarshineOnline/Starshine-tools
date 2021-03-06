#!/bin/bash

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

cpy_to map map_vide "where x <= 190 and y <= 190" "set royaume = 0 where type != 1"
cpy_to map_event map_event_vide "where x <= 190 and y <= 190" "set x=x where 1=0"

## Dump table structures
defaultopts="--no-create-db $defaultopts"
mysqldump --add-drop-table --no-data $defaultopts > starshine.sql

## Get static tables content
tables="accessoire achievement_type arme armure batiment batiment_ville batiment_bonus bonus bonus_permet boss_loot classe classe_comp_permet classe_permet classe_requis comp_combat comp_jeu craft_recette craft_recette_ingredient craft_recette_instrument craft_recette_recipient db_auto_maj donjon donjon_entry_point gemme grade grimoire map_type_calque map_zone monstre objet objet_royaume objet_pet pnj point_victoire_action quete recette royaume sort_combat sort_jeu taverne terrain_batiment"
tmp_tables="map_vide map_event_vide"
mysqldump --no-create-info $defaultopts $tables $tmp_tables >> starshine.sql

cat >> starshine.sql <<EOF
--
-- Finalisation
--

-- Generation de la map (vide)
insert into map select * from \`map_vide\`;
insert into map_event select * from \`map_event_vide\`;

-- RAZ des royaumes
update royaume set ministre_economie = 0, ministre_militaire = 0, capitale_hp = 30000, fin_raz_capitale = 0, bourg = 0, pierre = 10000, bois = 10000, eau = 10000, sable = 10000, charbon = 10000, essence = 10000, food = 10000, alchimie = 0 ;

-- Initialisation des constructions des villes
insert into construction_ville select null, royaume.id, minref.id_batiment, 'actif', 0, hp, 0 from royaume, (select min(id) as id_batiment, nom, cout, entretien, type, level, hp from batiment_ville group by type) minref ;

-- Initialisation des elections
insert into elections select null, id, last_day(now()) + INTERVAL 1 DAY, 'universel' from royaume where id > 0 ;

-- Initialisation de la diplo (manque les 127, qui viennent apres)
insert into diplomatie select race, 5,5,5,5,5,5,5,5,5,5,5 from royaume;

-- DROP tables de test
drop table map_sav;
drop table map_poids;
drop table map_old;
drop table test_char_semantics;
drop table test_para_sil;
drop table test_pm;
drop table test_vol;

EOF

races="barbare elfebois elfehaut humain humainnoir mortvivant nain orc scavenger troll vampire"
for race in $races ; do
		echo "update diplomatie set $race = 127 where race = '$race' ;" >> starshine.sql
done

for tbl in $tmp_tables ; do
		echo "-- drop table $tbl ;" >> starshine.sql
done

## Commit it
rm -f starshine.sql.bz2
bzip2 starshine.sql
rm -f starshine.sql
git add starshine.sql.bz2 make_empty_db_dump.sh
git commit -m "auto-generation de la base SSO"
