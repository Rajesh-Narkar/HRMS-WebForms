<%@ Page Title="" Language="C#" MasterPageFile="~/Hr.Master" AutoEventWireup="true" CodeBehind="GenerateOfferLetter.aspx.cs" Inherits="TestWebApplication1.GenerateOfferLetter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .center-form {
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            max-width: 600px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .center-form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="center-form">
        <h2>Generate Offer Letter</h2>
        <div class="form-group">
            <label for="TextBox4">Emp ID:</label>
            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:Button ID="Button2" CssClass="btn" runat="server" OnClick="Button2_Click" Text="Fetch Details" />
        </div>
        <div class="form-group">
            <label for="Label1">Emp Full Name:</label>
            <asp:Label ID="Label1" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <label for="TextBox5">Designation:</label>
            <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="Label3">Email ID:</label>
            <asp:Label ID="Label3" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <label for="Label4">Contact:</label>
            <asp:Label ID="Label4" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <label for="Label5">Date of Joining:</label>
            <asp:Label ID="Label5" runat="server" CssClass="form-control" />
        </div>
        <asp:Button ID="GenerateButton" runat="server" Text="Generate Offer Letter" CssClass="btn" OnClick="GenerateButton_Click" />
    </div>
</asp:Content>
