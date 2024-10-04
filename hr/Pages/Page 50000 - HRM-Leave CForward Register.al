page 50000 "HRM-Leave CForward Register"
{
    PageType = List;
    SourceTable = "HRM-Leave CForward Register";

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;

                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;

                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;

                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Leave Balances")
            {
                ApplicationArea = All;
                Caption = 'Generate Leave Balances';
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;

                trigger OnAction()
                begin
                    //if Confirm('Generate annual Leave balances?', true) = false then exit;
                    //Clear(counts);
                    //should check 
                    //1. employee's leave balance, assign to a variable - leavebal
                    //2. check the end of a financial year - finyr
                    //3. if leavebal>15 add to leavejournal table
                    CODEUNIT.Run(50000);
                end;
            }
        }
    }

    var
        myInt: Integer;
        counts: Integer;
}