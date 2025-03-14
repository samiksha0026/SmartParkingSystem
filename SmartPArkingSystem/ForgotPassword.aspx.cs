using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace SmartPArkingSystem
{
    public partial class ForgotPassword : Page
    {
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            // Generate a temporary password
            string newPassword = GenerateRandomPassword();
            string hashedPassword = HashPassword(newPassword);

            string connectionString = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Users SET Password = @Password WHERE Email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@Email", email);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Password reset successfully! New password sent to your email.";
                        SendPasswordEmail(email, newPassword); // Send email with new password
                    }
                    else
                    {
                        lblMessage.Text = "Email not found!";
                    }
                }
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2")); // Convert to hex string
                }
                return builder.ToString();
            }
        }

        private string GenerateRandomPassword()
        {
            return Guid.NewGuid().ToString().Substring(0, 8); // Generate a random 8-character password
        }

        private void SendPasswordEmail(string email, string newPassword)
        {
            // TODO: Implement email sending logic
        }
    }
}
