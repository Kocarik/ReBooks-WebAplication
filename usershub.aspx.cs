using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usershub : System.Web.UI.Page
{
    string userID;
    string statusLogin;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userID"].ToString() == "" && Session["LoggedIn"].ToString() == "")
        {

        }

        else
        {
            Session["userID"].ToString();
            Session["LoggedIn"] = "true";
            userID = Session["userID"].ToString();
        }

        if (!IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["myDatabaseConnectionString"].ConnectionString;
        string query = "SELECT *,CategoryName,LanguageName From Books INNER JOIN BookCategory ON Books.IDCategory = BookCategory.ID INNER JOIN BookLanguage ON Books.IDLanguage = BookLanguage.ID";

        MySqlDataAdapter data = new MySqlDataAdapter(query, connectionString);
        System.Data.DataTable table = new System.Data.DataTable();

        data.Fill(table);

        ListView1.DataSource = table;
        ListView1.DataBind();
    }

    protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        (ListView1.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        this.BindData();
    }

    //Use session
    protected void NameLabel_Click(object sender, EventArgs e)
    {
        if (Session["LoggedIn"].ToString() == "")
        {
            Session["userID"] = "";
            var link = sender as LinkButton;
            Session["bookID"] = link.CommandArgument;
            Response.Redirect("bookdetailsbyid.aspx?");

        }

        else if (Session["LoggedIn"].ToString() == "true")
        {
            Session["userID"] = userID;
            var link = sender as LinkButton;
            Session["bookID"] = link.CommandArgument;
            Response.Redirect("bookdetailsbyid.aspx?");

        }

        //var link = sender as LinkButton;
        //Session["userID"] = userID;
        //Session["bookID"] = link.CommandArgument;
        //Response.Redirect("bookdetailsbyid.aspx?");
    }
}