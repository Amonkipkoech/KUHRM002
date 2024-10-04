table 61302 "HRM-Job Responsiblities"
{
    DrillDownPageID = "HRM-Job Responsiblity Look Up";
    LookupPageID = "HRM-Job Responsiblity Look Up";

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
        field(2; Responsibility; Text[120])
        {
            NotBlank = true;
        }
        field(3; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", Responsibility)
        {
        }
    }

    fieldgroups
    {
    }
}

