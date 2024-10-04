table 75006 "HRM-Employee Category"
{
    DrillDownPageID = "HRM-Appraisal Emp. Categories";
    LookupPageID = "HRM-Appraisal Emp. Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

