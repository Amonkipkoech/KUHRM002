table 75014 "HRM-Appraisal Res. Setup"
{
    LookupPageID = "HRM-Appraisal Setup";

    fields
    {
        field(1; Category; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Category".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Desription; Text[200])
        {
        }
        field(4; "Max. Score"; Decimal)
        {
        }
        field(5; "% Contrib. Final Score"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Category, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

