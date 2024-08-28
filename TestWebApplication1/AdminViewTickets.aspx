<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewTickets.aspx.cs" Inherits="TestWebApplication1.AdminViewTickets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .centered-gridview {
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            width: 100%;
            max-width: 1100px;
        }
        .search-container {
            margin: 20px 0;
        }

        .search-label {
            font-weight: bold;
        }

        .grid-container {
            margin: 20px 0;
        }

        .grid-view {
            border-collapse: collapse;
            width: 100%;
        }

        .grid-view th, .grid-view td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .grid-view th {
            background-color: #f2f2f2;
            text-align: left;
        }

        .grid-view tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .grid-view tr:hover {
            background-color: #ddd;
        }

        .action-buttons {
            text-align: center;
        }
        .page-header {
            text-align: center;
            margin: 20px 0;
            color: #4CAF50;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="search-container">
        <label class="search-label">Search:</label>
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>Daily</asp:ListItem>
            <asp:ListItem>Weekly</asp:ListItem>
            <asp:ListItem>Monthly</asp:ListItem>
            <asp:ListItem>Yearly</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="Search" />
        <asp:Button ID="Button2" runat="server" Text="Export" OnClick="Button2_Click" />
    </div>
    <div class="centered-gridview">
    <%--<div class="grid-container">--%>
        <h2 class="page-header">Pending Tickets</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ticketid" DataSourceID="SqlDataSource1" CssClass="grid-view">
            <Columns>
                <asp:BoundField DataField="ticketid" HeaderText="Ticket ID" ReadOnly="True" SortExpression="ticketid" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="empid" HeaderText="Employee ID" SortExpression="empid" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="empname" HeaderText="Employee Name" SortExpression="empname" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="urole" HeaderText="Role" SortExpression="urole" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ticket" HeaderText="Ticket" SortExpression="ticket" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="raisedate" HeaderText="Raise Date" SortExpression="raisedate" DataFormatString="{0:yyyy-MM-dd}" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="solution" HeaderText="Solution" SortExpression="solution" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="tktstatus" HeaderText="Status" SortExpression="tktstatus" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="raiseTo" HeaderText="Raised To" SortExpression="raiseTo" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="raiseToEmpId" HeaderText="Raise To Employee ID" SortExpression="raiseToEmpId" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Action" />
            </Columns>
        </asp:GridView>
         </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            OldValuesParameterFormatString="original_{0}"
            ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>"
            SelectCommand="SELECT [ticketid], [empid], [empname], [urole], [ticket], [raisedate], [solution], [tktstatus], [raiseTo], [raiseToEmpId] FROM [raiseTicket]">
        </asp:SqlDataSource>
    <%--</div>--%>
       
</asp:Content>
