table 61236 "HRM-Appraisal Evaluation Areas"
{
    //LookupPageID = "FIN-Posted Interbank Trans.";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Include in Evaluation Form"; Boolean)
        {
        }
        field(8; "Objective Type"; Option)
        {
            OptionMembers = Quantitative,Qualitative;
        }
        field(9; "Categorize As"; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(10; "Assign To"; Code[20])
        {
            TableRelation = "HRM-Jobs"."Job ID";
        }
        field(11; "Sub Category"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Sub Category"));
        }
        field(12; Group; Code[40])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Group Item"));
        }
        field(13; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Categorize As", "Code", "Sub Category", Group)
        {
        }
    }

    fieldgroups
    {
    }
}

