<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="LeaveStatus.aspx.cs" Inherits="TestWebApplication1.LeaveStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Styling for GridView */
        .gridview {
            margin: auto;
            border-collapse: collapse;
            width: 90%;
            max-width: 1000px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .gridview th, .gridview td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }
        .gridview th {
            background-color: #f2f2f2;
        }
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .gridview tr:hover {
            background-color: #ddd;
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
    <h2 class="text-center">Leave Status</h2>
    <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="sr" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="sr" HeaderText="Sr No" InsertVisible="False" ReadOnly="True" SortExpression="sr">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="leavefromdate" HeaderText="Leave From" SortExpression="leavefromdate">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="leavetodate" HeaderText="Leave To" SortExpression="leavetodate">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="reason" HeaderText="Reason" SortExpression="reason">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="addleavedays" HeaderText="Additional Leaves" SortExpression="addleavedays">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="lstatus" HeaderText="Leave Status" SortExpression="lstatus">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:CommandField DeleteText="Cancel Leave" HeaderText="Action" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" DeleteCommand="DELETE FROM [empapplyleave] WHERE [sr] = @original_sr AND (([lstatus] = @original_lstatus) OR ([lstatus] IS NULL AND @original_lstatus IS NULL)) AND (([leavetodate] = @original_leavetodate) OR ([leavetodate] IS NULL AND @original_leavetodate IS NULL)) AND (([leavefromdate] = @original_leavefromdate) OR ([leavefromdate] IS NULL AND @original_leavefromdate IS NULL)) AND (([reason] = @original_reason) OR ([reason] IS NULL AND @original_reason IS NULL)) AND (([addleavedays] = @original_addleavedays) OR ([addleavedays] IS NULL AND @original_addleavedays IS NULL))" InsertCommand="INSERT INTO [empapplyleave] ([lstatus], [leavetodate], [leavefromdate], [reason], [addleavedays]) VALUES (@lstatus, @leavetodate, @leavefromdate, @reason, @addleavedays)" OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>" SelectCommand="SELECT [lstatus], [sr], [leavetodate], [leavefromdate], [reason], [addleavedays] FROM [empapplyleave] WHERE ([email] = @email)" UpdateCommand="UPDATE [empapplyleave] SET [lstatus] = @lstatus, [leavetodate] = @leavetodate, [leavefromdate] = @leavefromdate, [reason] = @reason, [addleavedays] = @addleavedays WHERE [sr] = @original_sr AND (([lstatus] = @original_lstatus) OR ([lstatus] IS NULL AND @original_lstatus IS NULL)) AND (([leavetodate] = @original_leavetodate) OR ([leavetodate] IS NULL AND @original_leavetodate IS NULL)) AND (([leavefromdate] = @original_leavefromdate) OR ([leavefromdate] IS NULL AND @original_leavefromdate IS NULL)) AND (([reason] = @original_reason) OR ([reason] IS NULL AND @original_reason IS NULL)) AND (([addleavedays] = @original_addleavedays) OR ([addleavedays] IS NULL AND @original_addleavedays IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_sr" Type="Int32" />
                <asp:Parameter Name="original_lstatus" Type="String" />
                <asp:Parameter DbType="Date" Name="original_leavetodate" />
                <asp:Parameter DbType="Date" Name="original_leavefromdate" />
                <asp:Parameter Name="original_reason" Type="String" />
                <asp:Parameter Name="original_addleavedays" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="lstatus" Type="String" />
                <asp:Parameter DbType="Date" Name="leavetodate" />
                <asp:Parameter DbType="Date" Name="leavefromdate" />
                <asp:Parameter Name="reason" Type="String" />
                <asp:Parameter Name="addleavedays" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="email" SessionField="MyUser" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="lstatus" Type="String" />
                <asp:Parameter DbType="Date" Name="leavetodate" />
                <asp:Parameter DbType="Date" Name="leavefromdate" />
                <asp:Parameter Name="reason" Type="String" />
                <asp:Parameter Name="addleavedays" Type="Int32" />
                <asp:Parameter Name="original_sr" Type="Int32" />
                <asp:Parameter Name="original_lstatus" Type="String" />
                <asp:Parameter DbType="Date" Name="original_leavetodate" />
                <asp:Parameter DbType="Date" Name="original_leavefromdate" />
                <asp:Parameter Name="original_reason" Type="String" />
                <asp:Parameter Name="original_addleavedays" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </asp:Content>
