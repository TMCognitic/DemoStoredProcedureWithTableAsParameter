CREATE PROCEDURE [dbo].[CSP_AddGuitariste]
	@Nom NVARCHAR(50),
	@Prenom NVARCHAR(50),
	@Guitares TGuitareId READONLY
AS
BEGIN
	DECLARE @Count INT;	
	SELECT @Count = COUNT(*) FROM @Guitares;

	BEGIN TRANSACTION AddGuitariste
	
	IF @Count > 0
	BEGIN
		BEGIN TRY
			DECLARE @GuitaristeId INT;
			-- J'insère mon guitariste dans la table commande
			INSERT INTO Guitariste(Nom, Prenom) VALUES (@Nom, @Prenom);
			-- Je récupère l'id du guitariste qui a été généré (identity)
			SET @GuitaristeId = SCOPE_IDENTITY();

			-- J'insère les guitares en utilisant l'id du guitariste
			INSERT INTO Joue (GuitaristeId, GuitareId)
			SELECT @GuitaristeId, GuitareId
			FROM @Guitares;

			COMMIT TRANSACTION AddGuitariste;
		END TRY
		BEGIN CATCH
			DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @Severity INT = ERROR_SEVERITY();
			DECLARE @State INT = ERROR_STATE();
			ROLLBACK TRANSACTION AddGuitariste;
			
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
		ROLLBACK TRANSACTION AddGuitariste;
	END
END
