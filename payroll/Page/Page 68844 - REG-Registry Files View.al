page 68844 "REG-Registry Files View"
{
    Editable = false;
    PageType = List;
    SourceTable = "REG-Registry Files";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Subject/Description"; Rec."File Subject/Description")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Maximum Allowable Files"; Rec."Maximum Allowable Files")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                    ApplicationArea = All;
                }
                field("Issuing Officer"; Rec."Issuing Officer")
                {
                    ApplicationArea = All;
                }
                field("Circulation Reason"; Rec."Circulation Reason")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field("Receiving Officer"; Rec."Receiving Officer")
                {
                    ApplicationArea = All;
                }
                field("Delivery Officer"; Rec."Delivery Officer")
                {
                    ApplicationArea = All;
                }
                field("File Status"; Rec."File Status")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Status"; Rec."Dispatch Status")
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

