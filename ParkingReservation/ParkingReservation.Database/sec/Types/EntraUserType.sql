CREATE TYPE [sec].[EntraUserType] AS TABLE
(
    [SourceId]          NVARCHAR(50)    NOT NULL PRIMARY KEY,
    [Name]              NVARCHAR(256)   NOT NULL,
    [Email]             NVARCHAR(256)   NOT NULL,
    [UserPrincipalName] NVARCHAR(256)   NOT NULL,
    [MobilePhone]       NVARCHAR(64)    NOT NULL,
    [JobTitle]          NVARCHAR(256)   NOT NULL,
    [Department]        NVARCHAR(256)   NOT NULL,
    [PreferredLanguage] NVARCHAR(32)    NOT NULL,
    [AccountEnabled]    BIT             NOT NULL
);