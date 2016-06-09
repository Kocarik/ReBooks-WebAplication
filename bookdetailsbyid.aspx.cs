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
    string userID;
    string bookID;

    protected void Page_Load(object sender, EventArgs e)
    {
        bookID = Session["bookID"].ToString();

        if (Session["userID"].ToString() == "" || Session["LoggedIn"].ToString() == "")
        {
            btnReserve.Visible = false;
            lblReserveStatus.Visible = false;
        }

        else
        {
            Session["LoggedIn"] = "true";
            userID = Session["userID"].ToString();
            btnReserve.Visible = true;
            lblReserveStatus.Visible = false;
            linkBtnSignUp.Visible = false;
            linkBtnSinIn.Visible = false;
            reserveComing.Visible = false;
        }

        Label1.Text = "User ID: " + userID;
        Label2.Text = "Book ID: " + bookID;
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
            lblReserveStatus.Visible = true;
            lblReserveStatus.Text = "Reservation sucesfull!";
        }

        else
        {
            lblReserveStatus.Visible = true;
            lblReserveStatus.Text = "Reservation unsucesfull! Oops.";
        }
    }

    protected void btnBackToList_Click(object sender, EventArgs e)
    {
        if(Session["LoggedIn"].ToString() == "")
        {
            Session["userID"] = "";
        }

        else if (Session["LoggedIn"].ToString() == "true")
        {
            Session["userID"] = userID;
        }

        Response.Redirect("usershub.aspx");
    }

    protected void linkBtnSignUp_Click(object sender, EventArgs e)
    {
        if (Session["LoggedIn"].ToString() == "")
        {
            Response.Redirect("signup.aspx");
        }
    }

    protected void linkBtnSinIn_Click(object sender, EventArgs e)
    {
        if (Session["LoggedIn"].ToString() == "")
        {
            Response.Redirect("login.aspx");
        }
    }
}