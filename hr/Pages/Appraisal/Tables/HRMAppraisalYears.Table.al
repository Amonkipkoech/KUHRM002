table 75001 "HRM-Appraisal Years"
{
    LookupPageID = "HRM-Appraisal Years List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the Appraisal year in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the description of the Appraisal year';
        }
        field(5; Closed; Boolean)
        {
            Editable = false;
        }
        field(6; "Closed By"; Code[20])
        {
            Editable = false;
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

