CREATE SECURITY POLICY [dbo].[VehicleFilterPolicy]
ADD FILTER PREDICATE [dbo].[fn_FilterVehicles](
    CONVERT(INT, SESSION_CONTEXT(N'UserId')),
    CONVERT(BIT, SESSION_CONTEXT(N'IsService')),
    [UserId],
    [IsDeleted])
ON [dbo].[Vehicle]
WITH (STATE = ON);
GO