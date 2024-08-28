<%@ Page Title="" Language="C#" MasterPageFile="~/Hr.Master" AutoEventWireup="true" CodeBehind="EmpList.aspx.cs" Inherits="TestWebApplication1.EmpList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
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
        }
        .gridview-selected {
            background-color: #9471DE;
            color: white;
            font-weight: bold;
        }
        .gridview-pager {
            background-color: #C6C3C6;
            color: black;
            text-align: center;
        }
        .centered-gridview h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .gridview-sorted-asc {
            background-color: #F1F1F1;
        }
        .gridview-sorted-asc-header {
            background-color: #007DBB;
        }
        .gridview-sorted-desc {
            background-color: #CAC9C9;
        }
        .gridview-sorted-desc-header {
            background-color: #00547E;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="centered-gridview">
        <h2>Employee List</h2>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
            DataKeyNames="empid" PageSize="5" 
            CellPadding="3" CellSpacing="1" BorderStyle="Ridge" BorderWidth="2px" Width="100%" DataSourceID="SqlDataSource1">
            <Columns>
               
                <asp:BoundField DataField="empid" HeaderText="Emp ID" SortExpression="empid" 
                    ControlStyle-Width="30px" InsertVisible="False" ReadOnly="True" >
<ControlStyle Width="30px"></ControlStyle>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="empname" HeaderText="Emp Name" SortExpression="empname" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="designation" HeaderText="Designation" SortExpression="designation" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="contact" HeaderText="Contact" SortExpression="contact" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doj" HeaderText="Date of Joining" SortExpression="doj" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Action">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CommandField>
            </Columns>
            <FooterStyle CssClass="gridview-footer" />
            <HeaderStyle CssClass="gridview-header" Height="20px" />
            <PagerStyle CssClass="gridview-pager" />
            <RowStyle CssClass="gridview-row" />
            <SelectedRowStyle CssClass="gridview-selected" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:MayBatch1ConnectionString %>" DeleteCommand="DELETE FROM [empdetails] WHERE [empid] = @original_empid AND (([empname] = @original_empname) OR ([empname] IS NULL AND @original_empname IS NULL)) AND (([designation] = @original_designation) OR ([designation] IS NULL AND @original_designation IS NULL)) AND (([contact] = @original_contact) OR ([contact] IS NULL AND @original_contact IS NULL)) AND (([doj] = @original_doj) OR ([doj] IS NULL AND @original_doj IS NULL))" InsertCommand="INSERT INTO [empdetails] ([empid], [empname], [designation], [contact], [doj]) VALUES (@empid, @empname, @designation, @contact, @doj)" OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:MayBatch1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [empdetails]" UpdateCommand="UPDATE [empdetails] SET [empname] = @empname, [designation] = @designation, [contact] = @contact, [doj] = @doj WHERE [empid] = @original_empid AND (([empname] = @original_empname) OR ([empname] IS NULL AND @original_empname IS NULL)) AND (([designation] = @original_designation) OR ([designation] IS NULL AND @original_designation IS NULL)) AND (([contact] = @original_contact) OR ([contact] IS NULL AND @original_contact IS NULL)) AND (([doj] = @original_doj) OR ([doj] IS NULL AND @original_doj IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_empid" Type="Int32" />
                <asp:Parameter Name="original_empname" Type="String" />
                <asp:Parameter Name="original_designation" Type="String" />
                <asp:Parameter Name="original_contact" Type="String" />
                <asp:Parameter DbType="Date" Name="original_doj" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="empid" Type="Int32" />
                <asp:Parameter Name="empname" Type="String" />
                <asp:Parameter Name="designation" Type="String" />
                <asp:Parameter Name="contact" Type="String" />
                <asp:Parameter DbType="Date" Name="doj" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="empname" Type="String" />
                <asp:Parameter Name="designation" Type="String" />
                <asp:Parameter Name="contact" Type="String" />
                <asp:Parameter DbType="Date" Name="doj" />
                <asp:Parameter Name="original_empid" Type="Int32" />
                <asp:Parameter Name="original_empname" Type="String" />
                <asp:Parameter Name="original_designation" Type="String" />
                <asp:Parameter Name="original_contact" Type="String" />
                <asp:Parameter DbType="Date" Name="original_doj" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
