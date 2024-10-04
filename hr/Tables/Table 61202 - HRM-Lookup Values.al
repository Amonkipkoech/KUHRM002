table 61202 "HRM-Lookup Values"
{
    DrillDownPageID = "HRM-Lookup Values List";
    LookupPageID = "HRM-Lookup Values List";

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Religion,Language,Medical Scheme,Location,Contract Type,Qualification Type,Stages,Scores,Institution,Appraisal Type,Appraisal Period,Urgency,Succession,Security,Disciplinary Case Rating,Disciplinary Case,Disciplinary Action,Next of Kin,County,Grade,Checklist Item,Appraisal Sub Category,Appraisal Group Item,Transport Type,Training Cost Items,Training Category,Dependant,CompetenceValues,ShortListing Criteria,Qualification category';
            OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",County,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Training Cost Items","Training Category",Dependant,CompetenceValues,"ShortListing Criteria","Qualification category";
        }
        field(2; "Code"; Code[70])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Notice Period"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
        }
        field(7; "Contract Length"; Integer)
        {
        }
        field(8; "Current Appraisal Period"; Boolean)
        {
        }
        field(9; "Disciplinary Case Rating"; Text[30])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Case Rating"));
        }
        field(10; "Disciplinary Action"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));
        }
        field(14; From; Date)
        {
        }
        field(15; "To"; Date)
        {
        }
        field(16; Score; Decimal)
        {
        }
        field(17; "Basic Salary"; Decimal)
        {
        }
        field(18; "To be cleared by"; Code[10])
        {
            TableRelation = "HRM-Jobs"."Job ID";
        }
        field(50000; "Weight Scores"; Decimal)
        {
        }
        field(50001; "Job Scale"; Code[10])
        {
        }
        field(50002; "Next Period"; Boolean)
        {
        }
        field(50003; "Previous Job Position"; Boolean)
        {
        }
        field(50004; "Previous Job Position Order"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code", Description)
        {
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

