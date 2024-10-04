table 61292 "HRM-Appraisal Grades"
{
    //todoLookupPageID = "HRM-Grade Matrix";

    fields
    {
        field(1; Grade; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Points; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Grade)
        {
        }
        key(Key2; Points)
        {
        }
    }

    fieldgroups
    {
    }
}

