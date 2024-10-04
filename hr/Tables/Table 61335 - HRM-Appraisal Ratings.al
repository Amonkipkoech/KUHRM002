table 61335 "HRM-Appraisal Ratings"
{
    DrillDownPageID = "HRM-Appraisal Ratings (B)";
    LookupPageID = "HRM-Appraisal Ratings (B)";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "Up To"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Up To")
        {
        }
    }

    fieldgroups
    {
    }
}

