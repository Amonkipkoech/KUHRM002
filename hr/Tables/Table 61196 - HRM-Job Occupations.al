table 61196 "HRM-Job Occupations"
{

    fields
    {
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HREmp.Get("Employee No.");

                CalcFields("First Name");
                CalcFields("Middle Name");
                CalcFields("Last Name");
                Email := HREmp."E-Mail";
                "Date of Join" := HREmp."Date Of Join";
                HREmp."Job Title" := "Job Id";
                HREmp.Validate(HREmp."Job Title");
                HREmp.Modify;
            end;
        }
        field(3; "First Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee"."First Name" WHERE("No." = FIELD("Employee No.")));

        }
        field(4; "Middle Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee"."Middle Name" WHERE("No." = FIELD("Employee No.")));

        }
        field(5; "Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee"."Last Name" WHERE("No." = FIELD("Employee No.")));

        }
        field(6; Extension; Text[30])
        {
            FieldClass = Normal;
        }
        field(7; Email; Text[30])
        {
            FieldClass = Normal;
        }
        field(8; "Date of Join"; Date)
        {
            FieldClass = Normal;
        }
        field(9; Department; Code[20])
        {
            FieldClass = Normal;
        }
        field(55; "Job Desc"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Jobs"."Job Description" WHERE("Job ID" = FIELD("Job Id")));

        }
        field(56; "Job Id"; Code[100])
        {
            TableRelation = "HRM-Jobs"."Job ID";
        }
    }

    keys
    {
        key(Key1; "Job Id", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HRM-Employee (D)";
        HRJobs: Record "HRM-Jobs";
}

