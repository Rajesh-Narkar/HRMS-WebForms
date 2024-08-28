<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="RaiseTicket.aspx.cs" Inherits="TestWebApplication1.RaiseTicket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
        }
        .ticket-form {
            background: #fff;
            padding: 20px;
            margin: 20px auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }
        .ticket-form h2 {
            margin-bottom: 20px;
        }
        .ticket-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .ticket-form select,
        .ticket-form textarea,
        .ticket-form input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .ticket-form button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .ticket-form button:hover {
            background-color: #0056b3;
        }
        .ticket-form h2 {
            text-align: center;
            margin-bottom: 20px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="ticket-form">    
        <h2>Raise a Ticket</h2>
        <form>
            
            <label for="DropDownList1">Role</label>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem Text="Select Role" Value="" />
                <asp:ListItem Text="HR" Value="HR" />
                <asp:ListItem Text="Trainer" Value="Trainer" />
                <asp:ListItem Text="Trainee" Value="Trainee" />
            </asp:DropDownList>

            <label for="DropDownList2">Raise To</label>
            <asp:DropDownList ID="DropDownList2" runat="server">
                <asp:ListItem Text="Select Person" Value="" />
                <%--<asp:ListItem Text="IT Support" Value="IT Support" />
                <asp:ListItem Text="HR" Value="HR" />--%>
            </asp:DropDownList>

            <label for="TextBox1">Ticket</label>
            <asp:TextBox ID="TextBox1" runat="server" Height="69px" TextMode="MultiLine" Width="455px"></asp:TextBox>

            <label for="FileUpload1">Attachment</label>
            <asp:FileUpload ID="FileUpload1" runat="server" />

            <asp:Button ID="Button2" runat="server" Text="Raise Ticket" CssClass="btn btn-primary" OnClick="Button2_Click" />
        </form>
    </div>
</asp:Content>
