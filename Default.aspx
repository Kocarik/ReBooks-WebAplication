<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" OnSelectedIndexChanging="ListView1_SelectedIndexChanging">
                <LayoutTemplate>
                    <table style="border: solid 2px #336699;" cellspacing="0" cellpadding="3" rules="all">
                        <tr style="background-color: #336699; color: White;">
                            <th>ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Book Category</th>
                            <th>Book Language</th>
                            <th>Status</th>
                            <th>View</th>
                        </tr>
                        <tbody>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                        </tbody>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("ID")%></td>
                        <td><%# Eval("BookName")%></td>
                        <td><%# Eval("Author")%></td>
                        <td><%# Eval("CategoryName")%></td>
                        <td><%# Eval("LanguageName")%></td>
                        <td><%# Eval("Borrowings")%></td>
                        <td>
                            <asp:LinkButton ID="ViewMoreInfo" runat="server" Text='View More Details' CommandArgument='<%# Eval("ID")%>' OnClick="ViewMoreInfo_Click" />
                        </td>
                    </tr>
                </ItemTemplate>

                <SelectedItemTemplate>
                    <tr style="background-color: #336699; color: White;">
                        <td><%# Eval("ID")%></td>
                        <td><%# Eval("BookName")%></td>
                        <td><%# Eval("Author")%></td>
                        <td><%# Eval("CategoryName")%></td>
                        <td><%# Eval("LanguageName")%></td>
                        <td><%# Eval("Borrowings")%></td>
                        <td>
                            <asp:LinkButton ID="ViewMoreInfo" runat="server" Text='View More Details' CommandArgument='<%# Eval("ID")%>' OnClick="ViewMoreInfo_Click" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </form>

</asp:Content>
