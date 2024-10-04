table 50055 "HRM-Staff Categories"
{
    DrillDownPageID = "HRM-Staff Categories";
    LookupPageID = "HRM-Staff Categories";

    fields
    {
        field(1; "Category Code"; Code[20])
        {
        }
        field(2; "Category Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Category Code")
        {
        }
    }

    fieldgroups
    {
    }
}

