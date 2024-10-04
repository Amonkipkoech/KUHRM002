table 61293 "HRM-KPA Objectives (B)"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; Period; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Periods".Period;
        }
        field(3; "KPA Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Key Performance Areas".Code;

            trigger OnValidate()
            begin
                KPAreas.Reset;
                //KPAreas.SETRANGE(KPAreas."Employee No","Employee No");
                //KPAreas.SETRANGE(KPAreas.Period,Period);
                KPAreas.SetRange(KPAreas.Code, "KPA Code");
                if KPAreas.Find('-') then
                    "KPA Description" := KPAreas.Description;
            end;
        }
        field(4; "KPA Description"; Text[200])
        {
            Editable = false;
        }
        field(5; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(6; Description; Text[200])
        {
        }
        field(7; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", Period, "KPA Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        KPAreas: Record "HRM-Key Performance Areas";
}

