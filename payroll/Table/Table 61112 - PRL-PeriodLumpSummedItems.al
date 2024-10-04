table 61112 "PRL-PeriodLumpSummedItems"
{

    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "pay no"; Code[20])
        {
        }
        field(3; "Transaction code"; Text[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(4; "Transaction Number"; Code[20])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "cont to date"; Decimal)
        {
        }
        field(7; Balance; Decimal)
        {
        }
        field(8; "Period Month"; Integer)
        {
        }
        field(9; "Period Year"; Integer)
        {
        }
        field(10; "Payroll Period"; Date)
        {
        }
        field(11; lumpsum; Boolean)
        {
            Description = 'Set to ''Yes'' to lumpsum the figures in the payslip - Denno';
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction code", "Transaction Number", "Period Month", "Period Year", "Payroll Period")
        {
        }
    }

    fieldgroups
    {
    }
}

