table 61618 "HRM-Employee Leave Journal"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Staff No."; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            /* trigger OnValidate()
            begin
                if emp.Get("Staff No.") then
                    "Staff Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end; */
        }
        field(3; "Staff Name"; Text[250])
        {
            trigger OnValidate()
            begin
                if emp.Get("Staff No.") then
                    "Staff Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(4; "Transaction Description"; Text[150])
        {
        }
        field(5; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code;
        }
        field(6; "No. of Days"; Decimal)
        {
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
        field(20; "Allocation Month"; Integer)
        {
            // TableRelation = "User Setup"."User ID";
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
        }
        field(21; "Allocation Year"; Integer)
        {
            // TableRelation = "User Setup"."User ID";
            MinValue = 2021;
            MaxValue = 2050;
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

