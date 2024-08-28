<%@ Page Title="" Language="C#" MasterPageFile="~/Emp.Master" AutoEventWireup="true" CodeBehind="ViewTicket.aspx.cs" Inherits="TestWebApplication1.ViewTicket" %>
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
        .modal-content {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #000;
        }
        .modal-header {
            background-color: #5cb85c;
            color: white;
            border-bottom: none;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .modal-footer {
            border-top: none;
        }
        .btn-warning {
            background-color: #f0ad4e;
            border-color: #eea236;
        }
        .btn-warning:hover {
            background-color: #ec971f;
            border-color: #d58512;
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
    <h2 class="page-header">View Tickets</h2>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" OnRowCommand="GridView1_RowCommand1">
        <Columns>
            <asp:BoundField DataField="ticketid" HeaderText="Ticket ID" InsertVisible="False" ReadOnly="True" SortExpression="ticketid">
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:BoundField>
            <asp:BoundField DataField="ticket" HeaderText="Ticket Description" SortExpression="ticket">
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:BoundField>
            <asp:BoundField DataField="empid" HeaderText="Emp ID" SortExpression="empid">
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:BoundField>
            <asp:BoundField DataField="empname" HeaderText="Emp Name" SortExpression="empname">
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:BoundField>
            <asp:BoundField DataField="urole" HeaderText="Role" SortExpression="urole">
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Attachment">
                <ItemTemplate>
                    <asp:LinkButton ID="Button1" runat="server" CommandName="Attachment" CommandArgument='<%# Eval("attachment") %>' Text='<i class="fa fa-eye"></i> View Attachment' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:LinkButton ID="Button2" runat="server" CommandName="Action" CommandArgument='<%# Eval("ticketid") %>' CssClass="btn btn-warning" Text='Close' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" CssClass="gridview-header" />
                <ItemStyle HorizontalAlign="Center" CssClass="gridview-row" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" ProviderName="<%$ ConnectionStrings:DBConnectionString.ProviderName %>" SelectCommand="SELECT [ticketid], [ticket], [attachment], [empid], [empname], [urole] FROM [raiseTicket] WHERE ([raiseToEmpId] = @empid)">
        <SelectParameters>
            <asp:SessionParameter Name="empid" SessionField="EmpId" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>

    <%-- Modal for closing ticket --%>
    <div class="modal fade" id="closeTicket" tabindex="-1" aria-labelledby="closeTicketLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="closeTicketLabel">Close Ticket</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="ticketIdLabel" runat="server" Text="Ticket ID: "></asp:Label>
                    <asp:Label ID="ticketIdValue" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="solutionLabel" runat="server" Text="Solution: "></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button3" runat="server" CommandName="CloseTicket" Text="Close Ticket" CssClass="btn btn-success" OnClick="Button3_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
