table 61263 "HRM-Appraisal Card"
{

    fields
    {
        field(1; "Appraisal Code"; Code[50])
        {
        }
        field(2; "Staff No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(3; "Appraisal Type"; Code[10])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Type"));
        }
        field(4; "Appraisal Period"; Code[10])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Period"));
        }
        field(5; "Supervisor Comment"; Text[250])
        {
        }
        field(6; "Appraisee Comment"; Text[250])
        {
        }
        field(7; Recomendations; Text[250])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = Appraisee,Supervisor,Closed;
        }
        field(9; Supervisor; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(10; "Explored By Appraisee"; Boolean)
        {
        }
        field(11; "Explored By Supervisor"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Code")
        {
        }
    }

    fieldgroups
    {
    }
}

