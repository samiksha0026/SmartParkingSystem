using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Web.UI;
using ZXing; // For QR Code Generation
using System.IO;

namespace SmartPArkingSystem
{
    public partial class Ticket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["paymentID"] != null)
                {
                    int paymentID;
                    if (int.TryParse(Request.QueryString["paymentID"], out paymentID))
                    {
                        string transactionID = Request.QueryString["transactionID"]; // Get Transaction ID

                        if (!string.IsNullOrEmpty(transactionID))
                        {
                            // If transaction ID is provided, verify it (UPI case)
                            LoadTicketDetails(paymentID, transactionID);
                        }
                        else
                        {
                            // If transaction ID is missing, check payment method
                            LoadTicketDetails(paymentID, null);
                        }
                    }
                    else
                    {
                        lblError.Text = "Invalid Payment ID.";
                    }
                }
                else
                {
                    lblError.Text = "No Payment ID provided.";
                }
            }
        }


        private void LoadTicketDetails(int paymentID, string transactionID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query;

                if (!string.IsNullOrEmpty(transactionID))
                {
                    // If UPI is selected, verify Transaction ID
                    query = @"SELECT b.BookingID, b.VehicleNumber, b.SlotID, 
                             b.QRCode, p.Price 
                      FROM dbo.Booking b 
                      INNER JOIN dbo.Payment p ON b.BookingID = p.PaymentID 
                      WHERE p.PaymentID = @PaymentID AND p.TransactionID = @TransactionID";
                }
                else
                {
                    // If Cash is selected, no Transaction ID check
                    query = @"SELECT b.BookingID, b.VehicleNumber, b.SlotID, 
                             b.QRCode, p.Price 
                      FROM dbo.Booking b 
                      INNER JOIN dbo.Payment p ON b.BookingID = p.PaymentID 
                      WHERE p.PaymentID = @PaymentID";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PaymentID", paymentID);

                    if (!string.IsNullOrEmpty(transactionID))
                    {
                        cmd.Parameters.AddWithValue("@TransactionID", transactionID);
                    }

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblBookingID.Text = reader["BookingID"].ToString();
                        lblVehicleNumber.Text = reader["VehicleNumber"].ToString();
                        lblSlot.Text = reader["SlotID"].ToString();
                        lblAmount.Text = reader["Price"].ToString();
                        imgQRCode.ImageUrl = reader["QRCode"].ToString();
                    }
                    else
                    {
                        lblError.Text = "Invalid Payment or Transaction ID.";
                    }

                    conn.Close();
                }
            }
        }

        private void GenerateQRCode(string vehicleNumber)
        {
            try
            {
                var qrWriter = new BarcodeWriter
                {
                    Format = BarcodeFormat.QR_CODE
                };
                var qrBitmap = qrWriter.Write(vehicleNumber);

                string qrFolderPath = Server.MapPath("~/QR_Codes/");
                if (!Directory.Exists(qrFolderPath))
                {
                    Directory.CreateDirectory(qrFolderPath);
                }

                string qrImagePath = Path.Combine(qrFolderPath, vehicleNumber + ".png");

                // Ensure the file is properly saved and released
                using (MemoryStream ms = new MemoryStream())
                {
                    qrBitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    File.WriteAllBytes(qrImagePath, ms.ToArray());
                }

                // Corrected Image Path for Display
                imgQRCode.ImageUrl = "QR_Codes/" + vehicleNumber + ".png";  // Remove "~/"
            }
            catch (Exception ex)
            {
                lblError.Text = "QR Code generation failed: " + ex.Message;
            }
        }

    }
}
