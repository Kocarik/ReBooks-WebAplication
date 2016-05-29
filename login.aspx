<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" MasterPageFile="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form runat="server">
        <div class="row" style="height: 80px; margin-top: 6%">
        </div>
        <div class="clearfix"></div>
        <div class="row middle-row" style="border-radius:10px;" >
            <div class="col-sm-2"></div>
            <div class="col-sm-8 Email-holder" style="text-align: center; background-color:#0D031D;">
                <div id="Emailholder" style="position: relative; top: 40px">
                    <h3 style="display: block; vertical-align: central; color: Grey">Email</h3>
                    <input type="text" style="border-radius: 5px" id="txtEmail" runat="server" name="Email" tabindex="1" /><br />
                    <h3 style="display: block; vertical-align: central; color: Grey">Password</h3>
                    <input type="password" style="border-radius: 5px" id="txtPassword" runat="server" name="password" tabindex="2" /><br />
                    <br />
                    <asp:Button CssClass="btn universalButton" ID="btnProceed" runat="server" Text="Proceed" OnClick="btnProceed_Click" TabIndex="3" /><br />
                    <br />
                    <asp:Label ID="errorInfo" runat="server" ForeColor="Red"></asp:Label>
                </div>
                <br /><br />
                <div id="divForgotPassword" runat="server" style="display: none">
                    Forgot your password? <a id="lnForgotPassword">Reset it</a>
                    <div id="divReset">
                        <h3>Reset password by E-mail</h3>
                        <div>
                            <div id="divConfirmEmail" style="display:block">
                                <input type="email" style="border-radius: 5px" id="txtResetEmail" class="txtResetEmail" runat="server" />
                                <input type="button" id="btnSendCode" value="Send Code" /><br />
                            </div>
                            <div id="divConfirmCode" style="display: none; float:left">
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
        <div class="row" style="height: 80px"></div>
    </form>
    <script>
        $("#divReset").accordion({
            collapsible:true
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