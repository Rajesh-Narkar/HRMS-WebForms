<%@ Page Title="" Language="C#" MasterPageFile="~/Hr.Master" AutoEventWireup="true" CodeBehind="ApproveLeave.aspx.cs" Inherits="TestWebApplication1.ApproveLeave" %>
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
            background-color: white;
            color: #000066;
            text-align: center;
        }
        .gridview-row {
            color: #DEDFDE;
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
        .centered-gridview h2 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="centered-gridview">
        <h2>Leave Applications</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Height="141px" Width="100%" 
            DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand1">
            <Columns>
                <asp:BoundField DataField="empid" HeaderText="Emp ID" InsertVisible="False" ReadOnly="True" SortExpression="empid">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:BoundField DataField="email" HeaderText="Emp Email" SortExpression="empname">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                
                <asp:BoundField DataField="leavefromdate" HeaderText="Leave From Date" SortExpression="leavefromdate">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:BoundField DataField="leavetodate" HeaderText="Leave To Date" SortExpression="leavetodate">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
               <asp:BoundField DataField="reason" HeaderText="Leave Reason" SortExpression="reason">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:BoundField DataField="addleavedays" HeaderText="Additional Leaves" SortExpression="addleavedays">
                     <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                     <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                 </asp:BoundField>
                <asp:BoundField DataField="lstatus" HeaderText="Leave Status" SortExpression="lstatus">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CommandName="Approve" CommandArgument='<%# Eval("empid") %>' CssClass="btn btn-warning" Text="Approve" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="Button2" runat="server" CommandName="Reject" CommandArgument='<%# Eval("empid") %>' CssClass="btn btn-warning" Text="Reject" />
                </ItemTemplate>
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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MayBatch1ConnectionString8 %>" ProviderName="<%$ ConnectionStrings:MayBatch1ConnectionString8.ProviderName %>" SelectCommand="SELECT [empid], [email], [leavefromdate], [leavetodate], [reason], [addleavedays], [lstatus] FROM [empapplyleave]"></asp:SqlDataSource>

    </div>
</asp:Content>
