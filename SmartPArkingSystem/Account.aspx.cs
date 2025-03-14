using System;
using System.Data;
using System.Data.SqlClient;

namespace SmartPArkingSystem
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure user is logged in
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                // Load account details
                LoadPersonalDetails();
                LoadBookedParking();
                LoadParkingHistory();
            }
        }

        private void LoadPersonalDetails()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = "SELECT Name, Email, Phone FROM Users WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection("YourConnectionString"))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                       lblName.Text= reader["Name"].ToString();
                        lblEmail.Text = reader["Email"].ToString();
                        lblPhone.Text = reader["Phone"].ToString();
                    }
                    conn.Close();
                }
            }
        }

        private void LoadBookedParking()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"
                SELECT VehicleType, ParkingLocation, SlotNumber, BookingTime 
                FROM BookedParking 
                WHERE UserId = @UserId AND IsActive = 1";

            using (SqlConnection conn = new SqlConnection("YourConnectionString"))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    conn.Close();

                    gvBookedParking.DataSource = dataTable;
                    gvBookedParking.DataBind();
                }
            }
        }

        private void LoadParkingHistory()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"
                SELECT VehicleType, ParkingLocation, SlotNumber, CheckIn, CheckOut 
                FROM ParkingHistory 
                WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection("YourConnectionString"))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    conn.Close();

                    gvParkingHistory.DataSource = dataTable;
                    gvParkingHistory.DataBind();
                }
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login page
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

    }
}