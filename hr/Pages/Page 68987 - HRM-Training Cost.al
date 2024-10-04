page 68987 "HRM-Training Cost"
{
    PageType = List;
    SourceTable = "HRM-Training Cost";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Id"; Rec."Training Id")
                {
                    ApplicationArea = all;
                }
                field("Training Cost Item"; Rec."Training Cost Item")
                {
                    ApplicationArea = all;
                }
                field(Cost; Rec.Cost)
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

