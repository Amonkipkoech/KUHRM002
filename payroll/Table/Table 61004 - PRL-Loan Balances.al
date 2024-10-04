table 61004 "PRL-Loan Balances"
{

    fields
    {
        field(1; "Emp. No"; Code[20])
        {
        }
        field(2; "Trans Code"; Code[20])
        {
        }
        field(3; "Trans Name"; Text[100])
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
        {
        }
        field(6; Balance; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Emp. No", "Trans Code", "Period Year", "Period Month", Balance)
        {
        }
    }

    fieldgroups
    {
    }
}

