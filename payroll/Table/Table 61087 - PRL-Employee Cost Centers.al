table 61087 "PRL-Employee Cost Centers"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "GEN-SMS_Master".sms_ID;
        }
        field(2; "Center Code"; Code[20])
        {
        }
        field(3; Percentage; Decimal)
        {
        }
        field(4; Analysis0; Text[20])
        {
        }
        field(5; Analysis1; Text[20])
        {
        }
        field(6; Analysis2; Text[20])
        {
        }
        field(7; Analysis3; Text[20])
        {
        }
        field(8; Analysis4; Text[20])
        {
        }
        field(9; Analysis5; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Center Code", Analysis0, Analysis1, Analysis3, Analysis4, Analysis5)
        {
        }
    }

    fieldgroups
    {
    }
}

