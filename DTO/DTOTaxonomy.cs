using System;

public class DTOTaxonomy
{
    private bool rateable;

    public bool Rateable
    {
        get { return rateable; }
        set { rateable = value; }
    }

    private long iD;

    public long ID
    {
        get { return iD; }
        set { iD = value; }
    }

    private string name;

    public string Name
    {
        get { return name; }
        set { name = value; }
    }

    private DateTime date;

    public DateTime Date
    {
        get { return date; }
        set { date = value; }
    }

    private long parentId;

    public long ParentId
    {
        get { return parentId; }
        set { parentId = value; }
    }

    private string parentName;

    public string ParentName
    {
        get { return parentName; }
        set { parentName = value; }
    }

    public DTOTaxonomy()
    {
        iD = 0;
        parentId = 0;
        name = "";
        parentName = "";
        rateable = false;
    }
}