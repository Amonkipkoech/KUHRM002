table 61617 "HRM-Appraisal Training Develop"
{

    fields
    {
        field(1; "No Series"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[50])
        {
            TableRelation = "HRM-Appraisal Goal Setting H"."Appraisal No" WHERE("Appraisal No" = FIELD("Appraisal No"));
        }
        field(3; "Staff No"; Code[50])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(4; "Training Category"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER("Training Category"));
        }
        field(5; KSAR; Text[250])
        {
        }
        field(6; HOW; Text[250])
        {
        }
        field(7; IMPACT; Text[250])
        {
        }
        field(8; COMMENTS; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
    }

    keys
    {
        key(Key1; "No Series", "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

