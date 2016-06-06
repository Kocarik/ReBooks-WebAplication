<%@ Page Language="C#" AutoEventWireup="true" CodeFile="usershub.aspx.cs" Inherits="usershub" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form runat="server" id="formBooks">
        <div>
            Your login was successful
         <asp:Label ID="lblUserID" runat="server" Text="User ID"></asp:Label>
            <asp:Label ID="lblBookID" runat="server" Text="Book ID 0"></asp:Label>
        </div>
        <h3>Our Books</h3>
        <div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" OnSelectedIndexChanging="ListView1_SelectedIndexChanging" OnItemCommand="ListView1_ItemCommand">

                <LayoutTemplate>
                    <table style="border: solid 2px #336699;" cellspacing="0" cellpadding="3" rules="all">
                        <tr style="background-color: #336699; color: White;">
                            <th>Select</th>
                            <th>Book ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Categpry</th>
                            <th>Language</th>
                            <th>Status</th>
                            <th>Reserve</th>
                            <th>View</th>
                        </tr>
                        <tbody>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                        </tbody>
                    </table>
                </LayoutTemplate>

                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server" />
                        </td>
                        <td><%# Eval("ID")%></td>
                        <td><%# Eval("BookName")%></td>
                        <td><%# Eval("Author")%></td>
                        <td><%# Eval("CategoryName")%></td>
                        <td><%# Eval("LanguageName")%></td>
                        <td><%# Eval("Borrowings")%></td>                    
                        <td><asp:Button ID="viewBook" runat="server" Text="Button" /></td>
                        <td>
                            <asp:LinkButton ID="NameLabel" runat="server" Text='View More Details' CommandArgument='<%# Eval("ID")%>' OnClick="NameLabel_Click"/> 
                        </td>
                    </tr>
                </ItemTemplate>

                <SelectedItemTemplate>
                    <tr style="background-color: #336699; color: White;">
                        <td>
                            <asp:LinkButton ID="lnkSelect" Text="Select" CommandName="Select" runat="server"
                                ForeColor="White" />
                        </td>
                        <td><%# Eval("ID")%></td>
                        <td><%# Eval("BookName")%></td>
                        <td><%# Eval("Author")%></td>
                        <td><%# Eval("CategoryName")%></td>
                        <td><%# Eval("LanguageName")%></td>
                        <td><%# Eval("Borrowings")%></td>
                        <td><asp:Button ID="Button1" runat="server" Text="Button" /></td>
                        <td></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </form>
    <script>

    </script>
</asp:Content>
