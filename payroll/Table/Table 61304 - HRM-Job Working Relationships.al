table 61304 "HRM-Job Working Relationships"
{

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
        field(2; Type; Option)
        {
            NotBlank = false;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(3; Relationship; Text[200])
        {
            NotBlank = true;
        }
        field(4; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", Type, Relationship)
        {
        }
    }

    fieldgroups
    {
    }
}

