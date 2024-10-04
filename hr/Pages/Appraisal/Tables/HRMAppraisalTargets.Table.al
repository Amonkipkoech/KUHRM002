table 75004 "HRM-Appraisal Targets"
{
    DrillDownPageID = "HRM-Appraisal Targets";
    LookupPageID = "HRM-Appraisal Targets";

    fields
    {
        field(1; "Appraisal Job Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Appraisal Jobs".Code;
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Target Code';
            NotBlank = true;
        }
        field(4; Desription; Text[150])
        {
        }
        field(84; "Job Title"; Text[200])
        {
            CalcFormula = Lookup("HRM-Appraisal Jobs".Description WHERE(Code = FIELD("Appraisal Job Code")));
            FieldClass = FlowField;
        }
        field(50008; "Appraisal Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Appraisal Years".Code;
        }
    }

    keys
    {
        key(Key1; "Appraisal Job Code", "Appraisal Year Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

