page 68439 "HRM-Posting Groups"
{
    PageType = ListPart;
    SourceTable = "HRM-Posting Groups";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Training Debit Account"; Rec."Training Debit Account")
                {
                    ApplicationArea = All;
                }
                field("Training Credit A/C Type"; Rec."Training Credit A/C Type")
                {
                    ApplicationArea = All;
                }
                field("Training Credit Account"; Rec."Training Credit Account")
                {
                    ApplicationArea = All;
                }
                field("Comp. Act. Debit Account"; Rec."Comp. Act. Debit Account")
                {
                    ApplicationArea = All;
                }
                field("Comp. Act. Credit A/C Type"; Rec."Comp. Act. Credit A/C Type")
                {
                    ApplicationArea = All;
                }
                field("Comp. Act. Credit Account"; Rec."Comp. Act. Credit Account")
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

