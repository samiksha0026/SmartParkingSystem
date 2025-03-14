<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserPayments.aspx.cs" Inherits="SmartPArkingSystem.UserPayments" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Payment History</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: navy;
        }
        .table-container {
            overflow-x: auto;
        }
        .table {
            width: 100%;
            min-width: 600px; /* Prevents table from breaking */
            border-collapse: collapse;
            margin-top: 20px;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .table th {
            background-color: navy;
            color: white;
        }
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }
            .table-container {
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>My Payment History</h2>
        
        <div class="table-container">
            <asp:GridView ID="GridViewPayments" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="PaymentID" HeaderText="Payment ID" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount Paid" />
                    <asp:BoundField DataField="PaymentMethod" HeaderText="Method" />
                    <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" />
                    <asp:BoundField DataField="PaymentDate" HeaderText="Date" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</body>
</html>
