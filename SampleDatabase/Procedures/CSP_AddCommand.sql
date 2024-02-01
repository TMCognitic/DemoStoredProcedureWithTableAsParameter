CREATE PROCEDURE [dbo].[CSP_AddCommand]
	@Produits TProduit READONLY -- <-- READONLY est obligatoire
AS
BEGIN
	-- Je vérifie que je n'ai pas envoyés de produit avec une quantité négative
	IF EXISTS(SELECT * FROM @Produits WHERE Quantite < 1)
	BEGIN
		RAISERROR ('La quantité doit être supérieur à 0', 16, 1);
		RETURN -1;
	END


	DECLARE @Count INT;	
	SELECT @Count = COUNT(*) FROM @Produits;

	BEGIN TRANSACTION AddCommand
	
	IF @Count > 0
	BEGIN
		BEGIN TRY
			DECLARE @CommandeId INT;
			-- J'insère ma commande dans la table commande
			INSERT INTO Commande ([Date]) VALUES (DEFAULT);
			-- Je récupère l'id de la commande qui a été généré (identity)
			SET @CommandeId = SCOPE_IDENTITY();

			-- J'insère les produit commandé en utilisant ce numéro de commande
			INSERT INTO Detail (CommandeId, ProduitId, Quantite)
			SELECT @CommandeId, ProduitId, Quantite
			FROM @Produits;

			COMMIT TRANSACTION AddCommand;
		END TRY
		BEGIN CATCH
			DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @Severity INT = ERROR_SEVERITY();
			DECLARE @State INT = ERROR_STATE();
			ROLLBACK TRANSACTION AddCommand;
			
			RAISERROR (@Message, @Severity, @State)
			RETURN;
		END CATCH

		IF @@TRANCOUNT > 0
		BEGIN
			COMMIT
		END
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION AddCommand;
	END
END
