table 61297 "HRM-Disciplinary Cases"
{
    LookupPageID = "HRM-Disciplinary Cases (B)";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Rating; Code[50])
        {
            TableRelation = "HRM-Disciplinary Case Ratings".Code;
        }
        field(4; Comments; Text[200])
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

