table 61201 "HRM-Qualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "HRM-Qualifications";
    LookupPageID = "HRM-Qualifications";

    fields
    {
        field(1; "Qualification Type"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Qualification Type"));
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Qualification Type", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

