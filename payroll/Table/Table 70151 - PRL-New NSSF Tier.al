table 75022 "PRL-NSSF"
{
    LookupPageId = "PRL-NSSF";
    DrillDownPageId = "PRL-NSSF";
    fields
    {
        field(1; "Tier Code"; Code[10])
        {
            SQLDataType = Integer;
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "Lower Limit"; Decimal)
        {
        }
        field(4; "Amount Type"; Option)
        {
            OptionMembers = "Amount As Percentage","Amount as Contribution";
        }
        field(5; "Upper Limit"; Decimal)
        {
        }
        field(6; "Tier I Limit"; Decimal)
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
