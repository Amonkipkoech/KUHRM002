table 61229 "HRM-Applicant Hobbies"
{

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(2; Hobby; Text[200])
        {
        }
        field(3; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Applicant No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Job Application No", Hobby)
        {
        }
    }

    fieldgroups
    {
    }
}

