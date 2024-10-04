table 61829 "HRM-Emp. Trans. Adjst Buffer"
{

    fields
    {
        field(1; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(2; "Employee No"; Code[30])
        {
            TableRelation = "HRM-Employee"."No.";
        }
        field(3; Period; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(4; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
        }
    }

    fieldgroups
    {
    }
}

