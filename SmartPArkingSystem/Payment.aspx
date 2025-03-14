<%@ Page Title="Payment" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="SmartPArkingSystem.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5efeb;
            margin: 0;
            padding: 0;
        }

        .payment-container {
            text-align: center;
            width: 90%;
            max-width: 500px;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2F4156;
        }

        label {
            font-size: 16px;
            display: block;
            margin-top: 10px;
            text-align: left;
        }

        .input-field {
            padding: 10px;
            font-size: 16px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
        }

        .pay-btn {
            background-color: #2F4156;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            cursor: pointer;
            font-size: 18px;
            border-radius: 5px;
            transition: 0.3s;
            margin-top: 15px;
        }

        .pay-btn:hover {
            background-color: #567C8D;
        }

        .hidden {
            display: none;
        }

        .qr-code {
            width: 200px;
            margin: 10px auto;
            display: block;
        }
    </style>

    <div class="payment-container">
        <h2>Complete Your Payment</h2>

        <label>Amount:</label>
        <asp:TextBox ID="txtAmount" runat="server" CssClass="input-field" ReadOnly="true"></asp:TextBox>
        <asp:Image ID="imgQRCode" runat="server" />


        <label>Payment Method:</label>
        <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="input-field" AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
            <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
            <asp:ListItem Text="UPI" Value="UPI"></asp:ListItem>
        </asp:DropDownList>

        <!-- QR Code Display for UPI -->
        <asp:Panel ID="pnlUPIQR" runat="server" CssClass="hidden">
            <label>Scan & Pay:</label>
            <img src="images/UPI_QR.jpg" alt="Scan to Pay" class="qr-code" />
           
        </asp:Panel>

        <!-- Transaction ID input for UPI -->
        <asp:Panel ID="pnlTransactionID" runat="server" CssClass="hidden">
            <label for="txtTransactionID">Transaction ID:</label>
            <asp:TextBox ID="txtTransactionID" runat="server" CssClass="input-field"></asp:TextBox>

            <label for="fileReceipt">Upload Payment Screenshot:</label>
            <asp:FileUpload ID="fileReceipt" runat="server" CssClass="input-field" />
        </asp:Panel>

        <asp:Button ID="btnPay" runat="server" CssClass="pay-btn" Text="Make Payment" OnClick="btnPay_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </div>

    <script>
        function togglePaymentOptions() {
            var paymentMethod = document.getElementById("<%= ddlPaymentMethod.ClientID %>").value;
            var qrCodeDiv = document.getElementById("<%= pnlUPIQR.ClientID %>");
            var transactionDiv = document.getElementById("<%= pnlTransactionID.ClientID %>");

            if (paymentMethod === "UPI") {
                qrCodeDiv.style.display = "block";
                transactionDiv.style.display = "block";
            } else {
                qrCodeDiv.style.display = "none";
                transactionDiv.style.display = "none";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            togglePaymentOptions();
            document.getElementById("<%= ddlPaymentMethod.ClientID %>").addEventListener("change", togglePaymentOptions);
        });
    </script>
</asp:Content>
