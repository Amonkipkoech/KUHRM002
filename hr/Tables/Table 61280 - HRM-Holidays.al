table 61280 "HRM-Holidays"
{
    LookupPageID = "HRM-Holidays";

    fields
    {
        field(1; Date; Date)
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

