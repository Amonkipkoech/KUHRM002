table 61512 "ACA-Religions"
{

DrillDownPageId = "Religion List";

    fields
    {
        field(1; Religion; Code[50])
        {
            NotBlank = true;
        }
        field(2; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Religion)
        {
        }
    }

    fieldgroups
    {
    }
}

