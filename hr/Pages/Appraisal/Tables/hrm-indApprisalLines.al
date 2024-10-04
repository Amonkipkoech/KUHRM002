table 75200 AppraisaLines
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lineNo; Integer)
        {

            AutoIncrement = true;
        }
        field(2; employeeNo; code[20])
        {

        }
        field(3; objective; text[300])
        {

        }
    }

    keys
    {
        key(Key1; lineNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}