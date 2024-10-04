table 61211 "HRM-ShortListQualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "PRL-Employee History";
    LookupPageID = "PRL-Employee History";

    fields
    {
        field(1; "ShortList Type"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("ShortListing Criteria"));
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
        key(Key1; "ShortList Type", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

