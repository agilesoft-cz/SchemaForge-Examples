CREATE TABLE [dbo].[ParkingLot]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CompanyId] INT NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [Address] NVARCHAR(500) NULL,

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL CONSTRAINT [DF_ParkingLot_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_ParkingLot]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_ParkingLot_Company]
        FOREIGN KEY ([CompanyId])
        REFERENCES [dbo].[Company] ([Id])
);