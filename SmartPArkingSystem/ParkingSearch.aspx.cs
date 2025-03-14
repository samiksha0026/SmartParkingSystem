using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace SmartPArkingSystem
{
    public partial class ParkingSearch : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    LoadCities();
                }
            }
        }

        private void LoadCities()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT DISTINCT City FROM ParkingSpots ORDER BY City";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ddlCity.Items.Add(new ListItem(reader["City"].ToString(), reader["City"].ToString()));
                }

                reader.Close();
            }
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Clear previous areas and message
            ddlArea.Items.Clear();
            ddlArea.Items.Add(new ListItem("-- Select Area --", ""));
            lblMessage.Text = "";

            // Clear previous search results
            gvParkingSpots.DataSource = null;
            gvParkingSpots.DataBind();
            gvSlots.Visible = false;

            if (!string.IsNullOrEmpty(ddlCity.SelectedValue))
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT DISTINCT Area FROM ParkingSpots WHERE City = @City ORDER BY Area";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@City", ddlCity.SelectedValue);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        ddlArea.Items.Add(new ListItem(reader["Area"].ToString(), reader["Area"].ToString()));
                    }

                    reader.Close();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            gvSlots.Visible = false;

            if (string.IsNullOrEmpty(ddlCity.SelectedValue))
            {
                lblMessage.Text = "Please select a city";
                return;
            }

            string query = "SELECT p.ParkingID, p.Name, p.City, p.Area, p.Price, " +
                          "COUNT(CASE WHEN s.IsAvailable = 1 THEN 1 ELSE NULL END) AS AvailableSlots " +
                          "FROM ParkingSpots p " +
                          "LEFT JOIN ParkingSlots s ON p.ParkingID = s.ParkingID " +
                          "WHERE p.City = @City";

            if (!string.IsNullOrEmpty(ddlArea.SelectedValue))
            {
                query += " AND p.Area = @Area";
            }

            query += " GROUP BY p.ParkingID, p.Name, p.City, p.Area, p.Price";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@City", ddlCity.SelectedValue);

                if (!string.IsNullOrEmpty(ddlArea.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@Area", ddlArea.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvParkingSpots.DataSource = dt;
                    gvParkingSpots.DataBind();

                    // Also load slots for the first parking location
                    int firstParkingId = Convert.ToInt32(dt.Rows[0]["ParkingID"]);
                    LoadSlots(firstParkingId);
                }
                else
                {
                    gvParkingSpots.DataSource = null;
                    gvParkingSpots.DataBind();
                    lblMessage.Text = "No parking spots found for the selected criteria";
                }
            }
        }

        private void LoadSlots(int parkingID)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT SlotID, SlotNumber, VehicleType, IsAvailable " +
                              "FROM ParkingSlots WHERE ParkingID = @ParkingID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ParkingID", parkingID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvSlots.DataSource = dt;
                    gvSlots.DataBind();
                    gvSlots.Visible = true;
                }
                else
                {
                    gvSlots.DataSource = null;
                    gvSlots.DataBind();
                    gvSlots.Visible = false;
                }
            }
        }

        protected void gvParkingSpots_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Book")
            {
                int parkingID = Convert.ToInt32(e.CommandArgument);

                // First, show the slots for this parking
                LoadSlots(parkingID);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string slotQuery = "SELECT TOP 1 SlotID FROM ParkingSlots WHERE ParkingID = @ParkingID AND IsAvailable = 1";
                    SqlCommand cmd = new SqlCommand(slotQuery, conn);
                    cmd.Parameters.AddWithValue("@ParkingID", parkingID);

                    object slotResult = cmd.ExecuteScalar();
                    if (slotResult != null)
                    {
                        int slotID = Convert.ToInt32(slotResult);

                        // Retrieve selected parking details
                        foreach (GridViewRow row in gvParkingSpots.Rows)
                        {
                            HiddenField hfParkingID = row.FindControl("hfParkingID") as HiddenField;
                            if (hfParkingID != null && hfParkingID.Value == parkingID.ToString())
                            {
                                string name = row.Cells[1].Text;
                                string city = row.Cells[2].Text;
                                string area = row.Cells[3].Text;
                                string price = row.Cells[4].Text;

                                // Store in session
                                if (decimal.TryParse(price, out decimal validPrice))
                                {
                                    Session["ParkingID"] = parkingID;
                                    Session["SlotID"] = slotID;
                                    Session["ParkingName"] = name;
                                    Session["ParkingCity"] = city;
                                    Session["ParkingArea"] = area;
                                    Session["ParkingPrice"] = validPrice.ToString("F2");

                                    Response.Redirect("BookParking.aspx");
                                }
                                else
                                {
                                    lblMessage.Text = "Error: Invalid parking price. Please try again.";
                                }
                                break;
                            }
                        }
                    }
                    else
                    {
                        lblMessage.Text = "No available slots for this parking.";
                    }
                }
            }
        }
    }
}