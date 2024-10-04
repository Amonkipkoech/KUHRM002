page 80201 "PRL-NSSF"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "PRL-NSSF";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Amount Type"; Rec."Amount Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Tier I Limit"; Rec."Tier I Limit")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}