table 61332 "HRM-Performance Plan"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
        }
        field(2; "Appraisal Type"; Code[20])
        {
        }
        field(3; "Appraisal Period"; Code[20])
        {
        }
        field(4; "Key Responsibility"; Text[120])
        {
            NotBlank = true;
            TableRelation = "HRM-Job Responsiblities".Responsibility WHERE("Job ID" = FIELD("Job ID"));
        }
        field(5; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Key Indicators"; Text[250])
        {
        }
        field(7; "Agreed Target Date"; Text[100])
        {
        }
        field(8; Weighting; Integer)
        {
        }
        field(9; "Results Achieved Comments"; Text[250])
        {
        }
        field(10; "Score/Points"; Decimal)
        {
        }
        field(11; "Job ID"; Code[20])
        {
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
    }

    keys
    {
        key(Key1; "Employee No", "Appraisal Type", "Appraisal Period", "Key Responsibility", "No.", "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

