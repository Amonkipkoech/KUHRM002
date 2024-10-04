table 61120 "HRM-Salary Grades"
{
    DrillDownPageID = "PRL-Salary Grades List";
    LookupPageID = "PRL-Salary Grades List";

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
        }
        field(2; "Salary Amount"; Decimal)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "House Allowance"; Decimal)
        {
        }
        field(5; "Leave Allowance"; Decimal)
        {
        }
        field(6; Ceiling_salary; Decimal)
        {
        }
        field(7; Basic_salary; Decimal)
        {
        }
        field(8; "Weekly Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Salary Grade")
        {
        }
    }

    fieldgroups
    {
    }
}

