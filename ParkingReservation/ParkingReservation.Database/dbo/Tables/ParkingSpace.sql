CREATE TABLE [dbo].[ParkingSpace]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [ParkingLotId] INT NOT NULL,
    [Number] NVARCHAR(50) NOT NULL,
    [IsAccessible] BIT NOT NULL CONSTRAINT [DF_ParkingSpace_IsAccessible] DEFAULT (0),
    [IsElectricCharging] BIT NOT NULL CONSTRAINT [DF_ParkingSpace_IsElectricCharging] DEFAULT (0),

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL CONSTRAINT [DF_ParkingSpace_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_ParkingSpace]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_ParkingSpace_ParkingLot]
        FOREIGN KEY ([ParkingLotId])
        REFERENCES [dbo].[ParkingLot] ([Id]),

    CONSTRAINT [UQ_ParkingSpace_ParkingLot_Number]
        UNIQUE ([ParkingLotId], [Number])
);