table 50014 "HRM-Staff Clearance Form"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HRM Clearance Form";
    LookupPageId = "HRM Clearance Form";

    fields
    {
        field(1; "Clearance Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            // NotBlank = true;
        }
        field(2; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)";
        }
        field(3; "Teaching/NonTeaching"; Option)
        {
            OptionMembers = " ",Teaching,NonTeaching;

        }
        field(4; "Examination Booklet"; Option)
        {
            Caption = 'Examinations Booklet & Mark Sheets submitted';
            OptionMembers = " ","N/A",yes,No;

        }
        field(5; "Teaching Material submitted"; Option)
        {
            Caption = 'Teaching Material submitted';
            OptionMembers = " ","N/A",yes,No;

        }
        field(6; "Examinations submitted"; Option)
        {
            Caption = 'Examinations submitted';
            OptionMembers = " ","N/A",yes,No;

        }
        field(7; "Supervisions & Assignments"; Option)
        {
            Caption = 'Supervisions & Any Assignments Handed Over';
            OptionMembers = " ","N/A",yes,No;

        }
        field(8; "Equipment Returned"; Option)
        {
            Caption = 'Equipment Returned';
            OptionMembers = " ","N/A",yes,No;

        }
        field(9; "Office Handed Over"; Option)
        {
            Caption = 'Office Handed Over';
            OptionMembers = " ","N/A",yes,No;

        }
        field(10; "Handing Over Report Submitted"; Option)
        {
            Caption = 'Handing Over Report Submitted';
            OptionMembers = " ","N/A",yes,No;
        }
        field(11; "Staff ID"; Code[20])
        {
            Caption = 'HOD Staff ID';
            TableRelation = "HRM-Employee (D)";
        }
        field(12; "Date of Clearance by HoD"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Store Equipment returned"; Option)
        {
            Caption = 'Store Equipment returned';
            OptionMembers = " ",yes,No;

        }
        field(14; "Store Officer Staff ID"; Code[20])
        {
            Caption = 'Clearing Stores Officer Staff ID';

            DataClassification = ToBeClassified;

        }
        field(15; "Date of Clearance Stores"; Date)
        {
            Caption = 'Date of Clearance by Stores Officer';
            DataClassification = ToBeClassified;

        }
        field(16; "Equip issued returned"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;

        }
        field(17; "Items Issued Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(18; "Maintenance Officer ID"; Code[20])
        {
            Caption = 'Clearing Maintenance officer Staff ID';

            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)";

        }
        field(19; "Date Cleared By Maintenance"; Date)
        {
            Caption = 'Date of Clearance by Maintenance Officer';
            DataClassification = ToBeClassified;

        }
        field(20; "Sacco Clearance"; Option)
        {
            Caption = 'Clearance by Waumini Sacco/AMECEA Sacco';
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;

        }
        field(21; "SACCO Representative ID"; Code[20])
        {
            Caption = 'Sacco Unit Representative Staff ID';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)";

        }
        field(22; "Date Cleared By Sacco Rep"; Date)
        {
            Caption = 'Date of Clearance by Sacco Representative';
            DataClassification = ToBeClassified;
        }
        field(23; "Books Borrowed"; Option)
        {
            Caption = 'Borrowed Books';
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;

        }
        field(24; "OverDue Charges"; Decimal)
        {
            Caption = 'OverDue Charges';
            DataClassification = ToBeClassified;
            //OptionMembers = " ",yes,No;

        }
        field(25; "Librarian Staff ID"; Code[20])
        {
            Caption = 'Clearing University Librarian Staff ID';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee (D)";
            //OptionMembers = " ",yes,No;

        }
        field(26; "Date of Clearance Librarian"; Date)
        {
            Caption = 'Date of Clearance by University Librarian';
            DataClassification = ToBeClassified;

            //OptionMembers = " ",yes,No;

        }
        field(27; "Petty Cash Surrender"; Option)
        {
            Caption = 'Petty Cash Surrender';
            DataClassification = ToBeClassified;

            OptionMembers = " ",yes,No;

        }
        field(28; "Credit Control"; Option)
        {
            Caption = 'Credit Control';
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }
        field(29; "Clearing CFO ID"; Code[20])
        {
            Caption = 'Clearing CFO Staff ID';
            TableRelation = "HRM-Employee (D)";
            DataClassification = ToBeClassified;
            //  OptionMembers = " ",yes,No;
        }
        field(30; "Date Cleared By CFO"; Date)
        {
            Caption = 'Date of Clearance by the CFO';
            //  TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            //  OptionMembers = " ",yes,No;
        }
        field(31; "Outstanding CUEA Loans"; Option)
        {
            Caption = 'Outstanding CUEA Loans';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }

        field(32; "Outstanding salary Advances"; Option)
        {
            Caption = 'Outstanding salary Advances';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }
        field(33; "Outstanding Arrears"; Option)
        {
            Caption = 'Outstanding Arrears';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }
        field(34; "Payroll Officer Staff ID"; Code[20])
        {
            Caption = 'Clearing Payroll Officer Staff ID';
            TableRelation = "HRM-Employee (D)";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }
        field(35; "Date  Cleared by Payroll"; Date)
        {
            Caption = 'Date of Clearance by Payroll Officer';
            //TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }



        field(36; "Rights to systems disabled"; Option)
        {
            Caption = 'Rights to systems and staff e-mail disabled';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }
        field(37; "Clearing ICT officer Staff ID"; Code[20])
        {
            Caption = 'Clearing ICT officer Staff ID';
            TableRelation = "HRM-Employee (D)";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }
        field(38; "Date of Clearance by ICT"; Date)
        {
            Caption = 'Date of Clearance by ICT Officer';
            //TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }



        field(40; "Medical cards/Staff ID Retrned"; Option)
        {
            Caption = 'All Medical cards and Staff ID Returned';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }
        field(41; "Clearing Medical Officer"; Code[20])
        {
            Caption = 'Clearing Medical officer Staff ID';
            TableRelation = "HRM-Employee (D)";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }
        field(42; "Date  Cleared by Med.Office"; Date)
        {
            Caption = 'Date of Clearance by Medical Office';
            //TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }

        field(43; "Clearance by the HR Manager"; Option)
        {
            Caption = 'Clearance by the HR Manager';
            // TableRelation = "HRM-Employee C";
            DataClassification = ToBeClassified;
            OptionMembers = " ",yes,No;
        }

        field(44; "HRM Staff ID"; Code[20])
        {
            Caption = 'HRM Staff ID';
            TableRelation = "HRM-Employee (D)";
            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }
        field(45; "HRM Clearance Date"; Date)
        {
            Caption = 'HRM Clearance Date';

            DataClassification = ToBeClassified;
            //    OptionMembers = " ",yes,No;
        }
        field(46; "Clearance Status"; Option)
        {
            OptionMembers = Academic,Maintence,Library,Finance,ICT,Medical,HRM;
        }
        field(47; Department; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(48; "Staff Name"; Text[200])
        {

        }
        field(49; "Status Of Clearence"; Option)
        {
            OptionMembers = " ",Hold,"Partially Cleared","Fully cleared";
        }
        field(50; "Clearence Comment"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Clearance Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        hrmSetUp: Record "HRM-Setup";
        noseriesmngt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin

        if hrmSetUp.Get() then begin
            hrmSetUp.TestField("Staff Clearance");

            "Clearance Code" := noseriesmngt.GetNextNo(hrmSetUp."Staff Clearance", Today, true);
        end;
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