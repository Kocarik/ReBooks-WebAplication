<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepass.aspx.cs" Inherits="changepass" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <fieldset>
        <div class="well-lg" style="text-align: center; font-size: 30px; color: red">
            Password Reset
        </div>
        <div class="well-lg" style="text-align: center;">
            <div class="control-group">
                <!-- Email -->
                <label class="control-label" for="New_Password">New Password</label>
                <div class="controls">
                    <input type="password" id="txtNewPass" class="input-xlarge fullname" />
                    <p class="help-block">Please enter your new Password</p>
                </div>
            </div>

            <div class="control-group">
                <!-- E-mail -->
                <label class="control-label" for="Confirm_Password">Confirm-Password</label>
                <div class="controls">
                    <input type="password" id="txtNewPassConfirm" class="input-xlarge" />
                    <p class="help-block">Please confirm the password</p>
                </div>
            </div>
            <input type="button" id="btnSaveNewPassword" value= "Update Password" /><br />
            <label class="resetNewPasswordError" style="font-size: 13px; color: red;"></label>
        </div>
    </fieldset>
    <script>
        $(".generalNavBar").css("display", "none");
        $("#btnSaveNewPassword").click(function () {
            if ($("#txtNewPass").val() != $("#txtNewPassConfirm").val() || $("#txtNewPassConfirm").val() == '' || $("#txtNewPass").val() == '') {
                $(".resetNewPasswordError").html("Either password did not match or you are playing with the empty password")
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "changepass.aspx/UpdatePassword",
                    contentType: "application/json; charset=utf-8",
                    data: '{"newPass":"' + $("#txtNewPass").val() + '"}',
                    dataType: "json",
                    success: function (data) {
                        $("#divForgotPassword").css("display", "none");
                        alert("You password is updated. Try log in")
                        window.location.replace("login.aspx");
                    },
                    error: function (data) {
                        alert("Server is too busy at the moment.");
                    }
                });
            }
        });
    </script>
</asp:Content>
