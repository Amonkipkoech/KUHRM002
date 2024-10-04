table 61076 "PRL-PAYE"
{

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
        }
        field(2; "PAYE Tier"; Decimal)
        {
        }
        field(3; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
        }
    }

    fieldgroups
    {
    }
}

