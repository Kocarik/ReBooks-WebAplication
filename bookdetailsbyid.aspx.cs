using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookdetailsbyid : System.Web.UI.Page
{
    QueryHandler db = new QueryHandler();
    ConnectToDatabase dbcon = new ConnectToDatabase();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userID"] == "" || Session["userID"] == null)
        {
            btnReserve.Visible = false;
        }

        else if(Session["userID"] != "" || Session["userID"] != null)
        {
            btnReserve.Visible = true;
        }

        Session["LoggedIn"] = "true";
        string bookID = Session["bookID"].ToString();
        string userID = Session["userID"].ToString();
        string bookName, author, lent, categoryID, languageID, desc, publisher, category, language, loan;
        string[] descrpition;

        List<string> bookDetails = new List<string>();
        bookDetails = dbcon.bookDetails(bookID);
        if (bookDetails.Capacity > 0)
        {
            bookID = bookDetails.ElementAt(0);
            bookName = "Book's name: " + bookDetails.ElementAt(1);
            author = "Author: " + bookDetails.ElementAt(2);
            lent = "Status: " + bookDetails.ElementAt(3);
            loan = bookDetails.ElementAt(3);
            categoryID = bookDetails.ElementAt(4);
            languageID = bookDetails.ElementAt(5);
            desc = bookDetails.ElementAt(6);
            publisher = "Publisher :" + bookDetails.ElementAt(7);

            language = "Language: " + dbcon.bookLanguage(languageID);
            category = "Category: " + dbcon.bookCategory(categoryID);

            descrpition = desc.Split('.');
            desc = "";

            BookName.Text = bookName;
            Author.Text = author;
            Publisher.Text = publisher;
            Category.Text = category;
            Language.Text = language;
            Lent.Text = lent;
            for (int i = 0; i < descrpition.Length; i++)
            {
                desc = desc + descrpition[i];
            }
            Console.WriteLine(desc);
            txtAreaDescription.InnerText = "Description: " + desc;

        }

        string strBase64 = Convert.ToBase64String(db.getImageBook(bookID));
        Image1.ImageUrl = "data:Image/png;base64," + strBase64;

    }

    protected void btnReserve_Click(object sender, EventArgs e)
    {
        string bookID = Session["bookID"].ToString();
        string userID = Session["userID"].ToString();

        if (dbcon.reserveBook(bookID, userID))
        {
            lblReserve.Text = "Reservation sucesfull";
        }

        else
        {
            lblReserve.Text = "Reservation unsucesfull";
        }
    }
}