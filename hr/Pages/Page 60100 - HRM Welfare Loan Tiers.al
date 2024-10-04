page 60100 "HRM Welfare Loan Tiers"
{
    PageType = List;
    SourceTable = "HRM Welfare Loan Tiers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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

