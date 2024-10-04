table 85001 "HRM-Terms Values"
{
    DrillDownPageId = "HRM-Terms Values";
    LookupPageId = "HRM-Terms Values";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Term Code"; Code[20])
        {
            Editable = false;
            TableRelation = "HRM-Terms Setup";

        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Description; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1;"Term Code" , Code)
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