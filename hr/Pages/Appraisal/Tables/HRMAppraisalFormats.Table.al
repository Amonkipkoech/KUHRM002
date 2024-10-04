table 61326 "HRM-Appraisal Formats"
{

    fields
    {
        field(1; "Appraisal Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Types".Code;
        }
        field(2; Sequence; Integer)
        {
            NotBlank = true;
        }
        field(3; Type; Option)
        {
            OptionMembers = Question,"Heading 2",Category,"Heading 1";
        }
        field(4; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(5; Description; Text[250])
        {
        }
        field(6; "Entry By"; Code[20])
        {
        }
        field(7; "After Entry Of Prev. Group"; Boolean)
        {
        }
        field(8; "Allow Previous Groups Rights"; Boolean)
        {
        }
        field(9; "In Put"; Option)
        {
            OptionMembers = " ",Grades,Marks,Details;
        }
    }

    keys
    {
        key(Key1; "Appraisal Code", Type, "Code", Sequence)
        {
            Clustered = true;
        }
        key(Key2; "Appraisal Code", Sequence)
        {
        }
    }

    fieldgroups
    {
    }
}

