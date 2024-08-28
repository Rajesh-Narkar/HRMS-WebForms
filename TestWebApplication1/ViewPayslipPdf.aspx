<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPayslipPdf.aspx.cs" Inherits="TestWebApplication1.ViewPayslipPdf" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View PDF</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <iframe src="<%= PdfUrl %>" width="100%" height="1000px"></iframe>
        </div>
    </form>
</body>
</html>
