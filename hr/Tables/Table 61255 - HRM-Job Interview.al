table 61255 "HRM-Job Interview"
{

    fields
    {
        field(2; "Applicant No"; Code[20])
        {
            Description = 'Stores the admission number of the record in the database';
            TableRelation = "HRM-Shortlisted Applicants"."Job Application No";
        }
        field(3; "Interview Code"; Code[80])
        {
            Description = 'Stores the code of the medical condition in the database';
            TableRelation = "HRM-Interview Details".Code;

            trigger OnValidate()
            begin
                Intdetails.SetRange(Intdetails.Code, "Interview Code");
                if Intdetails.Find('-') then begin
                    "Interview Description" := Intdetails."Item Description";

                end;
            end;
        }
        field(4; "Interview Description"; Text[250])
        {
            Description = 'Stores the name of the medical condition';

            trigger OnValidate()
            begin

                CalcFields("Interview Description");
            end;
        }
        field(6; Score; Decimal)
        {
            Description = 'Stores when the user was diagnosed';
            MaxValue = 5;
        }
        field(8; "Total Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Job Interview".Score WHERE("Applicant No" = FIELD("Applicant No")));
            Editable = false;
            FieldClass = FlowField;
            MaxValue = 19;

            trigger OnValidate()
            begin
                //Cust.CALCFIELDS("Total Score");
                if Cust."Total Score" > 5 then begin
                    Error('The allowable unaccounted balance of %1 has been exceeded');

                end;
            end;
        }
        field(10; Category; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(11; "Sub Category"; Code[100])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Checklist Item"));
        }
        field(12; Group; Code[80])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Sub Category"));
        }
        field(14; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(15; comments; Text[250])
        {
        }
        field(16; Interviewer; Code[10])
        {
        }
        field(17; "Interviewer Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Applicant No", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRLookupValues: Record "HRM-Lookup Values";
        TotalScore: Integer;
        Intdetails: Record "HRM-Interview Details";
        Cust: Record "HRM-Job Interview";
}

