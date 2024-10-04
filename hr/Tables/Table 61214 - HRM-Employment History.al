table 61214 "HRM-Employment History3"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; From; code[20])
        {
            Caption = 'From Date';
            NotBlank = false;
        }
        field(3; "To Date"; code[20])
        {
            NotBlank = false;
        }
        field(4; "Company Name"; Text[150])
        {
            Caption = 'Institution';

            NotBlank = false;
            //TableRelation = "HRM-Institutions"."Institution Code";
        }
        field(5; "Postal Address"; Text[40])
        {
        }
        field(6; "Address 2"; Text[40])
        {
        }
        field(7; "Job Title"; Text[150])
        {
        }
        field(8; "Key Experience"; Text[150])
        {
        }
        field(9; "Salary On Leaving"; Decimal)
        {
        }
        field(10; "Reason For Leaving"; Text[150])
        {
        }
        field(16; Comment; Text[200])
        {

            FieldClass = Normal;
        }


        field(17; "Academic Rank"; Code[50])
        {
        }
        field(18; "Employement Category"; Option)
        {
            OptionMembers = " ","Full-Time","Part-Time","Casual";
            OptionCaption = ' , FULL TIME, PART TIME, CASUAL';
        }
        field(19; "Division Of Appointment"; Option)
        {
            OptionMembers = Academics,Administrative;
        }
        field(20; "Shortcut Dimension 1"; Option)
        {
            Caption = 'Campus Code';
            OptionMembers = "0","3";

            trigger OnValidate()
            begin
                if Rec."Shortcut Dimension 1" = Rec."Shortcut Dimension 1"::"0"
                then
                    Rec."Campus Name" := 'LANGATA';

                if Rec."Shortcut Dimension 1" = Rec."Shortcut Dimension 1"::"3"
                then
                    Rec."Campus Name" := 'NGABA';

            end;

        }
        field(21; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));



        }
        field(22; "Faculty Name"; Text[150])
        {

        }
        field(23; "Department Code"; Code[20])
        {

            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(24; "Department Name"; Text[150])
        {


        }
        field(25; "Job Category"; Code[30])
        {
            Caption = 'Job Cadre';

            TableRelation = "HRM-Employee Categories".Code;
        }
        field(26; "Job Group"; Code[20])
        {
            Caption = 'Job Group';
            TableRelation = "HRM-Auto Inreament Sal. Steps"."Stage Code" WHERE("Employee Category" = FIELD("Job Category"));
        }



        field(27; "Supervisor ID"; Code[20])
        {


            TableRelation = "HRM-Employee (D)"."No.";

            // trigger OnValidate()
            // var
            // hrmemp : Record "HRM-Employee C";
            // begin
            //     if hrmemp.get("Supervisor ID")
            // end;

        }
        field(28; "Supervisor Name"; Code[20])
        {


        }
        field(29; "Date of Confirmation"; code[20])
        {


        }
        field(30; "Terms of Service"; Option)
        {
            OptionMembers = " ","Permanent",Contract,Casual;

        }
        field(31; "Duration of Contract"; Integer)
        {
            Caption = 'Duration of Contract in Months';
        }
        field(32; "Date of Last Promotion"; Code[20])
        {
            Caption = 'Date of Last Promotion/Retirement Notification Date';
        }
        field(33; "Institution Code"; Text[150])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Campus Name';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(34; "Supervisor Title"; Text[100])
        {

        }
        field(35; "Current Job"; Boolean)
        {

        }
        field(36; "Campus Name"; Text[30])
        {

        }
        field(37; "Contract Expiry Date"; Date)
        {

        }
        field(38; "Previous/Current"; Option)
        {
            OptionMembers = " ",P,C;
        }
        field(39; "Contract Expiry Noti. Date"; Date)
        {
            Caption = 'Contract Expiry Notification Date';
        }
        field(40; Probation; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(41; "Probation Start Date"; Date)
        {

        }
        field(42; "Probation End Date"; Date)
        {

        }
    }

    keys
    {
        key(Key1; "Employee No.", "Job Title")
        {
        }
        // key(Key2; "Job Title", "Institution Code")
        // {

        // }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HRM-Employee (D)";
        OK: Boolean;
        period: Duration;
        tday: Record Date;

    local procedure getDuration()
    begin
        // Rec.TestField(From);
        // Rec.TestField("To Date");

        // if From > "To Date" then Error('Invalid Dates');

        // period := "To Date" - From;



    end;
}

