﻿CREATE TABLE [dbo].[Guitare]
(
	[Id] INT NOT NULL IDENTITY, 
	[Nom] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Guitare] PRIMARY KEY ([Id]) 
)