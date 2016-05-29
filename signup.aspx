<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
    </style>
    <form runat="server" class="form-horizontal" style="text-align: center">
        <fieldset>
            <div class="well-lg" style="text-align: center; font-size: 30px; color: red">
                Register
            </div>
            <div class="control-group">
                <!-- Email -->
                <label class="control-label" for="Fullname">Fullname</label>
                <div class="controls">
                    <input type="text" runat="server" id="fullname" class="input-xlarge fullname">
                    <p class="help-block">Please enter your full name</p>
                </div>
            </div>

            <div class="control-group">
                <!-- E-mail -->
                <label class="control-label" for="email">E-mail</label>
                <div class="controls">
                    <input runat="server" type="email" id="email" name="email" class="input-xlarge email">
                    <p class="help-block">Please provide your E-mail</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Password-->
                <label class="control-label" for="password">Password</label>
                <div class="controls">
                    <input runat="server" type="password" id="password" name="password" class="input-xlarge password">
                    <p class="help-block">Password should be at least 4 characters</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Password -->
                <label class="control-label" for="password_confirm">Password (Confirm)</label>
                <div class="controls">
                    <input type="password" id="password_confirm" name="password_confirm" placeholder="" class="input-xlarge password_confirm">
                    <p class="help-block">Please confirm password</p>
                </div>
            </div>



            <div class="control-group">
                <!-- Password -->
                <label class="control-label" for="securityq">Enter a security question: </label>
                <div class="controls">
                    <input type="text" id="securityquestion" runat="server" placeholder="Enter your security question" class="input-xlarge" />
                </div>
            </div>
            <div class="control-group">
                <!-- Password -->
                <label class="control-label" for="securityans">Enter your answer here:</label>
                <div class="controls">
                    <input type="text" id="securityanswer" runat="server" placeholder="Enter your answer" class="input-xlarge" />
                </div>
            </div>
            <div class="control-group">
                <!-- Button -->
                <div class="controls">
                    <asp:Button runat="server" CssClass="btn universalButton btnRegister" ID="btnRegister" CausesValidation="true" OnClick="btnRegister_ServerClick" OnClientClick="return validateFields();" Text="Register" />
                </div>
            </div>
            <label id="errorMsg" class="errorMsg" style="color: red; font-weight: 800; font-size: 16px" runat="server"></label>
        </fieldset>

    </form>
    <script>
        function validateFields() {
            if ($(".fullname").val() == "" || $(".email").val() == "" || $("#securityquestion").val() == "" || $("#securityanswer").val() == "") {
                $(".errorMsg").html("Fill in all fileds");
                return false;
            }
            else if ($(".password_confirm").val() != $(".password").val()) {
                $(".errorMsg").html("Passwords dont match");
                return false;
            }
            else {
                $(".errorMsg").html("");
                return true;
            }

        }
    </script>
</asp:Content>