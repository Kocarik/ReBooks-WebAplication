<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bookdetailsbyid.aspx.cs" Inherits="bookdetailsbyid" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="bookDetails" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <div class="col-sm-6">
            <div id="breadcumbs">
                <asp:LinkButton ID="btnBackToList" runat="server" OnClick="btnBackToList_Click"><<< Back to list of books</asp:LinkButton>
            </div>
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
                <textarea runat="server" cols="60" rows="4" id="txtAreaDescription" class="txtAreaBookDescription" readonly="readonly"></textarea>
            </div>
            <div>
                <asp:Button ID="btnReserve" runat="server" Text="Reserve" OnClick="btnReserve_Click" />
            </div>
            <div>
                <asp:Button ID="btnDeleteReservation" runat="server" Text="Delete Reservation" OnClick="btnDeleteReservation_Click" />
            </div>
            <div id="reserveStatus">
                <asp:Label ID="lblReserveStatus" runat="server" Text="Reserve status after click button"></asp:Label>
            </div>
            <div id="reserveComing" runat="server">
                Only Registered Users can Reserve a Book <asp:LinkButton ID="linkBtnSignUp" runat="server" OnClick="linkBtnSignUp_Click">Sign Up</asp:LinkButton> or <asp:LinkButton ID="linkBtnSinIn" runat="server" OnClick="linkBtnSinIn_Click">Sign In.</asp:LinkButton>
            </div>
        </div>
    </form>
    <script>
        $("textarea").height($("textarea")[0].scrollHeight);
    </script>
</asp:Content>
