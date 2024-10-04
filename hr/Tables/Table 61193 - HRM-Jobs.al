table 61193 "HRM-Jobs"
{
    DrillDownPageID = "HRM-Jobs List";
    LookupPageID = "HRM-Jobs List";

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Job Description"; Text[100])
        {
            Editable = true;
        }
        field(3; "No of Posts"; Integer)
        {

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                    "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4; "Position Reporting to"; Code[50])
        {
            //TableRelation = "HRM-Jobs"."Job ID" WHERE(Status = CONST(Approved));
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE("Job Title" = FIELD("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Positions"; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7; "Score code"; Code[20])
        {
        }
        field(8; "Directorate Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Directorate Code");
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }

        field(9; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,1,2';
            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(19; "Main Objective"; Text[250])
        {
        }
        field(21; "Key Position"; Boolean)
        {
        }
        field(22; Category; Code[20])
        {
        }
        field(23; Grade; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = Count("HRM-Employee Requisitions" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(27; UserID; Code[50])
        {
        }
        field(28; "Supervisor/Manager"; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Get("Supervisor/Manager");
                "Supervisor Name" := HREmp.FullName;
            end;
        }
        field(29; "Supervisor Name"; Text[30])
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(32; "Date Created"; Date)
        {
        }
        field(33; "No. of Requirements"; Integer)
        {
            CalcFormula = Count("HRM-Job Requirements" WHERE("Job Id" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(34; "No. of Responsibilities"; Integer)
        {
            CalcFormula = Count("HRM-Job Responsiblities (B)" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(35; "Reason for Job creation"; Text[200])
        {
        }
        field(36; "Memo Ref No."; Code[100])
        {
        }
        field(37; "Memo Approval Date"; Date)
        {
        }
        field(38; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Station Code");
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50000; "Station Name"; Text[100])
        {
            Editable = false;
        }
        field(50001; "Directorate Name"; Text[100])
        {
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(50002; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50003; "Employment Category"; Code[20])
        {
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(50004; "Employment Grade"; Code[20])
        {
            TableRelation = "HRM-Job_Salary grade/steps"."Salary Grade code" WHERE("Employee Category" = FIELD("Employment Category"));

            trigger OnValidate()
            begin
                Grade := "Employment Grade";
            end;
        }
        field(50005; "Job Reference Number"; Text[50])
        {

        }
        field(50006; "Division"; Option)
        {
            OptionMembers = Academic,Administrative;
        }
        field(10; "Job Title"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Job Type"; Option)
        {
            OptionMembers = " ",Teaching,"Non Teaaching";
        }

    }

    keys
    {
        key(Key1; "Job ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job Description")
        {
        }
    }

    trigger OnDelete()
    begin
        /*
         CALCFIELDS("Occupied Positions");
         IF "Occupied Positions">0 THEN
         ERROR('Cannot delete job if it has occupants');
          */

    end;

    trigger OnInsert()
    begin
        UserID := UserID;
        "Date Created" := Today;
    end;

    trigger OnModify()
    begin
        /* CALCFIELDS("Occupied Positions");
         IF "Occupied Positions">0 THEN
         ERROR('Cannot modify job if it has occupants');
        */

    end;

    var
        NoOfPosts: Decimal;
        HREmp: Record "HRM-Employee (D)";
        Dimn: Record "Dimension Value";
}

