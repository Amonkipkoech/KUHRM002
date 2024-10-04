page 68083 "PRL-Pension Contrib. Details"
{
    PageType = Card;
    SourceTable = "PRL-Pension Details";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Inception Date"; Rec."Inception Date")
                {
                    ApplicationArea = all;
                }
                field("Pension Number"; Rec."Pension Number")
                {
                    ApplicationArea = all;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = all;
                }
                field("Transaction Code"; Rec."Transaction Code")
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

