CREATE SECURITY POLICY [dbo].[CompanyFilterPolicy]
ADD FILTER PREDICATE [dbo].[fn_FilterCompanies](
    CONVERT(INT, SESSION_CONTEXT(N'UserId')),
    CONVERT(BIT, SESSION_CONTEXT(N'IsService')),
    [Id],
    [IsDeleted])
ON [dbo].[Company]
WITH (STATE = ON);
GO