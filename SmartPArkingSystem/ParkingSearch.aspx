<%@ Page Title="Parking Search" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="ParkingSearch.aspx.cs" Inherits="SmartPArkingSystem.ParkingSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --background-color: #f4f6f7;
            --text-color: #2c3e50;
            --card-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            color: var(--text-color);
            line-height: 1.6;
        }

        .parking-search-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .parking-search-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .parking-search-header h1 {
            font-size: 2.5rem;
            color: #001f3f;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .parking-search-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, 
                rgba(52, 152, 219, 0.1), 
                rgba(46, 204, 113, 0.1));
            transform: rotate(-15deg);
            z-index: 0;
        }

        .search-container {
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 30px;
            margin-bottom: 30px;
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text-color);
        }

        .form-control {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            outline: none;
        }

        .btn-search {
            background-color: #001f3f;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            grid-column: span 2;
            justify-self: center;
        }

        .btn-search:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .parking-results {
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 30px;
        }

        .parking-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        .parking-table th {
            background-color: #001f3f;
            color: white;
            padding: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .parking-table td {
            padding: 15px;
            background-color: #f9f9f9;
            border-bottom: 2px solid #e0e0e0;
        }

        .book-button {
            background-color: var(--secondary-color);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .book-button:hover {
            background-color: #27ae60;
            transform: scale(1.05);
        }

        .book-button:disabled {
            background-color: #95a5a6;
            cursor: not-allowed;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 15px;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .search-form {
                grid-template-columns: 1fr;
            }

            .btn-search {
                grid-column: span 1;
            }
        }
    </style>

    <div class="parking-search-wrapper">
        <div class="parking-search-header">
            <h1>Find Your Perfect Parking Spot</h1>
        </div>

        <div class="search-container">
            <div class="search-form">
                <div class="form-group">
                    <label for="ddlCity">Select City</label>
                    <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control" 
                        AutoPostBack="true" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                        <asp:ListItem Text="-- Select City --" Value="" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label for="ddlArea">Select Area</label>
                    <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control">
                        <asp:ListItem Text="-- Select Area --" Value="" />
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnSearch" runat="server" Text="Search Parking" 
                    CssClass="btn-search" OnClick="btnSearch_Click" />
                
                <asp:Label ID="lblMessage" runat="server" CssClass="error-message" />
            </div>
        </div>

        <div class="parking-results">
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

        <!-- Slots Section (Optional) -->
        <div class="parking-results" style="margin-top: 20px;">
            <h3>Available Slots</h3>
            <asp:GridView ID="gvSlots" runat="server" AutoGenerateColumns="False"
                CssClass="parking-table" Visible="false">
                <Columns>
                    <asp:BoundField DataField="SlotID" HeaderText="Slot ID" />
                    <asp:BoundField DataField="SlotNumber" HeaderText="Slot Number" />
                    <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsAvailable")) ? "text-success" : "text-danger" %>'>
                                <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Available" : "Occupied" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>






