page 50091 "Casual Staff Attendance View"
{
    CardPageID = "Staff Ledger Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Casuals Attendance Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Applicationarea = all;
                    Caption = 'Attendance Date';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Applicationarea = all;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Applicationarea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Applicationarea = all;
                }
                field(Email; Rec.Email)
                {
                    Applicationarea = all;
                }
                field(Category; Rec.Category)
                {
                    Applicationarea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Applicationarea = all;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    Applicationarea = all;
                }
                field("Time In"; Rec."Time In")
                {
                    Applicationarea = all;
                }
                field("Time Out"; Rec."Time Out")
                {
                    Applicationarea = all;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    Applicationarea = all;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    Applicationarea = all;
                }
                field(Comment; Rec.Comment)
                {
                    Applicationarea = all;
                }
                field("Comment By"; Rec."Comment By")
                {
                    Applicationarea = all;
                }
            }
        }
    }

    actions
    {
    }
}

