page 61693 "HRM-Appraisal Period Sets"
{
    PageType = List;
    SourceTable = 75017;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Order; Rec.Order)
                {
                    ApplicationArea = All;
                }
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = All;
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
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

