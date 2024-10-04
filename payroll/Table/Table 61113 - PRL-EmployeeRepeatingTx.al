table 61113 "PRL-EmployeeRepeatingTx"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Transaction Code"; Code[20])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(3; "Transaction Name"; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(12; "Reference No"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Reference No", "Period Month", "Period Year", "Payroll Period")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

