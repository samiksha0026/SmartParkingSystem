using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SmartPArkingSystem.Admin
{
    public partial class ViewBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings(string search = "")
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"SELECT B.BookingID, U.Name AS UserName, B.VehicleNumber, B.SlotID, B.BookingTime, B.ExpiryTime, B.PaymentStatus
                                FROM Booking B
                                INNER JOIN Users U ON B.UserID = U.UserID";

                    if (!string.IsNullOrEmpty(search))
                    {
                        query += " WHERE U.Name LIKE @Search OR B.VehicleNumber LIKE @Search";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (!string.IsNullOrEmpty(search))
                        {
                            cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvBookings.DataSource = dt;
                        gvBookings.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the error (e.g., display an error message)
                Response.Write("Error: " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadBookings(txtSearch.Text.Trim());
            txtSearch.Text = string.Empty;
        }
    }
}
