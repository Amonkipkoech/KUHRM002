table 61751 "HRM-Emp. Trans Buffer"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Transaction Name"; Text[250])
        {
        }
        field(3; "Transaction Code"; Code[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Posted; Boolean)
        {
        }
        field(6; "Fail Reason"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Transaction Name", Amount)
        {
        }
    }

    fieldgroups
    {
    }
}

