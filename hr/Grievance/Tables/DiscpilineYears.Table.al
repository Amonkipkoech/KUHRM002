table 50004 "Discpiline Years"
{

    fields
    {
        field(1; "Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Year Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Year Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

