#!/bin/sh
prod="/srv/starshine-data/starshine/starshine071"
user=`cat ${prod}/connect.php | grep \'user\' | cut -d\" -f4`
db=`cat ${prod}/connect.php | grep \'db\' | cut -d\" -f4`
password=`cat ${prod}/connect.php | grep \'pass\' | cut -d\" -f4`
host=`cat ${prod}/connect.php | grep \'host\' | cut -d\" -f4`
if [ ! -z $password ]; then
    pass="-p$password"
fi
if [ ! -z $host ]; then
    conn="-h $host"
fi

EXECFILE=`mktemp`

TABLES="accessoire achievement_perso_variable action_perso amende arenes arenes_joueurs argent_royaume arme armure bataille bataille_groupe bataille_groupe_repere bataille_repere bataille_repere_type batiment batiment_ville bonus bonus_permet bonus_perso bourse_royaume buff buff_monstre candidat classe classe_comp_permet classe_permet classe_requis comp_combat comp_jeu comp_perso construction construction_arme_siege construction_ville craft_instrument craft_recette craft_recette_ingredient craft_recette_instrument craft_recette_recipient depot_royaume diplomatie diplomatie_demande donjon echange echange_objet elections gemme grade grimoire groupe groupe_joueur hotel invitation j_stats jabber_admin journal last log_admin log_connexion map map_monstre map_zone message messagerie_etat messagerie_message messagerie_thread monstre motd motk objet objet_royaume options perso perso_code perso_recette pet placement pnj point_victoire_action prime_criminel quete quete_royaume recette revolution rez royaume sort_combat sort_favoris sort_jeu stat_jeu taverne teleport terrain terrain_batiment terrain_chantier terrain_coffre terrain_construction terrain_laboratoire titre_honorifique users variable vente_terrain vote vote_revolution"

cat > $EXECFILE <<EOF
use starshine_backup ;
EOF

for i in $TABLES ; do
    cat >> $EXECFILE <<EOF
drop table if exists starshine_backup.${i} ;
create table starshine_backup.${i} as select * from ${db}.${i} ;
EOF
done

#cat $EXECFILE

mysql --default-character-set=utf8 -e "source $EXECFILE" $conn -u $user $pass $db

rm -f $EXECFILE
