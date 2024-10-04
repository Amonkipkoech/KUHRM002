table 61095 "PRL-Journal Headers"
{

    fields
    {
        field(1; "Trans Period"; Integer)
        {
        }
        field(2; "Trans Year"; Integer)
        {
        }
        field(3; "Country Code"; Code[20])
        {
        }
        field(4; "Journal Type"; Code[20])
        {
        }
        field(5; "Trans Date"; Date)
        {
        }
        field(6; "Currency Code"; Code[20])
        {
        }
        field(7; "JV Ref"; Code[20])
        {
        }
        field(8; Narrative; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Trans Period")
        {
        }
    }

    fieldgroups
    {
    }
}

