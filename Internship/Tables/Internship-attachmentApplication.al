table 50005 "Internship-Attachment Applic"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(7; Code; Code[30])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                  HumanResSetup.GET;
                  NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                  "No. Series" := '';
                END;
                */
                //This is for staff to Library Dataport don't Delete!
                if "Code" <> '' then
                    Category := 'STAFF';

            end;
        }
        field(28; Category; Code[20])
        {

        }
        field(2; "First Name"; Text[50])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
        }
        field(4; "Last Name"; Text[50])
        {
        }
        field(5; "Application Type"; Option)
        {
            OptionMembers = Internship,Attachment;
        }
        field(6; "Application Date"; DateTime)
        {
        }
        field(8; "Institute"; Text[50])
        {
        }
        field(9; "ID Card Number"; Text[50])
        {
        }
        field(10; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(11; Email; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Phone; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Adm No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Insurance Company"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Policy No."; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Postal Address"; Text[100])
        {
        }
        field(17; "Postal Code"; Text[50])
        {
        }
        field(18; "Town"; Text[100])
        {
        }
        field(19; Recommended; Boolean)
        {
        }
        field(20; Status; Option)
        {
            OptionMembers = Open,Pending,Approved;
        }
        field(21; "Disability Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Disability"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; PIN; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Region"; Text[100])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "User Id"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "Code" = '' THEN BEGIN
            /* ACAGeneralSetUp.GET;
            ACAGeneralSetUp.TESTFIELD("Further Info Nos"); //rsk */
            NoSeriesMgt.InitSeries('TSKGROUP', xRec."No. Series", 0D, "Code", "No. Series");
        END;
        "User Id" := USERID;
        "Application Date" := CURRENTDATETIME;
        //Date := TODAY;
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