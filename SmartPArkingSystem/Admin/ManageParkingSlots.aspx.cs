using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace SmartPArkingSystem.Admin
{
    public partial class ManageParkingSlots : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["SmartParkingDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadParkingSlots();
                LoadParkingSpots();
            }
        }

        private void LoadParkingSlots()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"
                        SELECT 
                            ps.SlotID, 
                            ps.SlotNumber, 
                            ps.VehicleType, 
                            ps.IsAvailable,
                            sp.Name AS ParkingName
                        FROM ParkingSlots ps
                        INNER JOIN ParkingSpots sp ON ps.ParkingID = sp.ParkingID";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvParkingSlots.DataSource = dt;
                    gvParkingSlots.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading parking slots: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        private void LoadParkingSpots()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT ParkingID, Name FROM ParkingSpots";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlParkingSpot.DataSource = dt;
                    ddlParkingSpot.DataTextField = "Name";
                    ddlParkingSpot.DataValueField = "ParkingID";
                    ddlParkingSpot.DataBind();

                    ddlParkingSpot.Items.Insert(0, new ListItem("-- Select Parking Spot --", "")); // Optional: Add a default item
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading parking spots: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }


        protected void btnAddSlot_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "INSERT INTO ParkingSlots (ParkingID, SlotNumber, VehicleType, IsAvailable) VALUES (@ParkingID, @SlotNumber, @VehicleType, @IsAvailable)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ParkingID", ddlParkingSpot.SelectedValue);
                        cmd.Parameters.AddWithValue("@SlotNumber", txtSlotNumber.Text);
                        cmd.Parameters.AddWithValue("@VehicleType", ddlVehicleType.SelectedValue);
                        cmd.Parameters.AddWithValue("@IsAvailable", chkAvailable.Checked);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Parking slot added successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Visible = true;
                txtSlotNumber.Text = string.Empty;
                LoadParkingSlots();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error adding parking slot: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        protected void gvParkingSlots_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvParkingSlots.EditIndex = e.NewEditIndex;
            LoadParkingSlots();
        }

        protected void gvParkingSlots_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = gvParkingSlots.Rows[e.RowIndex];
                int slotID = Convert.ToInt32(gvParkingSlots.DataKeys[e.RowIndex].Values["SlotID"]); // Access SlotID from DataKeys

                // Retrieve values from the edit row
                string vehicleType = (row.FindControl("ddlEditVehicleType") as DropDownList).SelectedValue;
                bool isAvailable = (row.FindControl("chkEditAvailable") as CheckBox).Checked;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "UPDATE ParkingSlots SET VehicleType = @VehicleType, IsAvailable = @IsAvailable WHERE SlotID = @SlotID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@VehicleType", vehicleType);
                        cmd.Parameters.AddWithValue("@IsAvailable", isAvailable);
                        cmd.Parameters.AddWithValue("@SlotID", slotID);
                        cmd.ExecuteNonQuery();
                    }
                }

                gvParkingSlots.EditIndex = -1;
                LoadParkingSlots(); // Reload data to GridView
                lblMessage.Text = "Parking slot updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating parking slot: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }


        protected void gvParkingSlots_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvParkingSlots.EditIndex = -1;
            LoadParkingSlots();
        }

        protected void gvParkingSlots_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSlot")
            {
                try
                {
                    int slotID = Convert.ToInt32(e.CommandArgument);
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string query = "DELETE FROM ParkingSlots WHERE SlotID=@SlotID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@SlotID", slotID);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblMessage.Text = "Parking slot deleted successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;

                    LoadParkingSlots();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error deleting parking slot: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
            }
        }
    }
}
