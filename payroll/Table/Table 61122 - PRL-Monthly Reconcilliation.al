table 61122 "PRL-Monthly Reconcilliation"
{

    fields
    {
        field(1; Employee; Code[20])
        {
        }
        field(2; TransCode; Code[20])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; CurrAmount; Decimal)
        {
        }
        field(5; PrevAmount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Employee, TransCode)
        {
        }
    }

    fieldgroups
    {
    }
}

