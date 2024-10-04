table 75019 "HRM-HOD Dept. Loading"
{
    DrillDownPageID = 75028;
    LookupPageID = 75028;

    fields
    {
        field(1; HOD; Code[30])
        {
            NotBlank = true;
        }
        field(2; "Appraisal Job Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Jobs".Code;
        }
        field(4; "Appraisal Target"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Targets".Code;

            trigger OnValidate()
            begin
                UnitSubj.RESET;
                UnitSubj.SETRANGE(UnitSubj.Code, "Appraisal Target");
                UnitSubj.SETRANGE(UnitSubj."Appraisal Job Code", "Appraisal Job Code");
                IF UnitSubj.FIND('-') THEN;
                "Appraisal Target Description" := UnitSubj.Desription;
            end;
        }
        field(5; "Appraisal Period Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Periods".Code;
        }
        field(6; Remarks; Text[200])
        {
        }
        field(7; "Appraisal Target Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appraisal Job Code", "Appraisal Target", "Appraisal Period Code", HOD)
        {
            Clustered = true;
        }
        key(Key2; HOD)
        {
        }
        key(Key3; "Appraisal Target")
        {
        }
        key(Key4; "Appraisal Period Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        UnitSubj: Record 75004;
}

