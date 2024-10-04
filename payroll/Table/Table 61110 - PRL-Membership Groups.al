table 61110 "PRL-Membership Groups"
{
    DrillDownPageID = "PRL-Membership Groups";
    LookupPageID = "PRL-Membership Groups";

    fields
    {
        field(1; "Group No"; Code[10])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Group No")
        {
        }
    }

    fieldgroups
    {
    }
}

