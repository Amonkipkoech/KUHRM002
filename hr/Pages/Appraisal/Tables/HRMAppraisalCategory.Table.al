table 75015 "HRM-Appraisal Category"
{
    DrillDownPageID = "HRM-Appraisal Category";
    LookupPageID = "HRM-Appraisal Category";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Series; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Series, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

