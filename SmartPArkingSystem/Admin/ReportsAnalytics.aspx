<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportsAnalytics.aspx.cs" Inherits="SmartPArkingSystem.Admin.ReportsAnalytics" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

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

        /* Custom styles for Reports & Analytics */
        .reports-analytics-container {
            padding: 20px;
        }

        .chart-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
        }

        /* Date Range Picker Styles */
        .date-range-picker {
            margin-bottom: 20px;
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

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Moment.js -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

    <!-- Date Range Picker JS -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
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
                        <h1 class="mb-4">📊 Reports & Analytics</h1>
                    </div>
                </div>

                <!-- Date Range Picker -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="date-range-picker">
                            <label for="reportrange">Select Date Range:</label>
                            <div id="reportrange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
                                <i class="fa fa-calendar"></i>&nbsp;
                                <span></span> <i class="fa fa-caret-down"></i>
                            </div>
                            <asp:HiddenField ID="hdnStartDate" runat="server" />
                            <asp:HiddenField ID="hdnEndDate" runat="server" />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Parking Spot Utilization Chart -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h4>🚗 Parking Spot Utilization</h4>
                            <canvas id="slotUtilizationChart"></canvas>
                        </div>
                    </div>
                       <!--Total Number of Users-->
                    <div class="col-md-6">
                      <div class="chart-container">
                          <h4>Total Number of Users</h4>
                         <p>Total Users: <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></p>
                      </div>
                    </div>
                </div>
                <div class="row">
                     <!--Average Booking Duration-->
                   <div class="col-md-6">
                      <div class="chart-container">
                          <h4>Average Booking Duration</h4>
                           <p>Average Duration: <asp:Label ID="lblAvgBookingDuration" runat="server" Text="0"></asp:Label> minutes</p>
                      </div>
                    </div>
                     <!--Top 5 Most Active Users-->
                   
<div class="col-md-6">
    <div class="chart-container">
        <h4>Top 5 Most Active Users</h4>
        <asp:GridView ID="gvTopUsers" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                <asp:BoundField DataField="BookingCount" HeaderText="Booking Count" />
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

    <!-- AJAX Polling Script -->
    <script>
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }

        $(function () {
            function cb(start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                //Set hidden field values
                $('#<%=hdnStartDate.ClientID%>').val(start.format('YYYY-MM-DD'));
                $('#<%=hdnEndDate.ClientID%>').val(end.format('YYYY-MM-DD'));
            }

            $('#reportrange').daterangepicker({
                startDate: moment().subtract(29, 'days'),
                endDate: moment(),
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            }, cb);

            cb(moment().subtract(29, 'days'), moment());

            // AJAX Polling Function
            function updateCharts() {
                $.ajax({
                    type: "POST",
                    url: "ReportsAnalytics.aspx/GetChartData",  // Replace with your actual method
                    data: JSON.stringify({
                        startDate: $('#<%=hdnStartDate.ClientID%>').val(),
                        endDate: $('#<%=hdnEndDate.ClientID%>').val()
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var data = JSON.parse(response.d);

                        // Update Utilization Chart
                        updateChart('slotUtilizationChart', 'doughnut', ['Available', 'Booked'], data.SlotUtilizationData, ['#28a745', '#dc3545']);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error updating charts:", error);
                    }
                });
            }
            // Function to update charts
            function updateChart(chartId, type, labels, data, backgroundColor) {
                var ctx = document.getElementById(chartId).getContext('2d');
                new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Data',
                            data: data,
                            backgroundColor: backgroundColor,
                            borderColor: backgroundColor,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
            // Load initial data
            function loadAdditionalData() {
                $.ajax({
                    type: "POST",
                    url: "ReportsAnalytics.aspx/GetAdditionalData",  // Replace with your actual method
                    data: JSON.stringify({
                        startDate: $('#<%=hdnStartDate.ClientID%>').val(),
                                            endDate: $('#<%=hdnEndDate.ClientID%>').val() }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        var data = JSON.parse(response.d);

                        // Update labels and GridView here
                        $('#<%=lblTotalUsers.ClientID%>').text(data.TotalUsers);
                        $('#<%=lblAvgBookingDuration.ClientID%>').text(data.AvgBookingDuration);
                        updateGridView('<%=gvTopUsers.ClientID%>', data.TopUsers);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error loading additional data:", error);
                    }
                });
            }

            function updateGridView(gridViewID, data) {
                var gridView = $('#' + gridViewID);
                var tbody = gridView.find('tbody');
                tbody.empty(); // Clear existing rows

                // Loop through the data and append new rows
                $.each(data, function (index, item) {
                    var row = $('<tr>');
                    row.append($('<td>').text(item.UserName));
                    row.append($('<td>').text(item.BookingCount));
                    tbody.append(row);
                });
            }

            // Initial chart load
            updateCharts();
            loadAdditionalData();

            // Poll for updates every 5 seconds
            setInterval(updateCharts, 5000);
        });
    </script>
</body>
</html>
