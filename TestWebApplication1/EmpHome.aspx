<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="EmpHome.aspx.cs" Inherits="TestWebApplication1.EmpHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Add custom styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
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
        <h1>Welcome <asp:Label ID="Label2" runat="server"></asp:Label>, to the HRMS Portal</h1>
        <p>We're glad to have you on board!</p>
    </div>
</asp:Content>
