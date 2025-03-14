using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using ZXing;
using System.IO;
using WebGrease.Activities;

namespace SmartPArkingSystem
{
    public partial class BookParking : System.Web.UI.Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadParkingDetails();
            }
        }

        private void LoadParkingDetails()
        {
            try
            {
                if (Session["ParkingID"] == null)
                {
                    lblError.Text = "Error: Parking details not found!";
                    return;
                }

                string parkingId = Session["ParkingID"].ToString();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "SELECT Name, City, Area, Price FROM ParkingSpots WHERE ParkingID = @ParkingID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ParkingID", parkingId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblParkingName.Text = reader["Name"].ToString();
                                lblCity.Text = reader["City"].ToString();
                                lblArea.Text = reader["Area"].ToString();
                                lblPrice.Text = reader["Price"].ToString();
                            }
                            else
                            {
                                lblError.Text = "Parking details not found!";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnConfirmBooking_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserID"] == null || Session["ParkingID"] == null || Session["SlotID"] == null)
                {
                    lblMessage.Text = "Error: Missing required booking details.";
                    return;
                }

                string userId = Session["UserID"].ToString();
                string parkingId = Session["ParkingID"].ToString();
                string slotId = Session["SlotID"].ToString();
                string vehicleNumber = txtVehicleNumber.Text.Trim();

                if (string.IsNullOrEmpty(vehicleNumber))
                {
                    lblMessage.Text = "Please enter your vehicle number.";
                    return;
                }

                // Store the amount in session properly
                Session["Price"] = lblPrice.Text;

                DateTime bookingTime = DateTime.Now;
                DateTime expiryTime = bookingTime.AddHours(24);

                // Generate QR Code
                string qrCodeData = $"{vehicleNumber}|{bookingTime}";
                string qrCodePath = GenerateQRCode(qrCodeData);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Booking (UserID, ParkingID, SlotID, VehicleNumber, BookingTime, ExpiryTime, QRCode, PaymentStatus) 
                                     VALUES (@UserID, @ParkingID, @SlotID, @VehicleNumber, @BookingTime, @ExpiryTime, @QRCode, @PaymentStatus)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@ParkingID", parkingId);
                        cmd.Parameters.AddWithValue("@SlotID", slotId);
                        cmd.Parameters.AddWithValue("@VehicleNumber", vehicleNumber);
                        cmd.Parameters.AddWithValue("@BookingTime", bookingTime);
                        cmd.Parameters.AddWithValue("@ExpiryTime", expiryTime);
                        cmd.Parameters.AddWithValue("@QRCode", qrCodePath);
                        cmd.Parameters.AddWithValue("@PaymentStatus", "Pending");

                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Booking confirmed! Redirecting to payment...";
                Response.Redirect("Payment.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private string GenerateQRCode(string qrData)
        {
            string folderPath = Server.MapPath("~/QRStorage/");

            // Ensure the folder exists
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // Generate QR Code filename
            string fileName = $"QRCode_{Guid.NewGuid()}.png";
            string filePath = Path.Combine(folderPath, fileName);

            // Create QR Code
            BarcodeWriter barcodeWriter = new BarcodeWriter
            {
                Format = BarcodeFormat.QR_CODE,
                Options = new ZXing.Common.EncodingOptions
                {
                    Height = 250,
                    Width = 250
                }
            };

            using (Bitmap bitmap = barcodeWriter.Write(qrData))
            {
                bitmap.Save(filePath, ImageFormat.Png);
            }

            return fileName; // Return filename to store in DB
        }
    }
}
