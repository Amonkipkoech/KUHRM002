table 61828 "HRM-Institutions"
{
    DrillDownPageID = "HRM-Institutions List";
    LookupPageID = "HRM-Institutions List";

    fields
    {
        field(1; "Institution Code"; Code[30])
        {
        }
        field(2; "Institution Name"; Text[250])
        {
        }
        field(3; "Private/Public"; Option)
        {
            OptionMembers = " ",Private,Public;
        }
        field(4; Country; Code[20])
        {
        }
        field(5; website; Text[100])
        {
       
        }
        
    }

    keys
    {
        key(Key1; "Institution Code")
        {
        }
    }

    fieldgroups
    {
    }
}

