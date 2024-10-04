table 61333 "HRM-Career Developement Plan"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No") THEN
                    "Job ID" := Employee.Position;
            end;
        }
        field(2; "Appraisal Type"; Code[20])
        {
            TableRelation = "HRM-Appraisal Types".Code;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Periods2".Period;
        }
        field(4; "Job ID"; Code[20])
        {
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
        field(5; Type; Option)
        {
            OptionMembers = "Major Strenghts","Areas for Development","Training Needs","On Job Activities","Job Rotation";
        }
        field(6; Description; Code[20])
        {
            NotBlank = true;
            TableRelation = IF (Type = CONST("Major Strenghts")) "HRM-Job Requirement"."Qualification Code" WHERE("Qualification Type" = CONST("Experience"),
                                                                                                               "Qualification Type" = CONST("Personal Attributes"),
                                                                                                               "Job Id" = FIELD("Job ID"))
            ELSE
            IF (Type = CONST("Areas for Development")) "HRM-Job Requirement"."Qualification Code" WHERE("Job Id" = FIELD("Job ID"))
            ELSE
            IF (Type = CONST("Training Needs")) "HRM-Training Needs Analysis".Code;

            trigger OnValidate()
            begin
                IF Type = Type::"Training Needs" THEN BEGIN
                    TrainingReq.INIT;
                    TrainingReq."Job Application No" := xRec."Employee No";
                    TrainingReq.Names := Description;
                    TrainingReq.VALIDATE(TrainingReq.Names);
                    //TrainingReq."Need Source":=TrainingReq."Need Source"::"0";
                    TrainingReq.INSERT;
                END;
            end;
        }
        field(7; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Appraisal Type", "Appraisal Period", "Job ID", Type, Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HRM-Employee (D)";
        TrainingReq: Record "HRM-Applicant Referees";
}

