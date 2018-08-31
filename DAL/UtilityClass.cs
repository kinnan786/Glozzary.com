using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    public class UtilityClass : ConnectionClass
    {
        public List<string> GetMetachars(int websiteType)
        {
            var lststring = new List<string>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@WebsiteType", websiteType);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetMetachars.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    lststring.Add(datareader["Metachars"].ToString());
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return lststring;
        }

        public DataTable GetAllPages()
        {
            var table = new DataTable();
            table.Columns.Add("Id", Type.GetType("System.Int32"));
            table.Columns.Add("Type", Type.GetType("System.String"));

            try
            {
                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetAllPages.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    DataRow row = table.NewRow();

                    row[0] = datareader[0];
                    row[1] = datareader[1];
                    table.Rows.Add(row);
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return table;
        }


        public List<DtoWebsite> GetIntellisense(string searchtext)
        {
            var lstDtoWebsites = new List<DtoWebsite>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@searchtext", searchtext);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetIntellisense.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    DtoWebsite dtoWebsite = new DtoWebsite();
                    dtoWebsite.WebsiteId = Convert.ToInt64(datareader["Id"]);
                    dtoWebsite.WebSiteName = datareader["Name"].ToString();
                    dtoWebsite.WebsiteType = datareader["Category"].ToString();
                    lstDtoWebsites.Add(dtoWebsite);
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return lstDtoWebsites;
        }
    }
}