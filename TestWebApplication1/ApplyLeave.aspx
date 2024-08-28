<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="ApplyLeave.aspx.cs" Inherits="TestWebApplication1.ApplyLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br/>
    
    <div style="max-width: 600px; margin: auto; border: 1px solid #ccc; padding: 20px; border-radius: 10px;">
       <h2 class="text-center ; margin-bottom:20px">Leave Application</h2>
        <asp:Label ID="leaveLabelFrom" runat="server" Text="Select Leave From Date: "></asp:Label>
        <asp:TextBox ID="TextBoxFrom" runat="server" TextMode="Date" CssClass="form-control mb-3" />
        
        <asp:Label ID="leaveLabelTo" runat="server" Text="Select Leave To Date: "></asp:Label>
        <asp:TextBox ID="TextBoxTo" runat="server" TextMode="Date" CssClass="form-control mb-3" />
        
        <asp:Label ID="leaveLabelReason" runat="server" Text="Reason for Leave: "></asp:Label>
        <asp:TextBox ID="TextBoxReason" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control mb-3" />        
        
        <asp:Button ID="calculateButton" runat="server" Text="Calculate Leave Days" OnClick="CalculateButton_Click" CssClass="btn btn-primary" />
         <br /><br />
        <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <br /><br />
        <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="SubmitButton_Click" CssClass="btn btn-primary" />
        
       
    </div>
</asp:Content>
