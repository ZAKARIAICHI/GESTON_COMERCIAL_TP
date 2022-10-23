CREATE DATABASE Gestion_Commercial ;
USE Gesion_Commercial ;
CREATE TABLE client (
Numclient int PRIMARY KEY AUTO_INCREMENT,
    Raisonsocial varchar(30) NOT NULL,
    addressclient varchar(40) NOT null,
    villeclient varchar(40) NOT null,
    telephone int NOT null
);
CREATE TABLE Commande (
	numCommande int AUTO_INCREMENT PRIMARY KEY,
	numclient int NOT NULL,
    dateCommande Date NOT NULL,
    CONSTRAINT fk_numclient FOREIGN KEY(numclient) REFERENCES client(numClient)

);
CREATE TABLE Produit (
	Refproduit int PRIMARY KEY AUTO_INCREMENT,
    Nomproduit varchar(30) NOT NULL,
    Prixunitair Varchar(40) not NULL,
    Qtestocke varchar(30) NOT NULL,
    disponible varchar(10) NOT NULL
);
Use gestion_commercial;
CREATE TABLE detailcommande (
  		Numcommande INT,
  		Refproduit int,
  		Qtecommande varchar(30),
  		primary key (Numcommande,Refproduit),
  		CONSTRAINT fk_Numcommande FOREIGN KEY(Numcommande) REFERENCES commande(Numcommande),
  		CONSTRAINT fk_Refproduit FOREIGN KEY(Refproduit) REFERENCES produit(Refproduit)
);
/*1-La liste de tous les clients*/

select *
 from client

/*2- La liste de tous les produits.*/

select *
 from Produit

/*3-Le numéro et la ville de tous les clients*/

SELECT numclient,villeclient from client

/*4-Le numéro client, la raison sociale et le téléphone de tous les clients*/
SELECT numclient,villeclient,telephone from client 
/*5-Les informations sur le client dont le numéro est « 15 »*/
SELECT numclient,villeclient
 from client
WHERE numclient = 1
/*6-La liste des clients triée par raison sociale en ordre décroissant. (Z → A)*/
SELECT *
FROM client
ORDER BY Raisonsocial ASC
/*7-La liste des clients triée par raison sociale en ordre décroissant (Z → A) puis par ville en ordre
croissant (A → Z).*/
SELECT *
FROM client
ORDER BY villeclient DESC
/*8-La liste des clients dont la raison sociale commence par S.*/
SELECT * 
FROM client
WHERE Raisonsocial LIKE 'S%';
/*9-La liste des clients dont la raison sociale se termine par E.*/
SELECT * 
FROM client
WHERE Raisonsocial LIKE '%E';
/*10-Liste des clients dont la raison sociale commence par A et se termine par E.*/
SELECT *
 FROM client
WHERE Raisonsocial LIKE 'A%E';
/*11-Liste des clients dont la raison sociale commence par A ou se termine par E.*/
SELECT * 
FROM client
WHERE Raisonsocial LIKE 'A%E';
/*12-Liste des clients habitant Casablanca, Rabat ou Ouarzazate.*/
select *
 FROM client
WHERE villeclient= "casablanca" and villeclient= "Rabat" or ville = "Ouarzazate"
/*13-Liste des produits dont le prix est de 300 dh*/
select *
 FROM produit
where Prixunitair=300;
/*14-Liste des produits dont le prix est inférieur à 300 dhs.*/

select *
 FROM produit
where Prixunitair=<300;
/*14-Liste des produits dont le prix est entre 300 dhs et 5000 dhs.*/
select * 
FROM produit
where Prixunitair Between 300 and 5000;
/*-16 Liste des produits disponibles.*/
select * 
from produit 
where disponible = "disponible"
/*17-Liste des produits dont le prix est supérieur à 300 dhs et non disponible.*/
select * FROM produit
where Prixunitair>300 and disponible = "disponible" ;
/*18-Liste des commandes passées le 11/01/2016*/
SELECT *
 FROM commande 
 where  dateCommande = '2016/11/01'
/*19- Liste des commandes passées après le 11/01/2016.*/
 SELECT * FROM 
 commande where
 dateCommande >'2016/11/01'
/*20-Liste des commandes passées entre le 01/02/2016 et 31/03/2016.*/
 SELECT * 
 FROM commande 
 where  dateCommande BETWEEN '2016/10/01'AND '2016/11/02'
 /*21-Liste des commandes passées l’année en cours.*/
 SELECT * 
 FROM commande
WHERE YEAR(dateCommande)=year(GETUTCDATE());
 /*22-Liste des commandes passées un mois de juillet*/
 SELECT * FROM commande
WHERE MONTH(dateCommande)=7;
/*23-Afficher pour chaque produit sa valeur de stock (Prix_Unitaire * Qté_Stock).*/
SELECT (Prix_Unitaire * Qté_Stock) as valeur_de_stock
from produit;
/*25-Liste des villes clients sans redondance*/
SELECT client.villeclient
from client INNER JOIN commande
 on client.Numclient= commande.numclient
/*26-Liste des clients ayants passés une commande.*/
SELECT *
from client INNER JOIN commande
 on client.Numclient= commande.numclient
/*27-Liste des produits commandés*/
SELECT *
FROM produit INNER JOIN detailcommande  
on detailcommande.Refproduit = produit.Refproduit; 	
/*28-Liste des produits commandés*/
SELECT *
FROM produit INNER JOIN detailcommande  
on detailcommande.Refproduit = produit.Refproduit; 	
/*29-Liste des commandes réalisées par le client « 15 »*/
SELECT *
FROM commande INNER JOIN  client 
on commande.numclient = client.Numclient
WHERE client.Numclient=15
/*30- Les produits concernés par la commande numéro 5*/
SELECT *
FROM produit INNER JOIN  detailcommande 
on produit.Refproduit = detailcommande.Refproduit
WHERE detailcommande.Numcommande=5
/*31- Les produits concernés par des commandes réalisées le 19/09/2020*/
SELECT *
FROM commande INNER JOIN  detailcommande 
on commande.numCommande = detailcommande.Numcommande
WHERE commande.dateCommande='19/09/2020'
/*33-Les produits commandés par « 15 ».*/
SELECT *
FROM produit INNER JOIN detailcommande on detailcommande.Refproduit = produit.Refproduit
WHERE detailcommande.Numcommande=15;
/*34-Nombre des clients*/
SELECT COUNT(*) as nombre_client
FROM client;
/*35-Nombre des clients habitant « Berlin »*/
SELECT COUNT(*) as nombre_client
FROM client
WHERE villeclient = 'Berlin'
;
/*36-Nombre des produits disponibles.*/
SELECT COUNT(*) as nombre_produit_disponible
FROM produit
WHERE  disponible = ' disponible'
;
/*37-Nombre des produits indisponibles*/
SELECT COUNT(*) as nombre_produit_indisponible
FROM produit
WHERE  disponible = 'indisponible'
;
/*38-Le plus grand prix.*/
SELECT MIN(Prixunitair)
FROM produit
/*39-Le plus petit prix*/
SELECT MAX(Prixunitair)
FROM produit
/*40-La moyenne des prix.*/
SELECT AVG(Prixunitair)
FROM produit
/*41-La somme de tous les prix*/
SELECT SUM(Prixunitair)
FROM produit
/*42-Le nombre de commandes réalisées par un client à saisir son numéro*/
SELECT DISTINCT(COUNT(*)),Numclient AS nombre_de_commandes
FROM commande;
/*43-Les clients ayant passé plus que deux commandes.*/
SELECT client.Numclient 
FROM client INNER JOIN commande on commande.numclient = client.Numclient
WHERE COUNT(*)>=2
/* 50-Liste des commandes réalisées par un client habitant « Madrid » ou dont la ville de livraisonest « Madrid »*/
SELECT *
FROM commande INNER JOIN client ON client.Numclient = commande.numclient
WHERE client.villeclient="Madrid" OR addressclient= "Madrid"
/* 51-Afficher pour chaque commande réalisée la ville du client l’ayant passée et la ville de livraison*/
SELECT client.villeclient, client.addressclient AS  ville_livraison
FROM commande
INNER JOIN client ON client.Numclient = commande.numclient
/* 52-Liste des villes (adresse de client et lieu de livraison)*/
SELECT client.villeclient AS VILLE, client.addressclient AS  LISTE_VILLE
FROM commande INNER JOIN client ON client.Numclient = commande.numclient