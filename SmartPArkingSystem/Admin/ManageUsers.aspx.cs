using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartPArkingSystem.Admin
{
    public partial class ManageUsers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated/authorized (add your authentication logic)
            if (!IsPostBack)
            {
                try
                {
                    LoadUsers();
                }
                catch (Exception ex)
                {
                    // Log the error or display a user-friendly message
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        private void LoadUsers()
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = @"
                    SELECT 
                        UserID, 
                        Name, 
                        Email, 
                        Phone, 
                        CASE WHEN IsBlocked = 1 THEN 'Blocked' ELSE 'Active' END AS Status,
                        IsBlocked 
                    FROM Users";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind data to GridView
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Block" || e.CommandName == "Unblock")
            {
                try
                {
                    int userId = Convert.ToInt32(e.CommandArgument);
                    bool isBlocked = e.CommandName == "Block";

                    string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string query = "UPDATE Users SET IsBlocked = @IsBlocked WHERE UserID = @UserID";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@IsBlocked", isBlocked);
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Reload the users after blocking/unblocking
                    LoadUsers();
                }
                catch (Exception ex)
                {
                    // Log the error or display a user-friendly message
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                string status = rowView["Status"].ToString();

                if (status == "Active")
                {
                    e.Row.Cells[4].CssClass = "status-active";
                }
                else if (status == "Blocked")
                {
                    e.Row.Cells[4].CssClass = "status-blocked";
                }
            }
        }
    }
}
