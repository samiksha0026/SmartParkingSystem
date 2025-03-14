INSERT INTO Bookings (UserID, VehicleNo, SlotID, BookingDate, CheckInTime, CheckOutTime, TotalAmount, PaymentStatus)
VALUES (1, 'MH12AB1234', 5, GETDATE(), GETDATE(), DATEADD(HOUR, 2, GETDATE()), 100.00, 'Paid');
