CREATE TABLE [dbo].[ReservationStatus]
(
    [Id] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,

    CONSTRAINT [PK_ReservationStatus]
        PRIMARY KEY ([Id]),

    CONSTRAINT [UQ_ReservationStatus_Name]
        UNIQUE ([Name])
);