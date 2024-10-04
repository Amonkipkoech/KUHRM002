table 61117 "PRL-Employee Trans IMP BAL"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; "Original Amount"; Decimal)
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
        field(11; Membership; Code[20])
        {
            TableRelation = "PRL-Institutional Membership"."Institution No";
        }
        field(12; "Reference No"; Text[30])
        {
        }
        field(13; integera; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Transcode: Record "PRL-Transaction Codes";
}

