<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <div class="welcomeTitle">WELCOME TO OUR WORLD ONLINE BOOK LIBRARY</div>
            <div class="welcomeSubtitle">Find your book and make reservation online</div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" OnPagePropertiesChanging="OnPagePropertiesChanging">
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
                        <tr>
                            <td colspan="7" style="text-align:center">
                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListView1" PageSize="10">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                            ShowNextPageButton="false" />
                                        <asp:NumericPagerField ButtonType="Link" />
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton="false" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
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
            </asp:ListView>
        </div>
    </form>

</asp:Content>
