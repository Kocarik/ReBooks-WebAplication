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

    /// <summary>
    /// verify user in login
    /// </summary>
    /// <param name="email"></param>
    /// <param name="password"></param>
    /// <returns></returns>
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

    /// <summary>
    /// after users registration, his data will be saved to database, and admin must confirm, or refuse his request
    /// </summary>
    /// <param name="firstName"></param>
    /// <param name="lastName"></param>
    /// <param name="email"></param>
    /// <param name="password"></param>
    /// <param name="telephone"></param>
    /// <param name="birthDate"></param>
    /// <param name="street"></param>
    /// <param name="streetNumber"></param>
    /// <param name="city"></param>
    /// <param name="postalCode"></param>
    /// <param name="country"></param>
    /// <param name="image"></param>
    /// <param name="code"></param>
    /// <returns></returns>
    public bool writeUserAsInactive(string firstName, string lastName, string email, string password, string telephone, string birthDate, string street, int streetNumber, string city, string postalCode, string country, byte[] image, string code)
    {
        if (openConnection())
        {

            string sqlQuery = "insert into Users (FirstName, LastName, BirthDate, Avatar, ResetPasswordCode) "
                + "values (@firstName, @lastName, @birthDate, @Avatar, @ResetPasswordCode)";

            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@firstName", firstName);
            cmd.Parameters.AddWithValue("@lastName", lastName);
            cmd.Parameters.AddWithValue("@birthDate", birthDate);
            cmd.Parameters.AddWithValue("@ResetPasswordCode", code);
            cmd.Parameters.AddWithValue("@Avatar", image);
            cmd.ExecuteNonQuery();

            sqlQuery = "insert into UsersLogin (email, password, Active) "
                + "values (@email, @password, @active)";
            cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@password", password);
            cmd.Parameters.AddWithValue("@active", "waiting");
            cmd.ExecuteNonQuery();

            sqlQuery = "insert into UsersDetails (Street, StreetNumber, PostalCode, City, Telephone, Country) "
                + "values (@street, @streetnumber, @postalcode, @city, @telephone, @country)";
            cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@street", street);
            cmd.Parameters.AddWithValue("@streetnumber", streetNumber);
            cmd.Parameters.AddWithValue("@postalcode", postalCode);
            cmd.Parameters.AddWithValue("@city", city);
            cmd.Parameters.AddWithValue("@telephone", telephone);
            cmd.Parameters.AddWithValue("@country", country);

            cmd.ExecuteNonQuery();
            closeConnection();
            return false;
        }
        else
        {
            return true;
        }
    }


    /// <summary>
    /// get field of image
    /// </summary>
    /// <returns></returns>
    public byte[] getDefaultImage()
    {
        byte[] image = null;
        if (openConnection())
        {
            string sqlQuery = "select Image from DefaultUserImage";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                image = (byte[])reader["Image"];
            }
            closeConnection();
            return image;
        }
        return image;
    }

    /// <summary>
    /// get password code, for verification, if generated password code is taken
    /// </summary>
    /// <param name="code"></param>
    /// <returns></returns>
    public bool isCodeTaken(string code)
    {
        if (openConnection())
        {
            string sqlQuery = "select ResetPasswordCode from Users";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                if (code.Equals(reader["ResetPasswordCode"].ToString()))
                {
                    closeConnection();
                    return true;
                }
            }
            closeConnection();
        }
        return false;
    }

    /// <summary>
    /// verify is user waiting return true, and loginform show error user
    /// </summary>
    /// <param name="email"></param>
    /// <param name="password"></param>
    /// <returns></returns>
    public bool ifUserWaiting(string email, string password)
    {
        if (openConnection())
        {
            string status = "waiting";

            string sqlQuery = "select email, password, active from UsersLogin where email like '" + email + "' and password like '" + password + "' and active like '" + status + "' ";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            MySqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                if (reader["email"] + "" == email && reader["password"] + "" == password && reader["active"] + "" == status)
                {
                    closeConnection();
                    return true;
                }
            }

        }

        closeConnection();
        return false;
    }


    /// <summary>
    ///  delete reservation of book
    /// </summary>
    /// <param name="bookID"></param>
    /// <param name="userID"></param>
    /// <returns></returns>
    public bool deleteReservation(string bookID, string userID)
    {
        if (openConnection())
        {
            string sqlQuery = "delete from ReservedBooks where IDBook = @IDBook and IDUser = @IDUser";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@IDBook", bookID);
            cmd.Parameters.AddWithValue("@IDUser", userID);
            cmd.ExecuteNonQuery();

            sqlQuery = "update Books set Borrowings = @borrowings where ID = " + bookID;
            cmd = new MySqlCommand(sqlQuery, connection);
            cmd.Parameters.AddWithValue("@borrowings", "free");
            cmd.ExecuteNonQuery();


            closeConnection();
            return true;
        }
        return false;
    }

}