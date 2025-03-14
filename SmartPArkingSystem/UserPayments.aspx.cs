using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartPArkingSystem
{
    public partial class UserPayments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx"); 
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            LoadUserPayments(userId);
        }
        private void LoadUserPayments(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SmartPakingDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT PaymentID, Amount, PaymentMethod, TransactionID, PaymentDate, Status FROM Payments WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                GridViewPayments.DataSource = reader;
                GridViewPayments.DataBind();
            }
        }
    }
}