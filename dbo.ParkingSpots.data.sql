SET IDENTITY_INSERT [dbo].[ParkingSpots] ON
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (1, N'Downtown Parking', N'Pune', N'MG Road', 18.5204, 73.8567, 5, CAST(50.00 AS Decimal(10, 2)))
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (2, N'Kothrud Parking Lot', N'Pune', N'Kothrud', 18.5102, 73.831, 20, CAST(50.00 AS Decimal(10, 2)))
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (3, N'Hinjewadi IT Park Parking', N'Pune', N'Hinjewadi', 18.5941, 73.736, 15, CAST(100.00 AS Decimal(10, 2)))
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (4, N'Andheri West Parking', N'Mumbai', N'Andheri', 19.1005, 72.8492, 30, CAST(80.00 AS Decimal(10, 2)))
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (5, N'Bandra Beach Parking', N'Mumbai', N'Bandra', 19.0598, 72.83, 10, CAST(120.00 AS Decimal(10, 2)))
INSERT INTO [dbo].[ParkingSpots] ([ParkingID], [Name], [City], [Area], [Latitude], [Longitude], [AvailableSpots], [Price]) VALUES (6, N'Viman Nagar Parking', N'Pune', N'Viman Nagar', 18.5656, 73.9196, 12, CAST(70.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[ParkingSpots] OFF
