<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="SmartPArkingSystem.Admin.ViewBookings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>

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

        /* Custom styles for ViewBookings */
        .view-bookings-container {
            padding: 20px;
        }

        .search-box {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        input[type="text"] {
            padding: 10px;
            width: 100%;
            max-width: 400px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #0a1036;
            color: white;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
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
            <div class="container animate-on-load">
                <div class="row">
                    <div class="col-12">
                        <h1 class="mb-4">View Bookings</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="search-box">
                            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by Name or Vehicle No"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-container">
                            <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" BorderWidth="1" CellPadding="5" GridLines="Both">
                                <Columns>
                                    <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                    <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle Number" />
                                    <asp:BoundField DataField="SlotID" HeaderText="Slot ID" />
                                    <asp:BoundField DataField="BookingTime" HeaderText="Booking Time" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                                    <asp:BoundField DataField="ExpiryTime" HeaderText="Expiry Time" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                                    <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                                    <%-- Add more columns as needed --%>
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
