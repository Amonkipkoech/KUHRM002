page 50072 "Staff Ledger History"
{
    CardPageID = "Staff Ledger Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Staff Attendance Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Visit No."; Rec."Visit No.")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = all;
                }
                field("Office Station/Department"; Rec."Office Station/Department")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    ApplicationArea = all;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = all;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    ApplicationArea = all;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("Comment By"; Rec."Comment By")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

