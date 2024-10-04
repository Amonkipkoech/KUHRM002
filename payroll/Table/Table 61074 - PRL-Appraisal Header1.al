table 61074 "PRL-Appraisal Header1"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Employee No"; Code[20])
        {
        }
        field(3; "Employee First Name"; Text[100])
        {
        }
        field(4; "Employee Last Name"; Text[100])
        {
        }
        field(5; "Appraisal Date"; Date)
        {
        }
        field(6; "Next Appraisal Date"; Date)
        {
        }
        field(7; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

