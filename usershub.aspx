<%@ Page Language="C#" AutoEventWireup="true" CodeFile="usershub.aspx.cs" Inherits="usershub" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form runat="server" id="formBooks">
     <div>Your login was successful</div>
    <h3>Our Books</h3>
        <div>
             <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound">
            <LayoutTemplate>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="15px"></th>
                        <th width="20%">Book Name</th>
                        <th width="20%">Book author</th>
                        <th width="20%">Category</th>
                        <th width="20%">Language</th>
                        <th>Lent</th>
                    </tr>
                </table>
                <div runat="server" id="itemPlaceHolder"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="SUBDIV" runat="server">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="15px">
                                <div class="btncolexp collapse">
                                    &nbsp;
                                </div>
                            </td>
                            <td width="20%"><%#Eval("BookName") %></td>
                            <td width="20%"><%#Eval("Author") %></td>
                            <td width="20%"><%#Eval("IDCategory") %></td>
                            <td width="20%"><%#Eval("IDLanguage") %></td>
                            <td><%#Eval("Lent") %></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <div style="margin:20px">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Image">
                                                <ItemTemplate>
                                                    <asp:Image ID="Image1" runat="server" Height="300px" Width="265px"
                                                        ImageUrl='<%#"data:Image/png;base64," + Convert.ToBase64String((byte[])Eval("Image")) %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Description" DataField="Description" />
                                            <asp:BoundField HeaderText="ISBN" DataField="ISBN" />
                                            <asp:BoundField HeaderText="Publisher" DataField="Publisher" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </ItemTemplate>
        </asp:ListView>
            <asp:SqlDataSource ID="BooksSqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReBooksDBConnectionString %>" ProviderName="<%$ ConnectionStrings:ReBooksDBConnectionString.ProviderName %>" SelectCommand="SELECT BookCategory.CategoryName, BookLanguage.LanguageName, Books.ID, Books.BookName, Books.Author, Books.Lent, BooksDetails.Image, BooksDetails.Description, BooksDetails.ISBN, BooksDetails.Publisher FROM BookCategory INNER JOIN BookLanguage ON BookCategory.ID = BookLanguage.ID INNER JOIN Books ON BookCategory.ID = Books.IDCategory AND BookLanguage.ID = Books.IDLanguage INNER JOIN BooksDetails ON Books.ID = BooksDetails.ID"></asp:SqlDataSource>
    </div>   
    </form>
    <script>
        $(document).ready(function () {
            // THIS IS FOR HIDE ALL DETAILS ROW
            $(".SUBDIV table tr:not(:first-child)").not("tr tr").hide();
            $(".SUBDIV .btncolexp").click(function () {
                $(this).closest('tr').next('tr').toggle();
                //this is for change img of btncolexp button
                if ($(this).attr('class').toString() == "btncolexp collapse") {
                    $(this).addClass('expand');
                }
                else {
                    $(this).removeClass('expand');
                    $(this).addClass('collapse');
                }
            });
        });
    </script>
</asp:Content>
