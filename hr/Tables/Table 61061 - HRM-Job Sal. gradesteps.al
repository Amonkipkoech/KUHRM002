table 61061 "HRM-Job Sal. grade/steps"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Job ID"; Code[20])
        {
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
        field(3; "Salary Grade code"; Code[20])
        {
        }
        field(4; "Salary Steps code"; Code[20])
        {
        }
        field(5; "Basic Salary"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

