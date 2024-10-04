table 61289 "HRM-Key Performance Areas"
{
    LookupPageID = "HRM-Key Performance Areas Lp";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Period; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(4; Description; Text[200])
        {
        }
        field(5; Self; Code[20])
        {
            TableRelation = "HRM-Appraisal Grades";
        }
        field(6; Reviewer; Code[20])
        {
            TableRelation = "HRM-Appraisal Grades";
        }
        field(7; Comments; Text[250])
        {
        }
        field(8; "KPA Entry No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Employee No", Period, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetKPACode() GetKPACode: Code[20]
    begin
        GetKPACode := Code;
    end;
}

