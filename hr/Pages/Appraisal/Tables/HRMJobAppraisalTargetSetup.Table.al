table 75002 "HRM-Job Appraisal Target Setup"
{

    fields
    {
        field(1; "Job Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Target Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Target Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Job Id", "Target Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

