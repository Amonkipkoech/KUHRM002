table 61285 "HRM-Board Of Directors"
{
    LookupPageID = "HRM-Board of Directors";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; SurName; Text[100])
        {
        }
        field(3; "Other Names"; Text[150])
        {
        }
        field(4; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

