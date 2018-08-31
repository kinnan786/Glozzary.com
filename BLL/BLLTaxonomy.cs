using System.Collections.Generic;

namespace BLL
{
    public class BLLTaxonomy
    {
        private DALTaxonomy daltaxonomy;

        public int UpdateTaxonomy(string Name, bool Rateable, long Id)
        {
            daltaxonomy = new DALTaxonomy();
            return daltaxonomy.UpdateTaxonomy(Name, Rateable, Id);






            //asdsadsadsadsads
        }

        public List<DTOTaxonomy> GetTaxonomy(string query)
        {
            daltaxonomy = new DALTaxonomy();
            return daltaxonomy.GetTaxonomy(query);
        }

        public List<DTOTaxonomy> GetTaxonomy()
        {
            daltaxonomy = new DALTaxonomy();
            return daltaxonomy.GetTaxonomy();
        }

        public int AddTaxonomy(string Name, bool Rateable)
        {
            daltaxonomy = new DALTaxonomy();
            return daltaxonomy.AddTaxonomy(Name, Rateable);
        }
    }
}