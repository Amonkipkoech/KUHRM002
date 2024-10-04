table 50011 "Hrm-Insurance Licesnsing"
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "HRM-Licensing List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Insurance/Staturory Code';
            DataClassification = ToBeClassified;

        }
        field(2; Name; Text[60])
        {
            Caption = 'License/Statutory Name';
            DataClassification = ToBeClassified;

        }
        field(3; "Issuing Body"; Code[20])
        {
            Caption = 'Statutory Body';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Terms Values".Code;

        }
        field(4; "Issued Date"; Date)
        {
            Caption = 'Issued Date';
            DataClassification = ToBeClassified;

        }
        field(5; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = ToBeClassified;

        }
        field(6; "Notify Before"; Date)
        {
            Caption = 'Notify Before';
            DataClassification = ToBeClassified;

        }
        field(7; "Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; Code)
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