<%@ Page Title="" Language="C#" MasterPageFile="~/Hr.Master" AutoEventWireup="true" CodeBehind="HrHome.aspx.cs" Inherits="TestWebApplication1.HrHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Add custom styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 800px;
            margin: 50px auto;
            text-align: center;
        }
        
        h1 {
            color: #333;
            font-size: 36px;
            margin-bottom: 20px;
        }
        
        p {
            color: #666;
            font-size: 18px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Hello HR, Welcome to the HRMS portal.</h1>
        <p>We're here to streamline your HR processes.</p>
    </div>
</asp:Content>
