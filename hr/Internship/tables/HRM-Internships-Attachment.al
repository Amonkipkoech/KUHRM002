table 75020 "HRM-Internships&Attachments"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Institution; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ID No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Ref No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Year Of Study"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Age; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF (("Date Of Birth"<>0D) AND ("Date Of Join" <> 0D)) THEN BEGIN  Age:= Dates.DetermineAge("Date Of Birth","Date Of Join");
                    END;
                    IF ("Date Of Leaving" <> 0D) AND ("Date Of Join" <> 0D) THEN
                      "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");*/

            end;
        }
        field(9; Course; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Department; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Period; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Renewable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Disability; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Period Of Service"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Date Of Join"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF (("Date Of Birth"<>0D) AND ("Date Of Join" <> 0D)) THEN BEGIN
                  "Date Of Join":=0D;
                  Age:= Dates.DetermineAge("Date Of Birth","Date Of Join");
                  END;*/

            end;
        }
        field(20; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Attachment,Internship;
        }
        field(21; "Role 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Role 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Role 3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Role 4"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Role 5"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Internship Status"; Option)
        {
            Caption = 'Pending, pending Approval, Approved,Completed';
            OptionMembers = pending,"Pending Approval",Approved,Completed;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Dates: Codeunit "HR Dates";
}