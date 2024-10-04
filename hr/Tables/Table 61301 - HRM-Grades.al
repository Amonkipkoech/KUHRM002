table 61301 "HRM-Grades"
{
    LookupPageID = "HRM-Grades";

    fields
    {
        field(1; Grade; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Annual Leave Days"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Grade)
        {
        }
    }

    fieldgroups
    {
    }
}

