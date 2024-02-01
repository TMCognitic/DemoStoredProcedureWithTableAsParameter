CREATE TABLE [dbo].[Detail]
(
	[CommandeId] INT NOT NULL,
	[ProduitId] INT NOT NULL,
	[Quantite] INT NOT NULL,
	CONSTRAINT PK_Detail PRIMARY KEY (CommandeId, ProduitId),
	CONSTRAINT CK_Quantite CHECK (Quantite > 0),
	CONSTRAINT FK_Detail_Produit FOREIGN KEY (ProduitId)
		REFERENCES Produit(Id),
	CONSTRAINT FK_Detail_Command FOREIGN KEY ([CommandeId])
		REFERENCES Commande(Id)
)
