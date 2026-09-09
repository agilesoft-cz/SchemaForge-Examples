CREATE TABLE [dbo].[Reservation]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CompanyId] INT NOT NULL,
    [CustomerId] INT NOT NULL,
    [VehicleId] INT NOT NULL,
    [ParkingSpaceId] INT NOT NULL,
    [ReservationStatusId] INT NOT NULL,
    [StartDate] DATETIME2 NOT NULL,
    [EndDate] DATETIME2 NOT NULL,

    [Author] NVARCHAR(255) NOT NULL,
    [Created] DATETIME2 NOT NULL,
    [Editor] NVARCHAR(255) NULL,
    [Modified] DATETIME2 NULL,
    [IsDeleted] BIT NOT NULL CONSTRAINT [DF_Reservation_IsDeleted] DEFAULT (0),

    CONSTRAINT [PK_Reservation]
        PRIMARY KEY ([Id]),

    CONSTRAINT [FK_Reservation_Company]
        FOREIGN KEY ([CompanyId])
        REFERENCES [dbo].[Company] ([Id]),

    CONSTRAINT [FK_Reservation_Customer]
        FOREIGN KEY ([CustomerId])
        REFERENCES [dbo].[Customer] ([Id]),

    CONSTRAINT [FK_Reservation_Vehicle]
        FOREIGN KEY ([VehicleId])
        REFERENCES [dbo].[Vehicle] ([Id]),

    CONSTRAINT [FK_Reservation_ParkingSpace]
        FOREIGN KEY ([ParkingSpaceId])
        REFERENCES [dbo].[ParkingSpace] ([Id]),

    CONSTRAINT [FK_Reservation_ReservationStatus]
        FOREIGN KEY ([ReservationStatusId])
        REFERENCES [dbo].[ReservationStatus] ([Id]),

    CONSTRAINT [CK_Reservation_DateRange]
        CHECK ([EndDate] > [StartDate])
);