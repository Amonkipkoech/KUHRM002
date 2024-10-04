table 61840 "PRL-Variance Trans. Code Buff"
{

    fields
    {
        field(1; "Transaction Code"; Code[20])
        {
        }
        field(2; "Transaction Name"; Text[150])
        {
        }
        field(3; "Emp. Code"; Code[20])
        {
        }
        field(4; "Emp. Name"; Text[150])
        {
        }
        field(5; "Current Amount"; Decimal)
        {
        }
        field(6; "Previous Amount"; Decimal)
        {
        }
        field(7; "Current Month"; Integer)
        {
        }
        field(8; "Previous Month"; Integer)
        {
        }
        field(9; "Current Year"; Integer)
        {
        }
        field(10; "Previous Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code", "Emp. Code")
        {
        }
    }

    fieldgroups
    {
    }
}

