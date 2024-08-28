<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="EmpOfferLetter.aspx.cs" Inherits="TestWebApplication1.EmpOfferLetter" %>
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
        <h2>Offer Letter</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="empid" PageSize="5" 
            CellPadding="3" CellSpacing="1" BorderStyle="Ridge" BorderWidth="2px" Width="100%" DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:BoundField DataField="empid" HeaderText="Emp ID" SortExpression="empid" 
                    ControlStyle-Width="30px" InsertVisible="False" ReadOnly="True">
                    <ControlStyle Width="30px"></ControlStyle>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="empname" HeaderText="Emp Name" SortExpression="empname">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="designation" HeaderText="Designation" SortExpression="designation">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="contact" HeaderText="Contact" SortExpression="contact">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doj" HeaderText="Date of Joining" SortExpression="doj">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="offerfname" HeaderText="Offer Filename" SortExpression="offerfname" Visible="False">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <asp:LinkButton ID="Button1" runat="server" CommandName="View" CommandArgument='<%# Eval("offerfname") %>' Text='<i class="fa fa-eye"></i> View OfferLetter' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Download">
                    <ItemTemplate>
                        <asp:LinkButton ID="Button2" runat="server" CommandName="Download" CommandArgument='<%# Eval("offerfname") %>' CssClass="btn btn-warning" Text='<i class="fa fa-download"></i> Download' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                    <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
                </asp:TemplateField>
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>" SelectCommand="SELECT [empid], [empname], [contact], [designation], [doj],[offerfname] FROM [empofferletters] WHERE ([email] = @email)">
            <SelectParameters>
                <asp:SessionParameter Name="email" SessionField="MyUser" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
