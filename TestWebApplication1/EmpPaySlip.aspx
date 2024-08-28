<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="EmpPaySlip.aspx.cs" Inherits="TestWebApplication1.EmpPaySlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .centered-gridview {
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            width: 90%;
            max-width: 1100px;
            text-align: center;
        }
        .gridview-header {
            background-color: #4A3C8C;
            color: #E7E7FF;
            font-weight: bold;
            text-align: center;
        }
        .gridview-footer {
            background-color: #C6C3C6;
            color: black;
            text-align: center;
        }
        .gridview-row {
            background-color: #DEDFDE;
            color: black;
            text-align: center;
        }
        .gridview-selected {
            background-color: #9471DE;
            color: white;
            font-weight: bold;
            text-align: center;
        }
        .gridview-pager {
            background-color: #C6C3C6;
            color: black;
            text-align: right;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-warning {
            background-color: #ffcc00;
            color: black;
        }
        .btn-warning:hover {
            background-color: #e6b800;
        }
        .fa {
            margin-right: 5px;
        }
    </style>
    <br />
    <div class="centered-gridview">
        <h2>Payslips</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
            DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:BoundField DataField="ename" HeaderText="Emp Name" InsertVisible="False" ReadOnly="True" SortExpression="ename">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:BoundField DataField="month" HeaderText="Month" SortExpression="month">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <asp:LinkButton ID="Button1" runat="server" CommandName="View" CommandArgument='<%# Eval("fname") %>' Text='<i class="fa fa-eye"></i> View Payslip' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Download">
                    <ItemTemplate>
                        <asp:LinkButton ID="Button2" runat="server" CommandName="Download" CommandArgument='<%# Eval("fname") %>' CssClass="btn btn-warning" Text='<i class="fa fa-download"></i> Download' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle CssClass="gridview-footer" />
            <HeaderStyle CssClass="gridview-header" />
            <PagerStyle CssClass="gridview-pager" />
            <RowStyle CssClass="gridview-row" />
            <SelectedRowStyle CssClass="gridview-selected" />
            <SortedAscendingCellStyle CssClass="gridview-sorted-asc" />
            <SortedAscendingHeaderStyle CssClass="gridview-sorted-asc-header" />
            <SortedDescendingCellStyle CssClass="gridview-sorted-desc" />
            <SortedDescendingHeaderStyle CssClass="gridview-sorted-desc-header" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>" SelectCommand="SELECT [ename], [month], [fname] FROM [emppayslip] WHERE ([em] = @em)">
            <SelectParameters>
                <asp:SessionParameter Name="em" SessionField="MyUser" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
