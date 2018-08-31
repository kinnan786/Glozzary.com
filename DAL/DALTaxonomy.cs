using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using DAL;

public class DALTaxonomy : ConnectionClass
{
    private DTOTaxonomy dtotaxonomy;
    private List<DTOTaxonomy> lstTaxonomy;

    public List<DTOTaxonomy> GetTaxonomy()
    {
        return GetTaxonomy("");
    }

    public List<DTOTaxonomy> GetTaxonomy(string Query)
    {
        lstTaxonomy = new List<DTOTaxonomy>();

        try
        {
            sqlparameter = new SqlParameter[1];
            sqlparameter[0] = new SqlParameter("@Query", Query);

            OpenConnection();
            datareader = ExecuteReader(StoredProcedure.Names.spGetTaxonomy.ToString());

            if (!datareader.HasRows)
                return null;
            while (datareader.Read())
            {
                dtotaxonomy = new DTOTaxonomy();
                dtotaxonomy.ID = Convert.ToInt64(datareader["ID"]);
                dtotaxonomy.Name = datareader["Name"].ToString();
                dtotaxonomy.ParentId = Convert.ToInt64(datareader["ParentNode"]);
                dtotaxonomy.ParentName = (datareader["ParentName"]).ToString();
                dtotaxonomy.Rateable = Convert.ToBoolean(datareader["Rateable"]);
                lstTaxonomy.Add(dtotaxonomy);
            }
        }
        catch (Exception error)
        {
            throw error;
        }
        finally
        {
            CloseConnection();
        }
        return lstTaxonomy;
    }

    public int AddTaxonomy(string Name, bool Rateable)
    {
        int returnvalue = 0;

        try
        {
            sqlparameter = new SqlParameter[2];
            sqlparameter[0] = new SqlParameter("@Name", Name);
            sqlparameter[1] = new SqlParameter("@Rateable", Rateable);

            OpenConnection();
            returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddTaxonomy.ToString()));
        }
        catch (Exception error)
        {
            throw error;
        }
        finally
        {
            CloseConnection();
        }
        return returnvalue;
    }

    public int UpdateTaxonomy(string Name, bool Rateable, long Id)
    {
        int returnvalue = 0;

        try
        {
            sqlparameter = new SqlParameter[3];
            sqlparameter[0] = new SqlParameter("@Name", Name);
            sqlparameter[1] = new SqlParameter("@Rateable", Rateable);
            sqlparameter[2] = new SqlParameter("@Id", Id);

            OpenConnection();
            returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spUpdateTaxonomy.ToString()));
        }
        catch (Exception error)
        {
            throw error;
        }
        finally
        {
            CloseConnection();
        }
        return returnvalue;
    }
}