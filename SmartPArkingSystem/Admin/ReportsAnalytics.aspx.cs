using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartPArkingSystem.Admin
{
    public partial class ReportsAnalytics : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set default date range
                DateTime endDate = DateTime.Now;
                DateTime startDate = endDate.AddDays(-30); // Last 30 days

                hdnStartDate.Value = startDate.ToString("yyyy-MM-dd");
                hdnEndDate.Value = endDate.ToString("yyyy-MM-dd");
                // Load initial data
                LoadAdditionalData(); // Load additional data when the page first loads
            }
        }

        private void LoadAdditionalData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Get total number of users
                    SqlCommand cmdTotalUsers = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
                    lblTotalUsers.Text = cmdTotalUsers.ExecuteScalar().ToString();

                    // Get average booking duration
                    SqlCommand cmdAvgBookingDuration = new SqlCommand(@"
                        SELECT AVG(DATEDIFF(minute, BookingTime, ExpiryTime))
                        FROM Booking
                        WHERE BookingTime IS NOT NULL AND ExpiryTime IS NOT NULL", conn);
                    object avgDuration = cmdAvgBookingDuration.ExecuteScalar();
                    lblAvgBookingDuration.Text = (avgDuration != DBNull.Value) ? Math.Round(Convert.ToDouble(avgDuration)).ToString() : "0";

                    // Get Top 5 Most Active Users
                    SqlCommand cmdTopUsers = new SqlCommand(@"
                        SELECT TOP 5 U.Name AS UserName, COUNT(B.BookingID) AS BookingCount
                        FROM Users U
                        INNER JOIN Booking B ON U.UserID = B.UserID
                        GROUP BY U.Name
                        ORDER BY BookingCount DESC", conn);
                    SqlDataAdapter daTopUsers = new SqlDataAdapter(cmdTopUsers);
                    DataTable dtTopUsers = new DataTable();
                    daTopUsers.Fill(dtTopUsers);
                    gvTopUsers.DataSource = dtTopUsers;
                    gvTopUsers.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle the error
                Response.Write("Error: " + ex.Message);
            }
        }


        [WebMethod]
        public static string GetChartData(string startDate, string endDate)
        {
            DateTime start = DateTime.Parse(startDate);
            DateTime end = DateTime.Parse(endDate);

            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            Dictionary<string, object> chartData = new Dictionary<string, object>();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                // Slot Utilization Data
                SqlCommand cmd1 = new SqlCommand(@"
                SELECT 
                    COUNT(*) AS TotalSlots,
                    SUM(CASE WHEN ps.IsAvailable = 1 THEN 1 ELSE 0 END) AS AvailableSlots
                FROM ParkingSlots ps", conn);
                SqlDataReader reader1 = cmd1.ExecuteReader();
                if (reader1.Read())
                {
                    int totalSlots = Convert.ToInt32(reader1["TotalSlots"]);
                    int availableSlots = Convert.ToInt32(reader1["AvailableSlots"]);
                    int bookedSlots = totalSlots - availableSlots;
                    chartData["SlotUtilizationData"] = new int[] { availableSlots, bookedSlots };
                }
                reader1.Close();
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(chartData);
        }


        [WebMethod]
        public static string GetAdditionalData(string startDate, string endDate)
        {
            DateTime start = DateTime.Parse(startDate);
            DateTime end = DateTime.Parse(endDate);

            string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;
            Dictionary<string, object> additionalData = new Dictionary<string, object>();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Get total number of users
                SqlCommand cmdTotalUsers = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
                additionalData["TotalUsers"] = cmdTotalUsers.ExecuteScalar();

                // Get average booking duration
                SqlCommand cmdAvgBookingDuration = new SqlCommand(@"
                    SELECT AVG(DATEDIFF(minute, BookingTime, ExpiryTime))
                    FROM Booking
                    WHERE BookingTime IS NOT NULL AND ExpiryTime IS NOT NULL", conn);
                object avgDuration = cmdAvgBookingDuration.ExecuteScalar();
                additionalData["AvgBookingDuration"] = (avgDuration != DBNull.Value) ? Math.Round(Convert.ToDouble(avgDuration)).ToString() : "0";

                // Get Top 5 Most Active Users
                SqlCommand cmdTopUsers = new SqlCommand(@"
                    SELECT TOP 5 U.Name AS UserName, COUNT(B.BookingID) AS BookingCount
                    FROM Users U
                    INNER JOIN Booking B ON U.UserID = B.UserID
                    GROUP BY U.Name
                    ORDER BY BookingCount DESC", conn);
                SqlDataAdapter daTopUsers = new SqlDataAdapter(cmdTopUsers);
                DataTable dtTopUsers = new DataTable();
                daTopUsers.Fill(dtTopUsers);

                // Convert DataTable to List<Dictionary<string, object>> for JSON serialization
                List<Dictionary<string, object>> topUsersList = new List<Dictionary<string, object>>();
                foreach (DataRow row in dtTopUsers.Rows)
                {
                    Dictionary<string, object> user = new Dictionary<string, object>();
                    user["UserName"] = row["UserName"].ToString();
                    user["BookingCount"] = Convert.ToInt32(row["BookingCount"]);
                    topUsersList.Add(user);
                }

                additionalData["TopUsers"] = topUsersList;
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(additionalData);
        }
    }
}
