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
        if (!IsPostBack)
        {
            populatedata();
        }
    }


    private void populatedata()
    {
        using (ReBooksDBEntities dc = new ReBooksDBEntities())
        {
            var v = dc.Books.ToList();
            ListView1.DataSource = v;
            ListView1.DataBind();
        }
    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if(e.Item.ItemType == ListViewItemType.DataItem)
        {
            ListViewDataItem lvItem = (ListViewDataItem)e.Item;
            Book book = (Book)lvItem.DataItem;
            if (book != null)
            {
                GridView gv1 = (GridView)e.Item.FindControl("GridView1");
                if(gv1 != null)
                {
                    using(ReBooksDBEntities dc = new ReBooksDBEntities())
                    {
                        var v = dc.BooksDetails.Where(a => a.ID.Equals(book.ID)).ToList();
                        gv1.DataSource = v;
                        gv1.DataBind();
                    }
                }

            }
        }
    }
}