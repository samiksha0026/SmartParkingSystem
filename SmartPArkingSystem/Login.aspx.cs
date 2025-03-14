using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace SmartPArkingSystem
{
    public partial class Login : Page
    {
        private string connectionString = "Server=LAPTOP-9QL2JU6H\\SQLEXPRESS;Database=SmartParkingDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }

        protected void SignIn_Click(object sender, EventArgs e)
        {
            string email = EmailTextBoxSignIn.Text.Trim();
            string password = PasswordTextBoxSignIn.Text.Trim();

            string userId = AuthenticateUser(email, password);

            if (!string.IsNullOrEmpty(userId))
            {
                // Store user ID in session
                Session["UserID"] = userId;

                // Redirect to dashboard
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                Response.Write("<script>alert('Invalid email or password.');</script>");
            }
        }

        private string AuthenticateUser(string email, string password)
        {
            string userId = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT UserID FROM Users WHERE Email = @Email AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        userId = result.ToString();
                    }
                }
            }

            return userId;
        }
    }
}
