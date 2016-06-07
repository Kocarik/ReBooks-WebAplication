<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bookdetailsbyid.aspx.cs" Inherits="bookdetailsbyid" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <form id="bookDetails" runat="server">
            <div class="col-sm-6">
                <div id="breadcumbs"><a href="usershub.aspx"><<< Back to List of Books</a></div>
                <div>
                    <asp:Image ID="Image1" runat="server" Width="328px" Height="375px" />
                </div>
            </div>
            <div class="col-sm-6" id="singlebookDetails">
                <div>
                    <asp:Label ID="BookName" runat="server" Text="Book Name"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Author" runat="server" Text="Author"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Category" runat="server" Text="Book Publisher"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Language" runat="server" Text="Book Publisher"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="Publisher" runat="server" Text="Book Publisher"></asp:Label>
                </div>
                 <div>
                    <asp:Label ID="Lent" runat="server" Text="Book Publisher"></asp:Label>
                </div>
                  <div>
                      <textarea runat="server" cols="40" rows="4" id="txtAreaDescription" disabled="disabled" class="txtAreaBookDescription"></textarea>
                </div>
                <div>
                    <asp:Button ID="btnReserve" runat="server" Text="Reserve" OnClick="btnReserve_Click" />
                </div>
            </div>
            <div>
                <asp:Label ID="lblReserve" runat="server" Text="Reserve status after click button"></asp:Label>
            </div>
        </form>
    <script> 
        $('#txtAreaDescription').autogrow();
    </script>
</asp:Content>
