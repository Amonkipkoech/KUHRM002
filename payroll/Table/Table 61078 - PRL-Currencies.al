table 61078 "PRL-Currencies"
{

    fields
    {
        field(1; "Currency Code"; Code[10])
        {
        }
        field(2; "Currency Name"; Text[50])
        {
        }
        field(3; Rate; Decimal)
        {
        }
        field(4; Default; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Currency Code")
        {
        }
    }

    fieldgroups
    {
    }
}

