using System;
using System.Configuration;
using System.Linq;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Text;
using System.Web;

public class QueryHandler
{
    private string Email;

    public QueryHandler() { }
    public QueryHandler(String email)
    {
        this.Email = email;
    }

    //check if the user exists in the database
    #region
    public bool UserExists(string email)
    {
        //Open Sql Connection
        string connectionString = ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened");
        }

        //Wriute the code to check if the user exists in the database
        command.CommandText = String.Format("Select * from UsersLogin where Email = \'{0}\'", email);
        reader = command.ExecuteReader();
        reader.Read();
        if (reader.HasRows)
        {
            reader.Close();
            conn.Close();
            return true;
        }
        reader.Close();
        conn.Close();
        return false;

    }

  

    #endregion


    //Verifying user
    #region
    public bool VerifyUser(string email, string password)
    {
        //Open Sql Connection
        string connectionString = ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened");
        }

        //Write the code to check if the user exists in the database
        command.CommandText = String.Format("Select email,password from UsersLogin where Email = \'{0}\' and Password =\'{1}'", email, password);
        reader = command.ExecuteReader();
        reader.Read();
        if (reader.HasRows)
        {
            reader.Close();
            conn.Close();
            return true;
        }
        reader.Close();
        conn.Close();
        return false;
    }
    #endregion

    #region
    public string GetUserDetails(string email, string password)
    {
        string userDetails = null;

        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("Select Users.ID,Users.FirstName,Users.Lastname,Email,Password from Users inner join UsersLogin on Users.ID = UsersLogin.ID where Email = \'{0}\' and Password = \'{1}\'", email, password);
        reader = command.ExecuteReader();

        while (reader.Read())
        {
            userDetails = reader["id"].ToString() + reader["FirstName"].ToString() + reader["LastName"].ToString();
            return userDetails;
        }

        reader.Close();
        conn.Close();
        return userDetails;
    }
    #endregion

    #region
    public string SetResetPasswordCode()
    {
        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        string response;
        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            response = "Could not send email";
        }

        command.CommandText = String.Format("SET SQL_SAFE_UPDATES = 0");
        reader = command.ExecuteReader();
        reader.Close();
        response = RandomString(5, "0123456789");
        command.CommandText = String.Format("Update Users inner join UsersLogin set Users.ResetPasswordCode = \'{0}\' where UsersLogin.Email = \'{1}\'", response, HttpContext.Current.Session["Email"].ToString());
        reader = command.ExecuteReader();
        reader.Read();
        reader.Close();

        conn.Close();
        return response;
    }
    #endregion

    public bool ValidateResetCode(string code)
    {
        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("Select * from Users inner join UsersLogin where Users.ResetPasswordCode = \'{0}\' and UsersLogin.Email = \'{1}\'", code, HttpContext.Current.Session["Email"].ToString());
        reader = command.ExecuteReader();
        reader.Read();
        if (reader.HasRows)
        {
            reader.Close();
            conn.Close();
            return true;
        }
        reader.Close();
        conn.Close();
        return false;
    }

    //Get randomly generated string as a key for client and creator
    #region
    string RandomString(int length, string allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    {
        const int byteSize = 0x100;
        var allowedCharSet = new HashSet<char>(allowedChars).ToArray();

        using (var rng = new System.Security.Cryptography.RNGCryptoServiceProvider())
        {
            var result = new StringBuilder();
            var buf = new byte[128];
            while (result.Length < length)
            {
                rng.GetBytes(buf);
                for (var i = 0; i < buf.Length && result.Length < length; ++i)
                {
                    var outOfRangeStart = byteSize - (byteSize % allowedCharSet.Length);
                    if (outOfRangeStart <= buf[i]) continue;
                    result.Append(allowedCharSet[buf[i] % allowedCharSet.Length]);
                }
            }
            return result.ToString();
        }
    }
    #endregion
    /*public bool CheckAnswer(string answer)
    {
        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("Select UserId from users where Email = \'{0}\' and SecurityAnswer = \'{1}\'",
                           HttpContext.Current.Session["Email"].ToString(), answer);
        reader = command.ExecuteReader();
        reader.Read();

        if (reader.HasRows)
        {
            reader.Close();
            conn.Close();
            return true;
        }
        reader.Close();
        conn.Close();
        return false;
    }*/

    #region
    public bool Signup(string FirstName,string LastName, string email, string password, string street, string streetNumber, string postalCode, string city, string telephone, string country)
    {
        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        //Check to make sure the user does not exist in database
        command.CommandText = String.Format("Select ID from UsersLogin where UsersLogin.Email = \'{0}\'",
                           email);
        reader = command.ExecuteReader();
        reader.Read();
        if (reader.HasRows)
        {
            reader.Close();
            conn.Close();
            return true;
        }
        else
        {
            reader.Close();
            //insert the new user to the database
            command.CommandText = String.Format("INSERT INTO Users (FirstName, LastName) VALUES (\'{0}\',\'{1}\'); INSERT INTO UsersDetails (Street, StreetNumber, PostalCode, City, Telephone, Country) VALUES (\'{2}\',\'{3}\',\'{4}\',\'{5}\',\'{6}\',\'{7}\'); INSERT INTO UsersLogin (email, password) VALUES (\'{8}\',\'{9}\');", FirstName, LastName,street, streetNumber, postalCode, city, telephone, country, email, password);
            reader = command.ExecuteReader();

            reader.Close();
            conn.Close();
            return false;
        }
    }
    #endregion

    #region
    public string UpdatePassword(string newPass)
    {
        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        string response;
        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            response = "Your password could not be updated";
        }

        command.CommandText = String.Format("SET SQL_SAFE_UPDATES = 0");
        reader = command.ExecuteReader();
        reader.Close();

        command.CommandText = String.Format("Update UsersLogin set Password = \'{0}\' where Email = \'{1}\'", newPass, HttpContext.Current.Session["Email"].ToString());
        reader = command.ExecuteReader();
        reader.Read();
        reader.Close();


        conn.Close();
        response = "Your password is updated successfully.";
        return response;
    }
    #endregion

    #region
    public string getPublisher(string bookID)
    {
        string publiser = null;

        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("Select publisher from BooksDetails where id like '" + bookID + "'");
        reader = command.ExecuteReader();

        while (reader.Read())
        {
            publiser = reader["publisher"].ToString();
            return publiser;
        }

        reader.Close();
        conn.Close();
        return publiser;
    }
    #endregion

    #region
    public byte[] getImageBook(string bookID)
    {
        byte[] imageBytes = null;

        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("select Image from BooksDetails where ID = '" + bookID + "'");
        reader = command.ExecuteReader();


        while (reader.Read())
        {
            imageBytes = (byte[])reader["Image"];
            return imageBytes;
        }

        reader.Close();
        conn.Close();
        return imageBytes;

    }
    #endregion

    #region
    public string getUserID(string email)
    {
        string userUD = null;

        //Opening Sql Connection
        string connectionString =
            ConfigurationManager.ConnectionStrings["mydatabaseConnectionString"].ConnectionString;
        MySqlConnection conn = new MySqlConnection(connectionString);
        MySqlCommand command = conn.CreateCommand();
        MySqlDataReader reader;

        try
        {
            conn.Open();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Connection cant be opened.");
        }

        command.CommandText = String.Format("Select id from UsersLogin where email like '" + email + "'");
        reader = command.ExecuteReader();

        while (reader.Read())
        {
            userUD = reader["id"].ToString();
            return userUD;
        }

        reader.Close();
        conn.Close();
        return userUD;
    }
    #endregion

}