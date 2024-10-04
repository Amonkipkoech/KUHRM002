table 61101 "PRL-Employee Motor Vehicles"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
        }
        field(2; "Vehicle Category"; Code[20])
        {
        }
        field(3; "Vehicle Value"; Decimal)
        {
        }
        field(4; "Is Leased"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }
}

