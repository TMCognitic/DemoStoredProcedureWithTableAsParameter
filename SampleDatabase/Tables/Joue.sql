CREATE TABLE [dbo].[Joue]
(
	[GuitaristeId] INT NOT NULL,
	[GuitareId] INT NOT NULL,
	CONSTRAINT PK_Joue PRIMARY KEY (GuitaristeId, GuitareId), 
    CONSTRAINT [FK_Joue_Guitariste] FOREIGN KEY ([GuitaristeId]) REFERENCES [Guitariste]([Id]), 
    CONSTRAINT [FK_Joue_Guitare] FOREIGN KEY ([GuitareId]) REFERENCES [Guitare]([Id]),
	
)
