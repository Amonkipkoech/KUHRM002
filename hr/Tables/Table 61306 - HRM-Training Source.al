table 61306 "HRM-Training Source"
{
    LookupPageID = "HRM-Training Sources";

    fields
    {
        field(1; Source; Code[50])
        {
            NotBlank = true;
        }
        field(2; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Source)
        {
        }
    }

    fieldgroups
    {
    }
}

