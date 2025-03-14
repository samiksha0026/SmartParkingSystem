<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="SmartPArkingSystem.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;400;600&display=swap');

        body {
            background-color: #F7F7F7;
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .history-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            flex-wrap: wrap;
        }

        .history-card {
            background: #FFFFFF;
            border-radius: 15px;
            width: 100%;
            max-width: 1100px;
            padding: 30px;
            box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            margin: 10px;
        }

        .history-card:hover {
            transform: translateY(-5px);
        }

        .history-title {
            font-size: 36px;
            font-weight: 600;
            color: #2D3748;
            text-align: center;
            margin-bottom: 25px;
            font-family: 'Poppins', sans-serif;
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .history-table th, .history-table td {
            padding: 18px;
            text-align: left;
            font-size: 16px;
        }

        .history-table th {
            background: #4C51BF;
            color: white;
            font-weight: 600;
            border-radius: 8px 8px 0 0;
        }

        .history-table td {
            background: #F1F5F9;
            color: #2D3748;
            border-bottom: 1px solid #E2E8F0;
        }

        .history-table tr:nth-child(even) {
            background: #E2E8F0;
        }

        .history-table tr:hover {
            background: #CBD5E0;
        }

        .btn-download {
            display: block;
            width: 100%;
            background: #48BB78;
            color: white;
            padding: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: 0.3s;
            font-weight: 600;
            margin-top: 25px;
            text-align: center;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .btn-download:hover {
            background: #38A169;
            transform: translateY(-2px);
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .history-card {
                width: 100%;
                padding: 20px;
            }

            .history-title {
                font-size: 28px;
            }

            .history-table th, .history-table td {
                font-size: 14px;
                padding: 12px;
            }

            .btn-download {
                font-size: 16px;
                padding: 14px;
            }

            .history-container {
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
        }

        /* Extra small screens */
        @media (max-width: 480px) {
            .history-title {
                font-size: 24px;
            }

            .history-table th, .history-table td {
                font-size: 12px;
                padding: 10px;
            }

            .btn-download {
                font-size: 14px;
                padding: 12px;
            }

            .history-card {
                padding: 15px;
            }

            .history-table {
                margin-bottom: 15px;
            }
        }
    </style>
    
    <div class="history-container">
        <div class="history-card">
            <div class="history-title">My Parking History</div>
            <table class="history-table">
                <tr>
                    <th>Booking ID</th>
                    <th>Vehicle</th>
                    <th>Parking Spot</th>
                    <th>Date</th>
                    <th>Amount</th>
                </tr>
                <tr>
                    <td>1001</td>
                    <td>Sedan</td>
                    <td>A1</td>
                    <td>2025-02-06</td>
                    <td>10</td>
                </tr>
                <tr>
                    <td>1002</td>
                    <td>Bike</td>
                    <td>B3</td>
                    <td>2025-02-05</td>
                    <td>5</td>
                </tr>
            </table>
            <asp:Button ID="btnDownload" runat="server" CssClass="btn-download" Text="Download History" />
        </div>
    </div>
</asp:Content>
