table 61016 "GEN-SMS_Master"
{

    fields
    {
        field(1; sms_ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Receiver; Code[50])
        {
        }
        field(3; Msg; Text[250])
        {
        }
        field(4; Operator; Text[100])
        {
        }
        field(5; sms_Type; Text[30])
        {
        }
        field(6; Sender; Code[100])
        {
        }
        field(7; "Code"; Text[100])
        {
        }
        field(8; sms_Status; Text[30])
        {
        }
        field(9; senttime; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; sms_ID)
        {
        }
    }

    fieldgroups
    {
    }
}

