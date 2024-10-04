table 61111 "PRL-Institutional Membership"
{
    LookupPageID = "PRL-Institutional Membership";

    fields
    {
        field(1; "Group No"; Code[20])
        {
            TableRelation = "PRL-Membership Groups"."Group No";
        }
        field(2; "Institution No"; Code[20])
        {
        }
        field(3; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Group No", "Institution No")
        {
        }
    }

    fieldgroups
    {
    }
}

