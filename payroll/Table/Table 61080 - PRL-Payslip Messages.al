table 61080 "PRL-Payslip Messages"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
        }
        field(2; "Period Message"; Text[200])
        {
        }
        field(3; Recurring; Boolean)
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
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

