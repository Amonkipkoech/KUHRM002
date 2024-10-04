table 61290 "HRM-Competency Areas"
{
    //todo LookupPageID = "HRM-Competency Areas LookUp";

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
            TableRelation = "HRM-Appraisal Grades".Grade;
        }
        field(6; Reviewer; Code[20])
        {
            TableRelation = "HRM-Appraisal Grades".Grade;
        }
        field(7; Comments; Text[250])
        {
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
}

