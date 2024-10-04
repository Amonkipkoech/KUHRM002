table 61616 "HRM-Appraisal Goal Setting NY"
{

    fields
    {
        field(1; "Appraisal No"; Code[10])
        {
            TableRelation = "HRM-Appraisal Goal Setting H"."Appraisal No";
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"),
                                                            "Current Appraisal Period" = CONST(true));
        }
        field(8; "Planned Targets/Objectives"; Text[230])
        {

            trigger OnValidate()
            begin
                HRAppraisalGoalSettingH.Get("Appraisal No");
                "Employee No" := HRAppraisalGoalSettingH."Employee No";
                HRAppraisalGoalSettingH.TestField(HRAppraisalGoalSettingH."Appraisal Period");
                "Appraisal Period" := HRAppraisalGoalSettingH."Appraisal Period"
            end;
        }
        field(10; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)";
        }
        field(11; "Success Measures"; Text[100])
        {
        }
        field(12; Timeline; Text[100])
        {
        }
        field(13; "Support Neede"; Text[100])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(18; "Sent to"; Option)
        {
            OptionCaption = 'Appraisee,Supervisor,EY Evaluation';
            OptionMembers = Appraisee,Supervisor,"EY Evaluation";
        }
        field(19; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HRM-Employee (D)";
        HRAppraisalGoalSettingH: Record "HRM-Appraisal Goal Setting H";
}

