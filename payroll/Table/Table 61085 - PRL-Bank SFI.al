table 61085 "PRL-Bank SFI"
{

    fields
    {
        field(1; "Line Code"; Code[20])
        {
        }
        field(2; "SFI Header"; Text[150])
        {
        }
        field(3; "SFI Body"; Text[150])
        {
        }
        field(4; "SFI Footer"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Line Code")
        {
        }
    }

    fieldgroups
    {
    }
}

