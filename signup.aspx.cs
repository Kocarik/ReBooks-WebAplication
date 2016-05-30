using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_ServerClick(object sender, EventArgs e)
    {
        var r = new Regex(@"^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$");

        if (!r.IsMatch(email.Value))
        {
            errorMsg.InnerHtml = "Email not valid";
        }
        else
        {
            Session["Email"] = email.Value;
            QueryHandler query = new QueryHandler();
            Boolean userAlreadyExists = query.Signup(firstName.Value,lastName.Value, email.Value, password.Value, street.Value, streetNumber.Value, postalCode.Value, city.Value, telephone.Value, country.Value);
            if (userAlreadyExists)
            {
                errorMsg.InnerHtml = "You are already a member. Try resetting your password on Login page";
            }
            else
            {
                if (Request.QueryString["rurl"] != "appointee.aspx" && Request.QueryString["rurl"] == null)
                {

                    Session["FirstName"] = firstName.Value;
                    Session["LastName"] = lastName.Value;
                    Session["LoggedIn"] = "true";
                    Response.Redirect("usershub.aspx");
                }
                else
                {
                    Response.Redirect(Request.QueryString["rurl"] + "?cid=" + Session["CalId"] + "&sd=" + Session["StartDate"] + "&ed=" + Session["EndDate"] + "&name=" + Session["CalendarName"]);
                }
            }
        }
    }

}