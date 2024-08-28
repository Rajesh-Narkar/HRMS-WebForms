<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="TestWebApplication1.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .centered-form {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        form {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 20px 0px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 400px;
            width: 100%;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 20px;
            padding: 10px 20px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-outline-dark {
            border-color: #343a40;
            color: #343a40;
            border-radius: 20px;
            padding: 10px 20px;
        }
        .btn-outline-dark:hover {
            background-color: #343a40;
            color: #fff;
        }
        .modal-header {
            border-bottom: none;
        }
        .modal-title {
            color: #007bff;
            font-weight: bold;
        }
        .modal-body {
            color: #333;
        }
        .modal-content {
            border-radius: 20px;
            box-shadow: 0px 0px 20px 0px rgba(0, 0, 0, 0.1);
        }
    </style>
    <title></title>
</head>
<body>
    <div class="container centered-form">
        <form runat="server">
            <h1 class="text-center">Login Form</h1>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" Text="Email address" for="exampleInputEmail1"></asp:Label><br />
                <asp:TextBox ID="TextBox1" runat="server" aria-describedby="emailHelp" placeholder="Enter email" Width="100%" CssClass="form-control"></asp:TextBox>
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" Text="Password" for="exampleInputPassword1"></asp:Label><br />
                <asp:TextBox ID="TextBox2" runat="server" placeholder="Password" Width="100%" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:Button ID="Button1" runat="server" Text="Login" class="btn btn-primary w-100 mt-3" OnClick="Button1_Click" />
            <a href="#" data-toggle="modal" style="text-align: center; display: block; margin: auto; margin-top:10px" id="exampleModalLabel" data-target="#joiningFormModal" runat="server">Joining Form</a>
           
            <!-- Joining Form Modal -->
            <div class="modal fade" id="joiningFormModal" tabindex="-1" aria-labelledby="joiningFormModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Joining Form</h1>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
                                <div class="mb-3">
                                    <label for="TextBox8" class="form-label">Employee Code</label>
                                    <asp:TextBox ID="TextBox8" runat="server" placeholder="Enter Employee Code" Height="45px" Width="100%" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="TextBox3" class="form-label">Name</label>
                                    <asp:TextBox ID="TextBox3" runat="server" placeholder="Enter Name" Height="45px" Width="100%" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="TextBox4" class="form-label">Email address</label>
                                    <asp:TextBox ID="TextBox4" runat="server" placeholder="Enter Email Address" Height="45px" Width="100%" CssClass="form-control"></asp:TextBox>
                                 <a href="#" data-toggle="modal" style="display: block; margin: auto; margin-top:10px" id="A1" data-target="#otpModal" runat="server">Verify Email</a>
           
                                </div>
                                <div class="mb-3">
                                    <label for="TextBox6" class="form-label">Contact No</label>
                                    <asp:TextBox ID="TextBox6" runat="server" placeholder="Enter Contact No" Height="45px" Width="100%" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="TextBox7" class="form-label">Joining Date</label>
                                    <asp:TextBox ID="TextBox7" TextMode="Date" runat="server" placeholder="Enter Joining Date" Height="45px" Width="100%" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="TextBox5" class="form-label">Password</label>
                                    <asp:TextBox ID="TextBox5" runat="server" placeholder="Enter Password" Height="45px" Width="100%" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:Button ID="Button2" runat="server" Text="Submit" class="btn btn-outline-dark w-100 mt-3" OnClick="Button2_Click" />
                               
</ContentTemplate>
</asp:UpdatePanel>
                          
                        </div>
                    </div>
                </div>
            </div>

            <!-- OTP Modal -->
            <div class="modal fade" id="otpModal" tabindex="-1" aria-labelledby="otpModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">OTP Verification</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                           
                                    <div class="mb-3">
                                        <asp:Label ID="otpLabel" runat="server" Text="Enter your email address to receive OTP"></asp:Label>
                                        <asp:TextBox ID="otpEmailTextBox" runat="server" placeholder="Enter email" CssClass="form-control"></asp:TextBox>
                                        <asp:Button ID="sendOtpButton" runat="server" Text="Send OTP" CssClass="btn btn-primary w-100 mt-3" OnClick="SendOtpButton_Click" />
                                    </div>
                                    <div class="mb-3">
                                        <asp:Label ID="otpLabel1" runat="server" Text="Enter OTP"></asp:Label>
                                        <asp:TextBox ID="otpTextBox" runat="server" placeholder="Enter OTP" CssClass="form-control"></asp:TextBox>
                                        <asp:Button ID="verifyOtpButton" runat="server" Text="Verify OTP" CssClass="btn btn-primary w-100 mt-3" OnClick="VerifyOtpButton_Click" />
                                    </div>
                                    
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <%--<script>
        // Show joining form modal after OTP verification
        function showJoiningFormModal() {
            $('#otpModal').modal('hide');
            $('#joiningFormModal').modal('show');
        }
    </script>--%>
</body>
</html>
