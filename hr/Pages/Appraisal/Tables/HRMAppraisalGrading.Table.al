table 75005 "HRM-Appraisal Grading"
{
    //DrillDownPageID = 67010;
    //LookupPageID = 67010;

    fields
    {
        field(1; "Appraisal Job Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Jobs".Code;
        }
        field(2; Grade; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Up to"; Decimal)
        {
        }
        field(5; Remarks; Text[150])
        {
        }
        field(6; Failed; Boolean)
        {
        }
        field(7; Range; Text[150])
        {
        }
        field(50008; "Appraisal Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Appraisal Years".Code;
        }
    }

    keys
    {
        key(Key1; "Appraisal Job Code", "Up to", Grade)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

