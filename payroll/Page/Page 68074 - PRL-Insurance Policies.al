page 68074 "PRL-Insurance Policies"
{
    PageType = List;
    SourceTable = "PRL-InsurancePolicies";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Policy Number"; Rec."Policy Number")
                {
                    ApplicationArea = All;
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Deduct premium"; Rec."Deduct premium")
                {
                    ApplicationArea = All;
                }
                field(balance; Rec.balance)
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

