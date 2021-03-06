﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="usershub.aspx.cs" Inherits="usershub" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server" id="formBooks">
        <h3>OUR BOOKS</h3>
        <div>
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
                        <td class="bookCategoryandLang"><%# Eval("CategoryName")%></td>
                        <td class="bookCategoryandLang"><%# Eval("LanguageName")%></td>
                        <td><%# Eval("Borrowings")%></td>                    
                        <td>
                            <asp:LinkButton ID="NameLabel" runat="server" Text='View More Details' CommandArgument='<%# Eval("ID")%>' OnClick="NameLabel_Click"/> 
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </form>
    <script>

    </script>
</asp:Content>
