<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form runat="server">
        <div class="row" style="">
        </div>
        <div class="clearfix"></div>
        <div class="row middle-row" style="border-radius: 10px;">
            <h1 style="text-align: center">SIGN IN FORM</h1>
            <div class="col-sm-2"></div>
            <div class="col-sm-8 Email-holder" style="text-align: center; background-color: #F3F3F3;">
                <div id="Emailholder" style="position: relative; top: 40px">
                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="txtEmail" type="email" class="form-control" name="Email" value="" runat="server" tabindex="1" placeholder="your email" />
                    </div>

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="txtPassword" type="password" class="form-control" name="password" runat="server" tabindex="2" placeholder="password" />
                    </div>


                    <asp:Button CssClass="btn universalButton" ID="btnProceed" runat="server" Text="LOGIN" OnClick="btnProceed_Click" TabIndex="3" BackColor="#3333FF" ForeColor="#CCFFFF" Width="99%" /><br />
                    <br />
                    <asp:Label ID="errorInfo" runat="server" ForeColor="Red"></asp:Label>
                </div>
                <br />
                <br />
                <div id="divForgotPassword" runat="server" style="display: none">
                    Forgot your password? <a id="lnForgotPassword">Reset it</a>
                    <div id="divReset">
                        <h3>Reset password by E-mail</h3>
                        <div>
                            <div id="divConfirmEmail" style="display: block">
                                <input type="email" style="border-radius: 5px" id="txtResetEmail" class="txtResetEmail" runat="server" />
                                <input type="button" id="btnSendCode" value="Send Code" /><br />
                            </div>
                            <div id="divConfirmCode" style="display: none; float: left">
                                <input type="text" style="border-radius: 5px" placeholder="Enter Code" id="txtConfirmCode" />
                                <input type="button" id="btnConfirmCode" value="Confirm Code" />
                                <input type="button" id="btnResendCode" value="Resend Code" /><br />
                            </div>
                            <label class="lblCodeError"></label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row"></div>
    </form>
    <script>
        $("#divReset").accordion({
            collapsible: true
        });

        $("#lnForgotPassword").click(function () {
            $("#divReset").css("display", "block");
            $(".txtResetEmail").val($("#txtEmail").val());
        });

        $("#btnSendCode").click(function () {
            if ($("#txtResetEmail").val() == "") {
                $(".lblCodeError").html("Please write proper email");
            } else {
                var email = $(".txtResetEmail").val();
                $("#divConfirmCode").css("display", "block");
                $("#divConfirmEmail").css("display", "none");

                $.ajax({
                    type: "POST",
                    url: "login.aspx/SendCodeInEmail",
                    contentType: "application/json; charset=utf-8",
                    data: '{"email":"' + email + '"}',
                    dataType: "json",
                    success: function (data) {
                        $(".lblCodeError").text(data.d);
                    },
                    error: function (data) {
                        alert("Server is too busy at the moment.");
                    }
                });
            }
        });

        $("#btnResendCode").click(function () {
            if ($("#txtConfirmCode").val() == "") {
                $(".lblCodeError").html("Please write the code you received");
            } else {
                var email = $(".txtResetEmail").val();
                $.ajax({
                    type: "POST",
                    url: "login.aspx/SendCodeInEmail",
                    contentType: "application/json; charset=utf-8",
                    data: '{"email":"' + email + '"}',
                    dataType: "json",
                    success: function (data) {
                        $(".lblCodeError").text(data.d);
                    },
                    error: function (data) {
                        alert("Server is too busy at the moment.");
                    }
                });
            }
        });

        $("#btnConfirmCode").click(function () {
            if ($("#txtResetEmail").val() == "") {
                $(".lblCodeError").html("Please write proper email");
            } else {
                var code = $("#txtConfirmCode").val();
                $.ajax({
                    type: "POST",
                    url: "login.aspx/ValidateResetCode",
                    contentType: "application/json; charset=utf-8",
                    data: '{"code":"' + code + '"}',
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "right") {
                            alert("Correct reset key. You should be able to enter your new password now.");
                            window.location.replace("changepass.aspx");
                        } else {
                            $(".lblCodeError").text("Incorrect reset key");
                        }
                    },
                    error: function (data) {
                        alert("Server is too busy at the moment.");
                    }
                });
            }
        });
    </script>
</asp:Content>
