<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="SmartPArkingSystem.Admin.ManageUsers" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>

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

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-on-load {
            animation: fadeIn 0.8s ease forwards;
            opacity: 0;
        }

        /* Table Styles */
        .table-container {
            margin-top: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #f0f0f0;
            transition: background-color 0.3s ease;
        }

        .table .status-active {
            color: #28a745;
            font-weight: bold;
        }

        .table .status-blocked {
            color: #dc3545;
            font-weight: bold;
        }

        /* Responsive Design */
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
                        <h1 class="mb-4 animate-on-load">Manage Users</h1>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-container animate-on-load">
                            <asp:GridView ID="gvUsers" runat="server" CssClass="table" AutoGenerateColumns="False" OnRowCommand="gvUsers_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="UserID" HeaderText="User ID" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" />
                                    <asp:BoundField DataField="Phone" HeaderText="Phone" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:Button ID="btnBlock" runat="server" Text="Block" CssClass="btn btn-danger btn-sm"
                                                CommandName="Block" CommandArgument='<%# Eval("UserID") %>'
                                                Visible='<%# Eval("IsBlocked").ToString() == "False" %>' />

                                            <asp:Button ID="btnUnblock" runat="server" Text="Unblock" CssClass="btn btn-success btn-sm"
                                                CommandName="Unblock" CommandArgument='<%# Eval("UserID") %>'
                                                Visible='<%# Eval("IsBlocked").ToString() == "True" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
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
