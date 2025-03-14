using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace SmartPArkingSystem.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Total Users
                    string userQuery = "SELECT COUNT(*) FROM Users";
                    using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                    {
                        lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Total Bookings
                    string bookingQuery = "SELECT COUNT(*) FROM Booking";
                    using (SqlCommand cmd = new SqlCommand(bookingQuery, conn))
                    {
                        lblTotalBookings.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Occupied and Available Parking Slots
                    string slotsQuery = @"
                        SELECT 
                            SUM(CASE WHEN IsAvailable = 0 THEN 1 ELSE 0 END) AS OccupiedSlots,
                            SUM(CASE WHEN IsAvailable = 1 THEN 1 ELSE 0 END) AS AvailableSlots
                        FROM ParkingSlots";
                    using (SqlCommand cmd = new SqlCommand(slotsQuery, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int occupiedSlots = Convert.ToInt32(reader["OccupiedSlots"]);
                                int availableSlots = Convert.ToInt32(reader["AvailableSlots"]);
                                lblTotalSlots.Text = $"{occupiedSlots} / {availableSlots + occupiedSlots}";
                            }
                        }
                    }

                    // Total Revenue
                    string revenueQuery = "SELECT SUM(Price) FROM Payment WHERE Status='Completed'";
                    using (SqlCommand cmd = new SqlCommand(revenueQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        lblTotalRevenue.Text = result != DBNull.Value ?
                            Convert.ToDecimal(result).ToString("N2") : "0.00";
                    }

                    // Recent Bookings
                    string recentBookingsQuery = @"
                        SELECT TOP 5 b.BookingID, b.VehicleNumber, b.BookingTime, 
                               u.Name AS UserName, p.SlotNumber
                        FROM Booking b
                        JOIN Users u ON b.UserID = u.UserID
                        JOIN ParkingSlots p ON b.SlotID = p.SlotID
                        ORDER BY b.BookingTime DESC";

                    using (SqlDataAdapter adapter = new SqlDataAdapter(recentBookingsQuery, conn))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        GridViewRecentBookings.DataSource = dt;
                        GridViewRecentBookings.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    // Log error or display a user-friendly message
                    lblErrorMessage.Text = "Error loading dashboard data: " + ex.Message;
                }
            }
        }
    }
}