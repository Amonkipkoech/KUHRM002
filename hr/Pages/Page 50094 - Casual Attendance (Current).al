page 50094 "Casual Attendance (Current)"
{
    CardPageID = "Staff Ledger Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Casuals Attendance Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Caption = 'Attendance Date';
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    ApplicationArea = All;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Comment By"; Rec."Comment By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

