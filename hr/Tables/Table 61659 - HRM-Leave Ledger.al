table 61659 "HRM-Leave Ledger"
{
    DrillDownPageID = "HRM-Leave Ledger View";
    LookupPageID = "HRM-Leave Ledger View";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(8; "Entry No."; Integer)
        {
        }
        field(9; "Document No"; Code[30])
        {
        }
        field(10; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code;
        }
        field(11; "Transaction Date"; Date)
        {
        }
        field(12; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Allocation,Application,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ",Allocation,Application,"Positive Adjustment","Negative Adjustment";
        }
        field(13; "No. of Days"; Decimal)
        {
        }
        field(14; "Transaction Description"; Text[250])
        {
        }
        field(15; "Leave Period"; Integer)
        {
        }
        field(16; "Entry Type"; Option)
        {
            OptionCaption = 'Application,Allocation';
            OptionMembers = Application,Allocation;
        }
        field(17; "Created By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(18; "Reversed By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(19; "Allocation Month"; Integer)
        {
            // TableRelation = "User Setup"."User ID";
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
        }
        field(20; "Allocation Year"; Integer)
        {
            // TableRelation = "User Setup"."User ID";
            MinValue = 2021;
            MaxValue = 2050;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No")
        {
        }
        key(Key2; "Employee No", "Leave Type")
        {
            SumIndexFields = "No. of Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;
}

