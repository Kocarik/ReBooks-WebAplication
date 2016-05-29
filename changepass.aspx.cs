using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class changepass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["Verified"] == null)
        {
            Response.Redirect("login.aspx");
        }
    }

    [WebMethod]
    public static string UpdatePassword(string newPass)
    {
        QueryHandler query = new QueryHandler();
        string response = query.UpdatePassword(newPass);
        return response;
    }
}