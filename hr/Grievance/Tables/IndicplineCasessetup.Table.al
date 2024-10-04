table 50003 "Indicpline Cases setup"
{
    DrillDownPageID = "Discipline Cases Page Setup";
    LookupPageID = "Discipline Cases Page Setup";

    fields
    {
        field(1; "Case Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Case Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Severity; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',High,Medium,Low';
            OptionMembers = " ",High,Medium,Low;
        }
        field(4; "Possible Action"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Case Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

