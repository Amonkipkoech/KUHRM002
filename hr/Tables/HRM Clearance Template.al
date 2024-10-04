table 50080 "HRM Clearance Template"
{
    DrillDownPageId = "HRM Clearance Template";
    LookupPageId = "HRM Clearance Template";

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {

            // NotBlank = true;
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)";

            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // var
            //     employee: Record "HRM-Employee C";
            // begin
            //     if employee.Get("Employee No.") then
            //         "Employee Name" := employee.Names;
            // end;

        }
        field(3; "Employee Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee (D)".Names where("No." = field("Employee No.")));

        }
        field(4; "Clearance Area"; Enum "HRM Clearance Area")
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Responsibility Center"; Code[30])
        {
            TableRelation = "Responsibility Center";
        }
        field(6; Sequence; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Form Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Clearance Form No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Line No.", "Employee No.", "Clearance Area")
        {
            Clustered = true;
        }
        key(key2; "Employee No.", "Clearance Area")
        {

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