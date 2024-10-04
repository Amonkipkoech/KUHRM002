table 61108 "PRL-Staff Dimensions"
{

    fields
    {
        field(1; "Employee Code"; Text[30])
        {
            TableRelation = "PRL-Salary Card"."Employee Code";
        }
        field(2; "Dimension 0"; Text[30])
        {
        }
        field(3; "Dimension 1"; Text[30])
        {
        }
        field(4; "Dimension 2"; Text[30])
        {
        }
        field(5; "Dimension 3"; Text[30])
        {
        }
        field(6; "Dimension 4"; Text[30])
        {
        }
        field(7; "Dimension 5"; Text[30])
        {
        }
        field(8; Percentage; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Dimension 0", "Dimension 1", "Dimension 3", "Dimension 4", "Dimension 5")
        {
        }
    }

    fieldgroups
    {
    }
}

