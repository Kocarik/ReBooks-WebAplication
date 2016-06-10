<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <div>
            <div class="welcomeTitle">WELCOME TO OUR WORLD ONLINE BOOK LIBRARY</div>
            <div class="welcomeSubtitle">Find your book and make reservation online</div>
            <div class="download"><a href="ReBooks - Installer.zip" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-download-alt"></span> DOWNLOAD INSTALLER</a></div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" OnPagePropertiesChanging="OnPagePropertiesChanging">
                <LayoutTemplate>
                    <table class="listOfBook">
                        <tr class="listOfBookHeaderTable">
                            <th>ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th class="bookCategoryandLang">Category</th>
                            <th class="bookCategoryandLang">Language</th>
                            <th>Status</th>
                            <th>View</th>
                        </tr>
                        <tbody>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                        </tbody>
                        <tr>
                            <td colspan="7" class="paging">
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
                        <td class="bookCategoryandLang"><%# Eval("CategoryName")%></td>
                        <td class="bookCategoryandLang"><%# Eval("LanguageName")%></td>
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
