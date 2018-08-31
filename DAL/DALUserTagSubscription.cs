using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALSubscription
    /// </summary>
    public class DALUserTagSubscription
    {
        private readonly SqlConnection connection;
        private DtoUserTagSubscription UserTagSubscription;
        private SqlCommand command;
        private string connectionstring;
        private SqlDataReader datareader;
        private List<DtoUserTagSubscription> lstUserTagSubscription;

        public DALUserTagSubscription()
        {
            connectionstring = ConfigurationManager.ConnectionStrings["TagConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionstring);
        }

        public List<DtoUserTagSubscription> GetUserTagSubscription(Int64 UserID, string TagName)
        {
            command = new SqlCommand(StoredProcedure.Names.spGetUserTagSubscription.ToString(), connection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add("@UserID", SqlDbType.BigInt);
            command.Parameters.Add("@TagName", SqlDbType.VarChar);

            command.Parameters[0].Value = UserID;
            command.Parameters[1].Value = TagName;

            lstUserTagSubscription = new List<DtoUserTagSubscription>();

            connection.Open();
            datareader = command.ExecuteReader();

            if (!datareader.HasRows)
                return null;
            while (datareader.Read())
            {
                UserTagSubscription = new DtoUserTagSubscription();
                UserTagSubscription.TagId = Convert.ToInt64(datareader["TagId"].ToString());
                UserTagSubscription.UserSubscriptionId = Convert.ToInt64(datareader["UserTagSubscriptionId"]);
                UserTagSubscription.TagName = (datareader["TagName"]).ToString();
                lstUserTagSubscription.Add(UserTagSubscription);
            }
            connection.Close();
            return lstUserTagSubscription;
        }

        public Int64 AddUserTagSubscription(Int64 UserID, Int64 TagID)
        {
            command = new SqlCommand(StoredProcedure.Names.spAddUserTagSubscription.ToString(), connection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add("@TagID", SqlDbType.BigInt);
            command.Parameters.Add("@UserID", SqlDbType.BigInt);

            command.Parameters[0].Value = TagID;
            command.Parameters[1].Value = UserID;

            Int64 UserTagSubscriptionID = 0;

            connection.Open();
            UserTagSubscriptionID = Convert.ToInt64(command.ExecuteScalar());
            connection.Close();

            return UserTagSubscriptionID;
        }

        public Int64 DeleteUserTagSubscription(Int64 UserID, Int64 TagID)
        {
            command = new SqlCommand(StoredProcedure.Names.spDeleteUserTagSubscription.ToString(), connection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add("@TagID", SqlDbType.BigInt);
            command.Parameters.Add("@UserID", SqlDbType.BigInt);

            command.Parameters[0].Value = TagID;
            command.Parameters[1].Value = UserID;

            Int64 UserTagSubscriptionID = 0;

            connection.Open();
            UserTagSubscriptionID = Convert.ToInt64(command.ExecuteScalar());
            connection.Close();

            return UserTagSubscriptionID;
        }
    }
}