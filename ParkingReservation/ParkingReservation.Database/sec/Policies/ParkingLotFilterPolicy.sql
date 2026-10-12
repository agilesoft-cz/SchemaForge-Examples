CREATE SECURITY POLICY [dbo].[ParkingLotFilterPolicy]
ADD FILTER PREDICATE [dbo].[fn_FilterParkingLots](
    CONVERT(INT, SESSION_CONTEXT(N'UserId')),
    CONVERT(BIT, SESSION_CONTEXT(N'IsService')),
    [CompanyId],
    [IsDeleted])
ON [dbo].[ParkingLot]
WITH (STATE = ON);
GO