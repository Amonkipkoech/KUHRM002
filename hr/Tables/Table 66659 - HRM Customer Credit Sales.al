table 61068 "HRM Customer Credit Sales"
{
    //DrillDownPageID = "FRM Farmer Credit Register";
    //todo LookupPageID = "FRM Farmer Credit Register";

    fields
    {
        field(1; "Trans. No."; Code[20])
        {
        }
        field(2; "Trans. Date"; Date)
        {
        }
        field(3; "Customer No."; Code[20])
        {
        }
        field(4; "Trans. Desc."; Text[100])
        {
        }
        field(5; "Served by"; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Payroll Period"; Date)
        {
            //todo   TableRelation = "FRM Payment Periods"."Date Opened";
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Period Month"; Integer)
        {
        }
        field(10; "Transaction Type"; Option)
        {
            OptionCaption = 'Store Sales,VET Sales,VET Balance,Store Balance,VET Settlement,Store Settlement,Lab Sales,Lab Balance,Lab Settlement';
            OptionMembers = "Store Sales","VET Sales","VET Balance","Store Balance","VET Settlement","Store Settlement","Lab Sales","Lab Balance","Lab Settlement";
        }
    }

    keys
    {
        key(Key1; "Trans. No.", "Customer No.", "Payroll Period", "Transaction Type")
        {
        }
    }

    fieldgroups
    {
    }
}

