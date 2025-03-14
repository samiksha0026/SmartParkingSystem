using System;
using System.Data.SqlClient;
using System.Configuration;
namespace SmartPArkingSystem.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT * FROM Admins WHERE Email = @Email AND Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        Session["Admin"] = dr["AdminID"].ToString();
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}