using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookdetailsbyid : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string bookID = Session["bookID"].ToString();
        string userID = Session["userID"].ToString();
        lblBookID.Text = "Book ID: "+bookID;
        lblUserID.Text = "User ID: " + userID;

        QueryHandler db = new QueryHandler();
        lblBookPubliser.Text = db.getPublisher(bookID);

        string strBase64 = Convert.ToBase64String(db.getImageBook(bookID));

        Image1.ImageUrl = "data:Image/png;base64," + strBase64;

    }

    protected void btnReserve_Click(object sender, EventArgs e)
    {

    }
}