table 86000 "HRM-Employment History"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            begin
                if hrEmp.Get("Employee No.") then begin
                    "Employee Name" := hrEmp."First Name" + hrEmp."Last Name";
                end;
            end;
        }
        field(2; "Academic Rank"; Text[100])
        {

        }
        field(3; "Job Title"; Text[100])
        {

        }
        field(4; "Current or Previous"; Option)
        {
            OptionMembers = " ",C,P;
        }
        field(5; Division; Option)
        {
            OptionMembers = " ",Academic,Administration;
        }
        field(6; "Employment Category"; Option)
        {
            OptionMembers = " ","Full Time","Part Time","Casual";
        }
        field(7; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8; Faculty; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Faculty);
                if Dimn.Find('-') then begin
                    "Faculty Name" := Dimn.Name;
                end;
            end;
        }
        field(9; "Faculty Name"; Text[100])
        {

        }
        field(10; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(11; "Department Name"; Text[100])
        {

        }
        field(12; "Job Category"; code[20])
        {
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(13; "Job Group"; Text[100])
        {
            TableRelation = "HRM-Auto Inreament Sal. Steps"."Salary Grade" WHERE("Employee Category" = FIELD("Job Category"));
        }
        field(14; "Supervisor Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(15; "Supervisor Title"; Text[100])
        {

        }
        field(16; "Date from"; Date)
        {

        }
        field(17; "Date to"; Date)
        {

        }
        field(18; "Date of Confirmation"; Date)
        {

        }
        field(19; "Terms of Service"; Option)
        {
            OptionMembers = Contract,Permanent,Casual,Probation;
        }
        field(20; "Duration Of Contract(Months)"; Decimal)
        {

        }
        field(21; "Date of Last Promotion"; Date)
        {

        }
        field(22; "Contract Expiry Date"; Date)
        {

        }
        field(23; "Contract Expiry Notification"; Date)
        {
            Caption = 'Contract Expiry Notification Date';
        }
        field(24; "Employee Name"; text[250])
        {

        }
        field(25; "Probation start date"; date)
        {
        }
        field(26; "Probation End date"; date)
        {
        }


    }
    keys
    {
        key(Key1; "Employee No.", "Job Title", "Supervisor Staff ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        hrEmp: Record "HRM-Employee (D)";

    trigger OnInsert()
    begin

    end;

    var
        Dimn: Record "Dimension Value";

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
