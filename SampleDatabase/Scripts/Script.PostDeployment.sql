/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
--SET IDENTITY_INSERT Produit ON;
--INSERT INTO Produit (Id, Nom) VALUES (1, 'Coca'), (2, 'Eau'), (3, 'Chocolat');
--SET IDENTITY_INSERT Produit OFF;


--SET IDENTITY_INSERT Guitare ON;
--INSERT INTO Guitare(Id, Nom) VALUES (1, 'Gibson'), (2, 'Fender'), (3, 'Mel');
--SET IDENTITY_INSERT Guitare OFF;