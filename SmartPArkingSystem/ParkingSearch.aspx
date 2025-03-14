<%@ Page Title="Parking Search" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="ParkingSearch.aspx.cs" Inherits="SmartPArkingSystem.ParkingSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* =======================
        General Page Styling
        ======================= */
        body {
            font-family: Arial, sans-serif;
            background-color: #F5EFEB;
            margin: 0;
            padding: 0;
        }

        /* Centered Main Container */
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            text-align: left;
        }

        /* =======================
        Search Section Styling
        ======================= */
        .search-section {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center; /* Center items horizontally */
        }

            .search-section h2 {
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            .search-section label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #555;
                text-align: left;
            }

            .search-section select {
                width: 300px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-bottom: 15px;
                margin-left: auto;
                margin-right: auto;
                display: block;
                text-align: center;
            }

            .search-section button {
                padding: 10px 20px;
                background-color: #2F4156;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

                .search-section button:hover {
                    background-color: #1f2c3b;
                }

        /* =======================
        Table Styling
        ======================= */
        .table-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .parking-table {
            width: 100%;
            border-collapse: collapse;
            margin: auto;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .parking-table th,
        .parking-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        .parking-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        /* Book Now Button */
        .book-button {
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

            .book-button:hover {
                background-color: #367C39;
            }

        /* Responsive Design */
        @media (max-width: 768px) {
            .search-section select {
                width: 100%;
            }
        }

        /* Error Message Styling */
        .error-message {
            color: #d9534f;
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }
    </style>

    <div class="container">
        <div class="search-section">
            <h2>Find a Parking Spot</h2>

            <label for="ddlCity">Select City:</label>
            <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                <asp:ListItem Text="-- Select City --" Value="" />
            </asp:DropDownList>

            <label for="ddlArea">Select Area:</label>
            <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control">
                <asp:ListItem Text="-- Select Area --" Value="" />
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Search Parking" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message" ForeColor="Red" />
        </div>

        <div class="table-container">
            <asp:GridView ID="gvParkingSpots" runat="server" AutoGenerateColumns="False"
                CssClass="parking-table" OnRowCommand="gvParkingSpots_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Parking Name" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="Area" HeaderText="Area" />
                    <asp:BoundField DataField="AvailableSlots" HeaderText="Available Spots" />
                    <asp:BoundField DataField="Price" HeaderText="Price (₹)" />

                    <asp:TemplateField HeaderText="Book">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfParkingID" runat="server" Value='<%# Eval("ParkingID") %>' />
                            <asp:Button ID="btnBook" runat="server" Text="Book Now" CssClass="book-button"
                                CommandName="Book" CommandArgument='<%# Eval("ParkingID") %>'
                                Enabled='<%# Convert.ToInt32(Eval("AvailableSlots")) > 0 %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div style="margin-top: 20px;">
            <h3>Available Slots</h3>
            <asp:GridView ID="gvSlots" runat="server" AutoGenerateColumns="False"
                CssClass="parking-table" Visible="false">
                <Columns>
                    <asp:BoundField DataField="SlotID" HeaderText="Slot ID" />
                    <asp:BoundField DataField="SlotNumber" HeaderText="Slot Number" />
                    <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "slot-available" : "slot-unavailable" %>'>
                                <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Available" : "Occupied" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
