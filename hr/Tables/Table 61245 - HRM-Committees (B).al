table 61245 "HRM-Committees (B)"
{
    LookupPageID = "HRM-Committees (B) List";
    DrillDownPageId = "HRM-Committees (B) List";

    fields
    {
        field(1; "Code"; Code[70])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            NotBlank = true;
        }
        field(3; Roles; Text[200])
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

