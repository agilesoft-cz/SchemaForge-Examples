CREATE SECURITY POLICY [dbo].[ParkingSpaceFilterPolicy]
ADD FILTER PREDICATE [dbo].[fn_FilterParkingSpaces](
    CONVERT(INT, SESSION_CONTEXT(N'UserId')),
    CONVERT(BIT, SESSION_CONTEXT(N'IsService')),
    [ParkingLotId],
    [IsDeleted])
ON [dbo].[ParkingSpace]
WITH (STATE = ON);
GO