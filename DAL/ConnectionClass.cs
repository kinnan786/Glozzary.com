using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class ConnectionClass
    {
        private readonly SqlConnection connection;
        private readonly string connectionstring;
        private SqlCommand command;
        protected SqlDataReader datareader;
        protected SqlParameter[] sqlparameter;

        public ConnectionClass()
        {
            connectionstring = ConfigurationManager.ConnectionStrings["TagConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionstring);
        }

        protected void OpenConnection()
        {
            try
            {
                connection.Open();
            }
            catch (Exception error)
            {
                throw error;
            }
        }

        protected void CloseConnection()
        {
            try
            {
                connection.Close();
            }
            catch (Exception error)
            {
                throw error;
            }
        }

        protected SqlDataReader ExecuteReader(string StoredProcedureName)
        {
            try
            {
                command = new SqlCommand(StoredProcedureName, connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                if (sqlparameter != null)
                    command.Parameters.AddRange(sqlparameter);
                return command.ExecuteReader();
            }
            catch (Exception error)
            {
                throw error;
            }
        }

        protected string ExecuteNonQuery(string StoredProcedureName)
        {
            try
            {
                command = new SqlCommand(StoredProcedureName, connection);
                command.CommandType = CommandType.StoredProcedure;
                if (sqlparameter != null)
                    command.Parameters.AddRange(sqlparameter);
                return command.ExecuteNonQuery().ToString();
            }
            catch (Exception error)
            {
                throw error;
            }
        }

        protected string ExecuteScalar(string StoredProcedureName)
        {
            try
            {
                command = new SqlCommand(StoredProcedureName, connection);
                command.CommandType = CommandType.StoredProcedure;
                if (sqlparameter != null)
                    command.Parameters.AddRange(sqlparameter);
                var str = command.ExecuteScalar().ToString();
                return str;
            }
            catch (Exception error)
            {
                throw error;
            }
        }
    }
}