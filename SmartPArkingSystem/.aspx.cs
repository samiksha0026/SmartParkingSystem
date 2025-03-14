using System;
using System.Collections.Generic;

namespace SmartParkRide
{
    public partial class ParkingSlots : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mock data for demonstration
                var parkingSlots = new List<dynamic>
                {
                    new { Address = "123 Main St", Price = 10, IsAvailable = true },
                    new { Address = "456 Elm St", Price = 15, IsAvailable = false },
                    new { Address = "789 Oak St", Price = 12, IsAvailable = true }
                };

                ParkingSlotsRepeater.DataSource = parkingSlots;
                ParkingSlotsRepeater.DataBind();
            }
        }
    }
}
