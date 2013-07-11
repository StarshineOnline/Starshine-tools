-- vue pour l'auth SSO
CREATE VIEW sso as SELECT j.login, p.nom, j.mdp, j.droits, p.race, p.rang_royaume, p.groupe FROM `starshine_prod`.`perso` AS p, `starshine_prod`.`joueur` AS j WHERE j.id = p.id_joueur AND p.statut = 'actif';
