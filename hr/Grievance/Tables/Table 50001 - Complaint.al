table 50001 Complaint
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "PF No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HREmployee.RESET;
                HREmployee.SETRANGE(HREmployee."No.", "PF No");
                IF HREmployee.FIND('-') THEN BEGIN
                    FullName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                END;
            end;
        }
        field(3; FullName; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Region Code"; Text[50])
        {
            CaptionClass = '1,2,3';
            // Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the 2nd global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Region Code");
                IF DimVal.FIND('-') THEN
                    Dim2 := DimVal.Name
            end;
        }
        field(12; Dim2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cost Center Code"; Text[50])
        {
            CaptionClass = '1,2,3';
            //Caption = 'Shortcut Dimension 1 Code';
            Description = 'Stores the reference of the First global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Cost Center Code");
                IF DimVal.FIND('-') THEN
                    Dim1 := DimVal.Name
            end;
        }
        field(10; Dim1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; RegionCode; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Phone; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; SubmittedTo; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; DateSubmitted; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Posted,Processing,Closed';
            OptionMembers = Open,Pending,Approved,Posted,Processing,Closed;
        }
        field(14; Details; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        HREmployee: Record "HRM-Employee (D)";
        DimVal: Record "Dimension Value";

    trigger OnInsert()
    begin
        DateSubmitted := Today;
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