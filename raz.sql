-- On vide les tables
TRUNCATE TABLE achievement;
TRUNCATE TABLE achievement_compteur;
TRUNCATE TABLE action_perso;
TRUNCATE TABLE action_pet;
TRUNCATE TABLE amende;
TRUNCATE TABLE arenes_joueurs;
TRUNCATE TABLE arenes_oldbuff;
TRUNCATE TABLE bataille;
TRUNCATE TABLE bataille_groupe;
TRUNCATE TABLE bataille_groupe_repere;
TRUNCATE TABLE bataille_repere;
TRUNCATE TABLE bourse_royaume;
TRUNCATE TABLE bourse_royaume;
TRUNCATE TABLE buff;
TRUNCATE TABLE buff_batiment;
TRUNCATE TABLE buff_monstre;
TRUNCATE TABLE candidat;
TRUNCATE TABLE combats;
TRUNCATE TABLE comp_perso;
TRUNCATE TABLE construction;
TRUNCATE TABLE construction_ville;
TRUNCATE TABLE depot_royaume;
TRUNCATE TABLE diplomatie_demande;
TRUNCATE TABLE echange;
TRUNCATE TABLE echange_objet;
TRUNCATE TABLE echange_ressource_royaume;
TRUNCATE TABLE echange_royaume;
TRUNCATE TABLE elections;
TRUNCATE TABLE event;
TRUNCATE TABLE event_equipe;
TRUNCATE TABLE event_participant;
TRUNCATE TABLE event_partie;
TRUNCATE TABLE groupe;
TRUNCATE TABLE groupe_joueur;
TRUNCATE TABLE hotel;
TRUNCATE TABLE invitation;
-- TRUNCATE TABLE joueur_loot;
TRUNCATE TABLE journal;
TRUNCATE TABLE j_stats;
-- TRUNCATE TABLE last;
TRUNCATE TABLE log_admin;
TRUNCATE TABLE log_connexion;
TRUNCATE TABLE message;
TRUNCATE TABLE messagerie_etat;
TRUNCATE TABLE messagerie_message;
TRUNCATE TABLE messagerie_thread;
TRUNCATE TABLE motd;
TRUNCATE TABLE motk;
TRUNCATE TABLE options;
TRUNCATE TABLE perso;
-- TRUNCATE TABLE perso_code;
TRUNCATE TABLE perso_recette;
TRUNCATE TABLE pet;
TRUNCATE TABLE placement;
TRUNCATE TABLE prime_criminel;
TRUNCATE TABLE quete_royaume;
TRUNCATE TABLE quete_royaume;
TRUNCATE TABLE rez;
TRUNCATE TABLE sort_favoris;
TRUNCATE TABLE stat_jeu;
TRUNCATE TABLE terrain;
TRUNCATE TABLE terrain_chantier;
TRUNCATE TABLE terrain_coffre;
TRUNCATE TABLE terrain_construction;
TRUNCATE TABLE titre_honorifique;
TRUNCATE TABLE vente_terrain;
TRUNCATE TABLE vote;
TRUNCATE TABLE vote_revolution;

-- On réinitialise les valeurs
UPDATE argent_royaume SET hv=0, taverne=0, forgeron=0, armurerie=0, magasin=0, enchanteur=0, ecole_magie=0, ecole_combat=0, teleport=0, monstre=0;
UPDATE diplomatie SET elfebois=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'barbare';
UPDATE diplomatie SET barbare=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'elfebois';
UPDATE diplomatie SET barbare=5, elfebois=5, humain=5, humainnoir=5, mortvivant=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'elfehaut';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5,humainnoir=5, mortvivant=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'humain';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, mortvivant=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'humainnoir';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, humainnoir=5, nain=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'mortvivant';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, scavenger=5, troll=5, vampire=5 WHERE race LIKE 'nain';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, nain=5, troll=5, vampire=5 WHERE race LIKE 'scavenger';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, nain=5, scavenger=5, vampire=5 WHERE race LIKE 'troll';
UPDATE diplomatie SET barbare=5, elfebois=5, elfehaut=5, humain=5, humainnoir=5, mortvivant=5, nain=5, scavenger=5, troll=5, WHERE race LIKE 'vampire';
UPDATE royaume SET star=1000, point_victoire=0, point_victoire_total=0, star_nouveau_joueur=150, taxe=0, diplo_time='', honneur_candidat=0, bourg=0, pierre=100, bois=100, eau=100,sable=100,charbon=100,essence=100,food=2000, alchimie=0, roi=0, ministre_economie=0, ministre_militaire = 0, capitale_hp=50000, fin_raz_capitale=0, facteur_entretien=1, conso_food=0;

--- Bâtiments internes
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (2, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (2, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (1, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (2, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (2, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (3, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (3, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (3, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (3, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (3, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (4, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (4, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (4, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (4, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (4, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (6, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (6, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (6, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (6, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (6, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (7, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (7, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (7, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (7, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (7, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (8, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (8, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (8, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (8, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (8, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (9, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (9, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (9, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (9, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (9, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (10, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (10, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (10, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (10, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (10, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (11, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (11, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (11, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (11, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (11, 25, 0);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (12, 1, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (12, 2, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (12, 3, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (12, 4, 1000);
INSERT INTO construction_ville SET (id_royaume, id_batiment, hp) VALUES (12, 25, 0);

-- Stats
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);
INSERT INTO stat_jeu (`date`, barbare, elfebois, elfehaut, humain, humainnoir, nain, orc, scavenger, troll, vampire, mortvivant, niveau_moyen, nombre_joueur, nombre_monstre, food) VALUES
(NOW(), ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', ';0;0;0;0;0;0;0;0', 0, 0, 0, 0);


-- Quêtes tutoriels
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (1, 103);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (2, 106);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (3, 106);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (4, 122);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (6, 120);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (6, 121);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (7, 105);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (8, 123);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (10, 105);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (11, 105);
INSERT INTO quete_royaume (id_royaume, id_quete) VALUES (12, 105);

-- Monstres tutoriels
INSERT INTO map_monstre (type, x, y, hp, mort_naturelle) VALUES (208, 242, 138, 50, UNIX_TIMESTAMP() + 200000000);
INSERT INTO map_monstre (type, x, y, hp, mort_naturelle) VALUES (209, 242, 156, 40, UNIX_TIMESTAMP() + 200000000);

-- Propriété des cases de ville (basé sur les teleports)
update map m, (select r.id, t.posx x, t.posy y from teleport t, royaume r where r.race = t.race) o set m.royaume = o.id where  (m.x = o.x and m.y = o.y) or (m.x = o.x - 1 and m.y = o.y) or (m.x = o.x + 1 and m.y = o.y) or (m.x = o.x and m.y = o.y - 1) or (m.x = o.x - 1 and m.y = o.y - 1) or (m.x = o.x + 1 and m.y = o.y - 1);
