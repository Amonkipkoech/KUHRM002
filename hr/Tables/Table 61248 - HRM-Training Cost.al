table 61248 "HRM-Training Cost"
{
    DrillDownPageID = "HRM-Training Cost";
    LookupPageID = "HRM-Training Cost";

    fields
    {
        field(1; "Training Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Training Applications"."Application No";
        }
        field(2; "Training Cost Item"; Code[30])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER("Training Cost Items"));
        }
        field(3; Cost; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Training Id", "Training Cost Item")
        {
        }
    }

    fieldgroups
    {
    }
}

