# Create Distribution List and add members and managed by
Connect-ExchangeOnline
New-DistributionGroup -Name "DLNAME" -DisplayName "DISPLAYNAME" -PrimarySmtpAddress primarysmtp.com -Members "MEMBER1@domain.com", "Member2@domain.com" -ManagedBy @{Add="GUIDIDOFUSER"}


# Basic Create Distribution List
New-DistributionGroup -Name 1stFloorConferenceRooms -DisplayName "1st Floor Conference Rooms" -PrimarySmtpAddress 1stFloorConferenceRooms@wfyi.org -RoomList


