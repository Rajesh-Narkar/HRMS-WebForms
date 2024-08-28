<%@ Page Title="" Language="C#" MasterPageFile="~/Hr.Master" AutoEventWireup="true" CodeBehind="GeneratePaySlip.aspx.cs" Inherits="TestWebApplication1.GeneratePaySlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .center-table {
            margin: auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            max-width: 600px;
            background-color: #f9f9f9;
        }
        .center-table th, .center-table td {
            padding: 10px;
            text-align: left;
        }
        .center-table th {
            background-color: #f2f2f2;
        }
        .center-table td {
            border-bottom: 1px solid #ccc;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            margin: 10px 0;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br/>
    <div class="center-table">
        <h2>Generate Pay Slip</h2>
        <div class="form-group">
            <label for="TextBox1">Enter Emp No: </label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
            <label for="TextBox13">Month: </label>
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
    <asp:ListItem>January</asp:ListItem>
    <asp:ListItem>February</asp:ListItem>
    <asp:ListItem>March</asp:ListItem>
    <asp:ListItem>April</asp:ListItem>
    <asp:ListItem>May</asp:ListItem>
    <asp:ListItem>June</asp:ListItem>
    <asp:ListItem>July</asp:ListItem>
    <asp:ListItem>August</asp:ListItem>
    <asp:ListItem>September</asp:ListItem>
    <asp:ListItem>October</asp:ListItem>
    <asp:ListItem>November</asp:ListItem>
    <asp:ListItem>December</asp:ListItem>
</asp:DropDownList>
            <asp:Button ID="Button2" runat="server" Text="Search" CssClass="btn" OnClick="Button2_Click" />
        </div>
        <table>
            <tr>
                <td>Employee Name</td>
                <td><asp:Label ID="Label1" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Bank Name: </td>
                <td><asp:Label ID="Label2" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Contact No:</td>
                <td><asp:Label ID="Label3" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Bank Account No:</td>
                <td><asp:Label ID="Label4" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Email: </td>
                <td><asp:Label ID="Label5" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Designation:</td>
                <td><asp:Label ID="Label6" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Date of Joining</td>
                <td><asp:Label ID="Label7" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Leave days [In Month]:</td>
                <td><asp:Label ID="Label8" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Monthly Salary</td>
                <td><asp:Label ID="Label9" runat="server"></asp:Label></td>
            </tr>
           
            <tr>
                <td>Total Working Days in Month</td>
                <td><asp:Label ID="Label10" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Leaves Taken:</td>
                <td><asp:Label ID="Label11" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="Button3" runat="server" Text="Calculate Salary" CssClass="btn" OnClick="Button3_Click" />
                </td>
                <td></td>
            </tr>
            <tr>
                <td>Calculated Salary:</td>
                <td><asp:Label ID="Label12" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="Button4" runat="server" Text="Generate PDF" CssClass="btn" OnClick="Button4_Click" />
                </td>
                <td></td>
            </tr>
        </table>
    </div>
</asp:Content>
