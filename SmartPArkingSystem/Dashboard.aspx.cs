using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SmartPArkingSystem
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx"); // Redirect to login if session is empty
            }

            if (!IsPostBack)
            {
                LoadUserDetails();
                LoadActiveBooking();
                LoadRecentPayments();
            }
        }

        private void LoadUserDetails()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Name, Email FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblUserName.Text = reader["Name"].ToString();
                    lblUserEmail.Text = reader["Email"].ToString();
                }
                conn.Close();
            }
        }

        private void LoadActiveBooking()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT BookingID, ParkingID, VehicleNumber 
                                 FROM Booking
                                 WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblBookingID.Text = reader["BookingID"].ToString();
                    lblSlotID.Text = reader["ParkingID"].ToString();
                    lblVehicleNumber.Text = reader["VehicleNumber"].ToString();
                    activeBookingSection.Visible = true;
                }
                else
                {
                    activeBookingSection.Visible = false;
                }
                conn.Close();
            }
        }

        private void LoadRecentPayments()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT PaymentID, Price, PaymentMethod, PaymentDate 
                                 FROM Payment
                                 WHERE UserID = @UserID 
                                 ORDER BY PaymentDate DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRecentPayments.DataSource = dt;
                gvRecentPayments.DataBind();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}
