<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server" class="form-horizontal" style="text-align: center">
        <fieldset>
            <div class="well-lg" style="text-align: center; font-size: 30px; color: red">
                Register
            </div>
            <div class="control-group">
                <!-- First name -->
                <label class="control-label" for="firstName">First Name</label>
                <div class="controls">
                    <input type="text" runat="server" id="firstName" class="input-xlarge firstName"/>
                    <p class="help-block">Please enter your first name</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Last name -->
                <label class="control-label" for="lastName">Last Name</label>
                <div class="controls">
                    <input type="text" runat="server" id="lastName" class="input-xlarge lastName"/>
                    <p class="help-block">Please enter your last name</p>
                </div>
            </div>

            <div class="control-group">
                <!-- E-mail -->
                <label class="control-label" for="email">E-mail</label>
                <div class="controls">
                    <input runat="server" type="email" id="email" name="email" class="input-xlarge email" />
                    <p class="help-block">Please provide your E-mail</p>
                </div>
            </div>

              <div class="control-group">
                <!-- Date of Birth -->
                <label class="control-label" for="dateOfBirth">Date of Birth</label>
                <div class="controls">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox><asp:ImageButton ID="btnImageCalendar" runat="server" Height="23px" ImageUrl="~/images/calendar.png" Width="27px" />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" PopupButtonID="btnImageCalendar" PopupPosition="BottomRight" TargetControlID="txtDateOfBirth" />
                    <p class="help-block">Please provide your date of birth</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Password-->
                <label class="control-label" for="password">Password</label>
                <div class="controls">
                    <input runat="server" type="password" id="password" name="password" class="input-xlarge password"/>
                    <p class="help-block">Password should be at least 4 characters</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Password Confirm -->
                <label class="control-label" for="password_confirm">Password (Confirm)</label>
                <div class="controls">
                    <input type="password" id="password_confirm" name="password_confirm" placeholder="" class="input-xlarge password_confirm"/>
                    <p class="help-block">Please confirm password</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Street (name) -->
                <label class="control-label" for="street">Street Name</label>
                <div class="controls">
                    <input type="text" runat="server" id="street" class="input-xlarge street"/>
                    <p class="help-block">Please enter your street name</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Street number -->
                <label class="control-label" for="streetNumber">Street Number</label>
                <div class="controls">
                    <input type="text" runat="server" id="streetNumber" class="input-xlarge streetNumber"/>
                    <p class="help-block">Please enter your street number</p>
                </div>
            </div>

            <div class="control-group">
                <!-- PostalCode -->
                <label class="control-label" for="postalCode">Postal Code</label>
                <div class="controls">
                    <input type="text" runat="server" id="postalCode" class="input-xlarge postalCode"/>
                    <p class="help-block">Please enter your postal code</p>
                </div>
            </div>

            <div class="control-group">
                <!-- City -->
                <label class="control-label" for="city">City</label>
                <div class="controls">
                    <input type="text" runat="server" id="city" class="input-xlarge city"/>
                    <p class="help-block">Please enter your city</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Telephone -->
                <label class="control-label" for="telephone">Telephone</label>
                <div class="controls">
                    <input type="text" runat="server" id="telephone" class="input-xlarge telephone"/>
                    <p class="help-block">Please enter your telephone number</p>
                </div>
            </div>

            <div class="control-group">
                <!-- Country -->
                <label class="control-label" for="streetNumber">Country</label>
                <div class="controls">
                    <input type="text" runat="server" id="country" class="input-xlarge contry"/>
                    <p class="help-block">Please enter your country</p>
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
            if ($(".firstName").val() == "" || $(".email").val() == "" || $("#lastName").val() == "" || $("#street").val() == "") {
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