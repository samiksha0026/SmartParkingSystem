using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;

namespace SmartPArkingSystem  
{
    public partial class Signup : Page
    {
        private string connectionString = "Server=LAPTOP-9QL2JU6H\\SQLEXPRESS;Database=SmartParkingDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            string name = NameTextBox.Text.Trim();
            string email = EmailTextBox.Text.Trim();
            string phone = PhoneTextBox.Text.Trim();
            string password =PasswordTextBox.Text.Trim(); 

            if (RegisterUser(name, email, phone, password))
            {
                Response.Write("<script>alert('Registration successful! Please log in.');</script>");
                Response.Redirect("Login.aspx", false); 
            }
            else
            {
                Response.Write("<script>alert('Email already exists. Please use a different email.');</script>");
            }
        }

        private bool RegisterUser(string name, string email, string phone, string password)
        {
            bool isRegistered = false;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string checkUserQuery = "SELECT COUNT(1) FROM Users WHERE Email = @Email";
                string insertQuery = "INSERT INTO Users (Name, Email, Phone, Password) VALUES (@Name, @Email, @Phone, @Password)";

                using (SqlCommand checkCmd = new SqlCommand(checkUserQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (count == 0) 
                    {
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@Name", name);
                            insertCmd.Parameters.AddWithValue("@Email", email);
                            insertCmd.Parameters.AddWithValue("@Phone", phone);
                            insertCmd.Parameters.AddWithValue("@Password", password); 
                            insertCmd.ExecuteNonQuery();
                            isRegistered = true;
                        }
                    }
                }
            }

            return isRegistered;
        }

       
    }
}
