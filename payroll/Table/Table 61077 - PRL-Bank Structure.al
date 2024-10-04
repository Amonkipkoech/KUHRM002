table 61077 "PRL-Bank Structure"
{
    LookupPageID = "PRL-Bank Structure (B)";

    fields
    {
        field(1; "Bank Code"; Code[10])
        {
        }
        field(2; "Branch Code"; Code[20])
        {
        }
        field(3; "Bank Name"; Text[100])
        {
        }
        field(4; "Branch Name"; Text[100])
        {
        }
        field(5; Address; Text[200])
        {
        }
        field(6; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(7; "KBA Branch Code"; Code[20])
        {
        }
        field(8; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
        }
    }

    fieldgroups
    {
    }
}

