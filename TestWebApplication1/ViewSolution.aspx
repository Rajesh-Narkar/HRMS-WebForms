<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="ViewSolution.aspx.cs" Inherits="TestWebApplication1.ViewSolution" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
         .centered-gridview {
             margin: auto;
             padding: 20px;
             border: 1px solid #ccc;
             border-radius: 10px;
             background-color: #f9f9f9;
             width: 90%;
             max-width: 1100px;
         }
        .gridview-header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }
        .gridview-row {
            text-align: center;
        }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .gridview th, .gridview td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .gridview tr:hover {
            background-color: #ddd;
        }
        .gridview th {
            background-color: #4CAF50;
            color: white;
        }
        .page-header {
            text-align: center;
            margin: 20px 0;
            color: #4CAF50;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="centered-gridview">
    <h2 class="page-header">Ticket Solutions</h2>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ticketid" DataSourceID="SqlDataSource1" CssClass="gridview">
        <Columns>
            <asp:BoundField DataField="ticketid" HeaderText="Ticket ID" InsertVisible="False" ReadOnly="True" SortExpression="ticketid">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="ticket" HeaderText="Ticket" SortExpression="ticket">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="raisedate" HeaderText="Raised Date" SortExpression="raisedate">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="solution" HeaderText="Solution" SortExpression="solution">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="deletedate" HeaderText="Resolved Date" SortExpression="deletedate">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="tktstatus" HeaderText="Ticket Status" SortExpression="tktstatus">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="raiseToEmpId" HeaderText="Resolved By Emp ID" SortExpression="raiseToEmpId">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="raiseTo" HeaderText="Resolved By Ename" SortExpression="raiseTo">
                <HeaderStyle CssClass="gridview-header" HorizontalAlign="Center" />
                <ItemStyle CssClass="gridview-row" HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>" SelectCommand="SELECT [ticketid], [ticket], [raisedate], [solution],[deletedate],[raiseTo],[raiseToEmpId], [tktstatus] FROM [solution] WHERE (([empid] = @empid) AND ([tktstatus] = @tktstatus))">
        <SelectParameters>
            <asp:SessionParameter Name="empid" SessionField="EmpId" Type="Int32" />
            <asp:Parameter DefaultValue="Closed" Name="tktstatus" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
