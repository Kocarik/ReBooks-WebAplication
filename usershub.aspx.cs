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
    protected void Page_Load(object sender, EventArgs e)
    {
        lblUserID.Text = (string)Session["FirstName"];

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



    protected void ListView1_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
    {
        ListView1.SelectedIndex = e.NewSelectedIndex;
        string bookID = ListView1.SelectedDataKey.Value.ToString();

        lblBookID.Text = "Selected Book ID: " + bookID;

        BindData();
    }
}