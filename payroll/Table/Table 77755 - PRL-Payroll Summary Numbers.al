table 77755 "PRL-Payroll Summary Numbers"
{

    fields
    {
        field(1; "User Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Serial; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Period; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User Name", "Staff No.", Period)
        {
        }
    }

    fieldgroups
    {
    }
}

