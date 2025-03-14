<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="SmartPArkingSystem.Admin.AdminDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Parking Admin Dashboard</title>
    
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
            <div class="row">
                <div class="col-12">
                    <h1 class="mb-4 animate-on-load">Dashboard Overview</h1>
                    
                    <!-- Error Message -->
                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="alert alert-danger" Visible='<%# !string.IsNullOrEmpty(lblErrorMessage.Text) %>'></asp:Label>
                    
                    <!-- Stats Grid -->
                    <div class="stats-grid animate-on-load">
                        <div class="stat-card">
                            <div>
                                <h5>Total Users</h5>
                                <asp:Label ID="lblTotalUsers" runat="server" CssClass="h3"></asp:Label>
                            </div>
                            <i class="fas fa-users stat-icon text-primary"></i>
                        </div>

                        <div class="stat-card">
                            <div>
                                <h5>Total Bookings</h5>
                                <asp:Label ID="lblTotalBookings" runat="server" CssClass="h3"></asp:Label>
                            </div>
                            <i class="fas fa-book stat-icon text-success"></i>
                        </div>

                        <div class="stat-card">
                            <div>
                                <h5>Parking Slots</h5>
                                <asp:Label ID="lblTotalSlots" runat="server" CssClass="h3"></asp:Label>
                            </div>
                            <i class="fas fa-parking stat-icon text-warning"></i>
                        </div>

                        <div class="stat-card">
                            <div>
                                <h5>Total Revenue</h5>
                                <asp:Label ID="lblTotalRevenue" runat="server" CssClass="h3"></asp:Label>
                            </div>
                            <i class="fas fa-rupee-sign stat-icon text-info"></i>
                        </div>
                    </div>

                    <!-- Recent Bookings -->
                    <div class="recent-bookings animate-on-load mt-5">
                        <h3 class="mb-4">Recent Bookings</h3>
                        <asp:GridView ID="GridViewRecentBookings" runat="server" 
                            CssClass="table table-striped table-hover" 
                            AutoGenerateColumns="false"
                            EmptyDataText="No recent bookings">
                            <Columns>
                                <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                                <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle Number" />
                                <asp:BoundField DataField="UserName" HeaderText="User" />
                                <asp:BoundField DataField="SlotNumber" HeaderText="Slot" />
                                <asp:BoundField DataField="BookingTime" HeaderText="Booking Time" DataFormatString="{0:g}" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }

        // Animate elements on load
        document.addEventListener('DOMContentLoaded', function () {
            const animateElements = document.querySelectorAll('.animate-on-load');
            animateElements.forEach((el, index) => {
                el.style.animationDelay = `${index * 0.2}s`;
            });
        });
    </script>
</body>
</html>