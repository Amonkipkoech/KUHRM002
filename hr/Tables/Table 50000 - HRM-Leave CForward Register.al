table 50000 "HRM-Leave CForward Register"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Staff No."; Text[250])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if emp.Get("Staff No.") then
                    "Staff Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(3; "Staff Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Leave Type"; Code[20])
        {
            trigger OnValidate()
            begin
                "Leave Type" := 'Annual Leave';
            end;
        }
        field(5; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Allocation,Application,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ",Allocation,Application,"Positive Adjustment","Negative Adjustment";
        }
        field(8; "Document No."; Code[20])
        {
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(10; "Leave Period"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
    var
        emp: Record "HRM-Employee (D)";
}

