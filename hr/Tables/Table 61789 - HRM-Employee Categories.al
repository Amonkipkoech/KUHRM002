table 61789 "HRM-Employee Categories"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Section; Option)
        {
            OptionCaption = ' ,Payroll,HR';
            OptionMembers = " ",Payroll,HR;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

