<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bookdetailsbyid.aspx.cs" Inherits="bookdetailsbyid" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
    </head>
    <body>
        <form id="form1" runat="server">
            <div>
                <asp:Label ID="lblUserID" runat="server" Text="User ID"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblBookID" runat="server" Text="Book ID"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblBookPubliser" runat="server" Text="Book Publisher"></asp:Label>
            </div>
             <div>
                 <asp:Image ID="Image1" runat="server" Width="328px" Height="375px" />
            </div>
            <div>
                <asp:Button ID="btnReserve" runat="server" Text="Reserve" OnClick="btnReserve_Click" />
            </div>
        </form>
    </body>
    </html>

</asp:Content>
