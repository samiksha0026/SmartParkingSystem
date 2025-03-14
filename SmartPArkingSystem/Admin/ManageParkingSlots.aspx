<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageParkingSlots.aspx.cs" Inherits="SmartPArkingSystem.Admin.ManageParkingSlots" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Parking Slots</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #0a1036;
            --secondary-color: #1a237e;
            --bg-light: #f4f7fa;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: var(--bg-light);
            overflow-x: hidden;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: white;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-toggle {
            display: none;
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1100;
            background: var(--primary-color);
            color: white;
            padding: 10px;
            border-radius: 5px;
        }

        .dashboard-content {
            margin-left: 250px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .stat-icon {
            font-size: 3rem;
            opacity: 0.6;
        }

        .recent-bookings {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-on-load {
            animation: fadeIn 0.8s ease forwards;
            opacity: 0;
        }

        @media (max-width: 991px) {
            .sidebar {
                left: -250px;
            }

            .sidebar-toggle {
                display: block;
            }

            .dashboard-content {
                margin-left: 0;
            }

            .sidebar.active {
                left: 0;
            }
        }

        /* Custom styles for ManageParkingSlots */
        .manage-parking-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }

        .table-section, .form-section {
            flex: 1;
            min-width: 320px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        }

        h2, h3 {
            color: #0a1036;
            text-align: center;
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            display: block;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-actions {
            display: flex;
            justify-content: center;
        }

        .add-btn {
            background: #27ae60;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            transition: 0.3s;
            font-size: 14px;
            width: 100%;
        }

        .add-btn:hover {
            opacity: 0.8;
        }

        .success-message {
            color: green;
            margin-top: 10px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar Toggle Button -->
        <button type="button" class="sidebar-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="p-4 text-center">
                <h2 class="mb-4">Admin Panel</h2>
                <img src="images/adminlogo.jpg" alt="Admin" class="rounded-circle mb-3" style="width: 100px; height: 100px;">
                <p class="text-white">Welcome, Admin</p>
            </div>
            <nav>
                <a href="AdminDashboard.aspx" class="nav-link p-3"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                <a href="ManageUsers.aspx" class="nav-link p-3"><i class="fas fa-users me-2"></i>Manage Users</a>
                <a href="ManageParkingSlots.aspx" class="nav-link p-3"><i class="fas fa-parking me-2"></i>Manage Parking Slots</a>
                <a href="ViewBookings.aspx" class="nav-link p-3"><i class="fas fa-book me-2"></i>View Bookings</a>
                <a href="ReportsAnalytics.aspx" class="nav-link p-3"><i class="fas fa-chart-line me-2"></i>View Reports</a>
                <a href="Logout.aspx" class="nav-link p-3 text-danger"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </nav>
        </div>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <div class="container">
                 <div class="row">
                    <div class="col-12">
                        <h1 class="mb-4 animate-on-load">Manage Parking Slots</h1>
                    </div>
                </div>
                <div class="row">
                     <div class="col-md-12">
                        <asp:Label ID="lblMessage" runat="server" CssClass="success-message" Visible="false"></asp:Label>
                    </div>
                </div>
                <div class = "row">
                     <div class="col-md-8">
                          <div class="table-section">
                            <h2>Parking Slots</h2>
                             <asp:GridView ID="gvParkingSlots" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" DataKeyNames="SlotID" OnRowCommand="gvParkingSlots_RowCommand" OnRowEditing="gvParkingSlots_RowEditing" OnRowCancelingEdit="gvParkingSlots_RowCancelingEdit" OnRowUpdating="gvParkingSlots_RowUpdating">
                                <Columns>
                                    <asp:BoundField DataField="SlotID" HeaderText="Slot ID" ReadOnly="true" />
                                    <asp:BoundField DataField="SlotNumber" HeaderText="Slot Number" />
                                     <asp:TemplateField HeaderText="Parking Spot">
                                        <ItemTemplate>
                                            <%# Eval("ParkingName") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle Type">
                                        <ItemTemplate>
                                            <%# Eval("VehicleType") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlEditVehicleType" runat="server" SelectedValue='<%# Bind("VehicleType") %>'>
                                                <asp:ListItem Text="2-Wheeler" Value="2-Wheeler"></asp:ListItem>
                                                <asp:ListItem Text="3-Wheeler" Value="3-Wheeler"></asp:ListItem>
                                                <asp:ListItem Text="4-Wheeler" Value="4-Wheeler"></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Availability">
                                        <ItemTemplate>
                                            <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Available" : "Not Available" %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="chkEditAvailable" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAvailable")) %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary btn-sm" CommandName="Edit" Text="Edit" />
                                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" CommandName="DeleteSlot" CommandArgument='<%# Eval("SlotID") %>' Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this slot?');" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm" CommandName="Update" Text="Update" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-sm" CommandName="Cancel" Text="Cancel" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                     <div class="col-md-4">
                         <div class="form-section">
                            <h3>Add New Parking Slot</h3>
                            <div class="form-group">
                                <label>Parking Spot:</label>
                                 <asp:DropDownList ID="ddlParkingSpot" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label>Slot Number:</label>
                                <asp:TextBox ID="txtSlotNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Vehicle Type:</label>
                                <asp:DropDownList ID="ddlVehicleType" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="2-Wheeler" Value="2-Wheeler"></asp:ListItem>
                                    <asp:ListItem Text="3-Wheeler" Value="3-Wheeler"></asp:ListItem>
                                    <asp:ListItem Text="4-Wheeler" Value="4-Wheeler"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label>Availability:</label>
                                <asp:CheckBox ID="chkAvailable" runat="server" Checked="true" />
                            </div>
                            <div class="form-actions">
                                <asp:Button ID="btnAddSlot" runat="server" Text="Add Slot" CssClass="btn add-btn" OnClick="btnAddSlot_Click" />
                            </div>
                        </div>
                     </div>
                </div>
            </div>
        </div>
    </form>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }
    </script>
</body>
</html>
