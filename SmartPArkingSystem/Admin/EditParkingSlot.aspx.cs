using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SmartPArkingSystem.Admin
{
    public partial class EditParkingSlot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int slotId;
                if (int.TryParse(Request.QueryString["SlotID"], out slotId))
                {
                    LoadParkingSlot(slotId);
                }
            }
        }

        private void LoadParkingSlot(int slotId)
        {
            // Sample Data Load (Replace with DB Call)
            hfSlotID.Value = slotId.ToString();
            txtLocation.Text = "A1";
            ddlVehicleType.SelectedValue = "4-Wheeler";
            chkAvailable.Checked = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int slotId = Convert.ToInt32(hfSlotID.Value);
            string location = txtLocation.Text;
            string vehicleType = ddlVehicleType.SelectedValue;
            bool isAvailable = chkAvailable.Checked;

            // Database update logic here
            Response.Redirect("ManageParkingSlots.aspx");
        }
    }
}