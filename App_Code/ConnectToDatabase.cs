using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ConnectToDatabase
/// </summary>
public class ConnectToDatabase
{
    public MySqlConnection connection;

    // defaul constructor
    public ConnectToDatabase()
    { 
        string connectionString = ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        connection = new MySqlConnection(connectionString);
    }

    /// <summary>
    /// return open connection to DB
    /// </summary>
    /// <returns></returns>
    public bool openConnection()
    {
        try
        {
            connection.Open();
            return true;
        }
        catch (MySqlException ex)
        {
            Console.Write(ex.ToString());
            return false;
        }
    }

    /// <summary>
    /// close DB connection
    /// </summary>
    /// <returns></returns>
    public bool closeConnection()
    {
        try
        {
            connection.Close();
            return true;
        }
        catch (MySqlException ex)
        {
            Console.Write(ex.ToString());
            return false;
        }
    }

    /// <summary>
    /// reserve book by User
    /// </summary>
    /// <param name="bookID"></param>
    /// <param name="userID"></param>
    /// <returns></returns>
    public bool reserveBook(string bookID, string userID)
    {
        if (openConnection())
        {
            string sqlQuery = "insert into ReservedBooks (IDBook, IDUser) values (@IDBook, @IDUser)";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@IDBook", bookID);
            cmd.Parameters.AddWithValue("@IDUser", userID);
            cmd.ExecuteNonQuery();

            sqlQuery = "update Books set Borrowings = @borrowings where ID = " + bookID;
            cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@borrowings", "reserved");
            cmd.ExecuteNonQuery();

            closeConnection();
            return true;
        }
        return false;
    }

    /// <summary>
    ///  find details about book according its name
    /// </summary>
    /// <param name="bookID"></param>
    /// <returns></returns>
    public List<string> bookDetails(string bookID)
    {
        List<string> bookDetail = new List<string>();
        if (openConnection())
        {
            string sqlQuery = "select * from Books inner join BooksDetails on Books.ID = BooksDetails.ID where Books.ID like '" + bookID + "'";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                bookDetail.Add(reader["ID"] + "");
                bookDetail.Add(reader["BookName"] + "");
                bookDetail.Add(reader["Author"] + "");
                bookDetail.Add(reader["Borrowings"].ToString());
                bookDetail.Add(reader["IDCategory"] + "");
                bookDetail.Add(reader["IDLanguage"] + "");
                bookDetail.Add(reader["Description"] + "");
                bookDetail.Add(reader["ISBN"] + "");
                bookDetail.Add(reader["Publisher"] + "");
            }
            closeConnection();
            return bookDetail;
        }
        return bookDetail;
    }

    /// <summary>
    ///  find book language according its id
    /// </summary>
    /// <param name="languageID"></param>
    /// <returns></returns>
    public string bookLanguage(string languageID)
    {
        string bookLanguage = null;
        if (openConnection())
        {
            string sqlQuery = "select LanguageName from BookLanguage where ID like " + languageID;
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                bookLanguage = reader["LanguageName"] + "";
            }
            closeConnection();
        }
        return bookLanguage;
    }

    /// <summary>
    /// find book category according its id
    /// </summary>
    /// <param name="categoryID"></param>
    /// <returns></returns>
    public string bookCategory(string categoryID)
    {
        string bookCategory = null;
        if (openConnection())
        {
            string sqlQuery = "select CategoryName from BookCategory where ID like " + categoryID;
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                bookCategory = reader["CategoryName"] + "";
            }
            closeConnection();
        }
        return bookCategory;
    }

    public bool VerifyUser(string email, string password)
    {
        if (openConnection())
        {
            string sqlQuery = "select email,password from UsersLogin where email like '" + email + "' and password like '" + password + "' ";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                if (reader["email"] + "" == email && reader["password"] + "" == password)
                {
                    closeConnection();
                    return true;
                }
            }

        }

        closeConnection();
        return false;
    }

    }