using System;
using System.Data.SqlClient;
using System.Configuration;
using QRCoder;
using System.Drawing;
using System.IO;

namespace SmartPArkingSystem
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Price"] != null)
                {
                    txtAmount.Text = Session["Price"].ToString();
                }
                else
                {
                    txtAmount.Text = "0"; // Default value
                }

                pnlTransactionID.Visible = ddlPaymentMethod.SelectedValue == "UPI";
            }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlTransactionID.Visible = (ddlPaymentMethod.SelectedValue == "UPI");
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] != null && Session["Price"] != null)
            {
                int userID = Convert.ToInt32(Session["UserID"]);
                decimal amount = Convert.ToDecimal(Session["Price"]);
                string paymentMethod = ddlPaymentMethod.SelectedValue;
                string transactionID = txtTransactionID.Text.Trim();
                string status = "Success";

                string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Insert payment into database
                    string query = "INSERT INTO Payment (UserID, Price, PaymentMethod, TransactionID, Status) OUTPUT INSERTED.PaymentID VALUES (@UserID, @Price, @PaymentMethod, @TransactionID, @Status)";

                    int paymentID;
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.Parameters.AddWithValue("@Price", amount);
                        cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                        cmd.Parameters.AddWithValue("@TransactionID", string.IsNullOrEmpty(transactionID) ? (object)DBNull.Value : transactionID);
                        cmd.Parameters.AddWithValue("@Status", status);

                        conn.Open();
                        paymentID = (int)cmd.ExecuteScalar(); // Get inserted PaymentID
                        conn.Close();
                    }

                    // Generate QR Code
                    string qrCodeImagePath = GenerateQRCode(paymentID);

                    // Update the Payment record with QRCode
                    query = "UPDATE Payment SET QRCode = @QRCode WHERE PaymentID = @PaymentID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@QRCode", qrCodeImagePath);
                        cmd.Parameters.AddWithValue("@PaymentID", paymentID);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }

                    // Redirect to Ticket page with PaymentID
                    Response.Redirect("Ticket.aspx?paymentID=" + paymentID);
                }
            }
            else
            {
                lblMessage.Text = "Error: User not logged in or amount missing!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private string GenerateQRCode(int paymentID)
        {
            try
            {
                string qrText = "PaymentID: " + paymentID;

                using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
                using (QRCodeData qrCodeData = qrGenerator.CreateQrCode(qrText, QRCodeGenerator.ECCLevel.Q))
                using (QRCode qrCode = new QRCode(qrCodeData))
                using (Bitmap qrBitmap = qrCode.GetGraphic(20))
                {
                    string qrFolderPath = Server.MapPath("~/QR_Codes/");
                    if (!Directory.Exists(qrFolderPath))
                    {
                        Directory.CreateDirectory(qrFolderPath);
                    }

                    string qrImagePath = Path.Combine(qrFolderPath, paymentID + ".png");
                    qrBitmap.Save(qrImagePath, System.Drawing.Imaging.ImageFormat.Png);

                    return "~/QR_Codes/" + paymentID + ".png"; // ✅ Return valid image path
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message; // ✅ Ensure a string is always returned
            }
        }
    }
}
