table 61288 "HRM-Appraisal Periods2"
{
    DrillDownPageID = 68343;
    LookupPageID = 68343;

    fields
    {
        field(1; Period; Code[30])
        {
        }
        field(2; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

