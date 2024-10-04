table 70253 "PRL-Casual Employer Deductions"
{
    DrillDownPageID = "PRL-Emp. Deductions";
    LookupPageID = "PRL-Emp. Deductions";

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
        {
        }
        field(6; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Casual Payroll Periods"."Period Name";
        }
        field(7; "Payroll Code"; Code[20])
        {
            TableRelation = "PRL-Payroll Type";
        }
        field(8; "Current Instalment"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Current Instalment")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

