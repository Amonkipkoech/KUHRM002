table 70031 "HR Asset Transfer Lines"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                IF fasset.GET("Asset No.") THEN BEGIN
                    //    "Asset Bar Code":=fasset."Bar Code";
                    "Asset Description" := fasset.Description;
                    "FA Location" := fasset."FA Location Code";
                    "Responsible Employee Code" := fasset."Responsible Employee";

                    IF HRTAB.GET("Responsible Employee Code") THEN "Employee Name" := HRTAB."First Name" + ' ' + HRTAB."Last Name";
                    "Asset Serial No" := fasset."Serial No.";
                    "Global Dimension 1 Code" := fasset."Global Dimension 1 Code";

                    //    "Global Dimension 2 Code":=fasset.Donor;
                    // "Global Dimension 3 Code":=fasset.Facility;
                    //  "Asset Bar Code":=fasset."Tag No";
                    //fasset.CALCFIELDS("Book Value");
                    "Book Value" := fasset."Book Value";

                    /* IF DepreBook.GET("Asset No.")        THEN
                       CALCFIELDS("Book Value");
                     "Book Value":=DepreBook."Book Value";
                     */
                END;

            end;
        }
        field(3; "Asset Bar Code"; Code[50])
        {
        }
        field(4; "Asset Description"; Text[200])
        {
        }
        field(5; "FA Location"; Code[80])
        {
            TableRelation = "FA Location";
        }
        field(6; "Responsible Employee Code"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HRTAB.RESET;
                IF HRTAB.GET("Responsible Employee Code") THEN BEGIN
                    "Employee Name" := HRTAB."First Name" + ' ' + HRTAB."Last Name";
                END ELSE BEGIN
                    "New Employee Name" := '';
                END;
            end;
        }
        field(7; "Asset Serial No"; Text[50])
        {
        }
        field(8; "Employee Name"; Text[50])
        {
        }
        field(9; "Reason for Transfer"; Text[50])
        {
        }
        field(10; "New Responsible Employee Code"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin

                HRTAB.RESET;
                IF HRTAB.GET("New Responsible Employee Code") THEN BEGIN
                    "New Employee Name" := HRTAB."First Name" + ' ' + HRTAB."Last Name";
                END ELSE BEGIN
                    "New Employee Name" := '';
                END;
            end;
        }
        field(11; "New Employee Name"; Text[100])
        {
        }
        field(12; "Global Dimension 1 Code"; Code[50])
        {
            Caption = 'Current Project Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "Global Dimension 1 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 1 Name" := Dimn.Name;
                END;
            end;
        }
        field(13; "New Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "New Global Dimension 1 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 1 Name" := Dimn.Name;
                END;
            end;
        }
        field(14; "Global Dimension 2 Code"; Code[50])
        {
            Caption = 'Current Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "Global Dimension 2 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 2 Name" := Dimn.Name;
                END;
            end;
        }
        field(15; "New Global Dimension 2 Code"; Code[50])
        {
            Caption = 'New Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "New Global Dimension 2 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 2 Name" := Dimn.Name;
                END;
            end;
        }
        field(16; "Global Dimension 3 Code"; Code[50])
        {
            Caption = 'Current Facility Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "Global Dimension 3 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 3 Name" := Dimn.Name;
                END;
            end;
        }
        field(17; "New Global Dimension 3 Code"; Code[50])
        {
            Caption = 'New Facility  Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                Dimn.SETRANGE(Dimn.Code, "New Global Dimension 3 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 3 Name" := Dimn.Name;
                END;
            end;
        }
        field(18; "Dimension 1 Name"; Text[100])
        {
            Caption = 'Current Project Name';
        }
        field(19; "New  Dimension 1 Name"; Text[100])
        {
            Caption = 'New Project Name';
        }
        field(20; "Dimension 2 Name"; Text[100])
        {
            Caption = 'Current Department Name';
        }
        field(21; "New  Dimension 2 Name"; Text[100])
        {
            Caption = 'New Project Name';
        }
        field(22; "Dimension 3 Name"; Text[100])
        {
            Caption = 'Current Station Name';
        }
        field(23; "New  Dimension 3 Name"; Text[100])
        {
            Caption = 'New Station Name';
        }
        field(24; "Is Asset Expected Back?"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(25; "Duration of Transfer"; Text[20])
        {
        }
        field(26; "New Asset Location"; Code[80])
        {
            TableRelation = "FA Location";

            trigger OnValidate()
            begin
                /*fasset.RESET;
                fasset.SETRANGE("No.","Asset No.");
                IF fasset.FINDFIRST THEN
                BEGIN
                fasset."Location Code":="New Asset Location";
                fasset.MODIFY;
                END;
                */

            end;
        }
        field(27; "Book Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Asset No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        fasset: Record "Fixed Asset";
        HRTAB: Record "HRM-Employee (D)";
        PrjctCde: Record "Dimension Value";
        Dimvalu: Integer;
        DepreBook: Record "FA Depreciation Book";
}

