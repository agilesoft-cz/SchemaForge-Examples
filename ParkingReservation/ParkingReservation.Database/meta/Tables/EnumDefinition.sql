CREATE TABLE [meta].[EnumDefinition]
(
    [Id]             INT IDENTITY(1, 1) NOT NULL,
    [Name]           NVARCHAR(100)       NOT NULL,
    [UnderlyingType] NVARCHAR(20)        NOT NULL DEFAULT 'int',
    [Description]    NVARCHAR(500)           NULL,

    CONSTRAINT [PK_EnumDefinition_Id]
        PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [UX_EnumDefinition_Name]
        UNIQUE ([Name])
);
GO