table 50071 "Staff Personal Items"
{

    fields
    {
        field(1; "Staff Code"; Code[30])
        {
        }
        field(2; "Staff ID"; Code[30])
        {
        }
        field(3; "Item Code"; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Item Description"; Text[150])
        {
        }
        field(5; "Serial No."; Code[50])
        {
        }
        field(6; Cleared; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Staff Code", "Staff ID", "Item Code")
        {
        }
    }

    fieldgroups
    {
    }
}

