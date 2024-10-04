table 61268 "HRM-Overall Comments"
{

    fields
    {
        field(1; "No series"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal Code"; Code[50])
        {
            TableRelation = "HRM-Appraisal Card"."Appraisal Code";
        }
        field(3; "Supervisor Comments"; Text[250])
        {
        }
        field(4; "Appraisee Comments"; Text[250])
        {
        }
        field(5; "Part"; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "No series")
        {
        }
    }

    fieldgroups
    {
    }
}

