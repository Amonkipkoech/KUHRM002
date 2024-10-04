table 61235 "HRM-Appraisal Evaluations"
{

    fields
    {
        field(2; "Employee No"; Code[20])
        {
            Description = 'Stores the admission number of the record in the database';
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(3; "Evaluation Code"; Code[80])
        {
            Description = 'Stores the code of the medical condition in the database';
            TableRelation = "HRM-Appraisal Evaluation Areas".Code;

            trigger OnValidate()
            begin
                HRAppEvaluationAreas.SetRange(HRAppEvaluationAreas.Code, "Evaluation Code");
                if HRAppEvaluationAreas.Find('-') then begin
                    Category := HRAppEvaluationAreas."Categorize As";
                    "Sub Category" := HRAppEvaluationAreas."Sub Category";
                    Group := HRAppEvaluationAreas.Group;
                    "Line No" := HRAppEvaluationAreas."Line No";
                    "Evaluation Description" := HRAppEvaluationAreas.Description;
                    //"Appraisal Period":="Appraisal Period"

                end;
            end;
        }
        field(4; "Evaluation Description"; Text[250])
        {
            CalcFormula = Lookup("HRM-Appraisal Evaluation Areas".Description WHERE("Line No" = FIELD("Line No")));
            Description = 'Stores the name of the medical condition';
            FieldClass = FlowField;

            trigger OnValidate()
            begin

                CalcFields("Evaluation Description");
            end;
        }
        field(6; Score; Decimal)
        {
            Description = 'Stores when the user was diagnosed';
            FieldClass = Normal;
        }
        field(7; "Appraisal Rating"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER(Grade));
        }
        field(8; "Total Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Appraisal Evaluations".Score WHERE("Employee No" = FIELD("Employee No"),
                                                                       Category = FIELD(Category),
                                                                       "Sub Category" = FIELD("Sub Category"),
                                                                       Group = FIELD(Group)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Appraisal Period"; Code[30])
        {
        }
        field(10; Category; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(11; "Sub Category"; Code[100])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Sub Category"));
        }
        field(12; Group; Code[80])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Group Item"));
        }
        field(14; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(15; Comments; Text[250])
        {
        }
        field(16; "Appraisal No"; Code[50])
        {
            TableRelation = "HRM-Appraisal Goal Setting H"."Appraisal No" WHERE("Appraisal No" = FIELD("Appraisal No"));
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No")
        {
            SumIndexFields = Score;
        }
    }

    fieldgroups
    {
    }

    var
        HRLookupValues: Record "HRM-Lookup Values";
        TotalScore: Integer;
        HRAppEvaluationAreas: Record "HRM-Appraisal Evaluation Areas";
}

