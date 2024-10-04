page 50065 "HRM-Staff Categories"
{
    PageType = List;
    SourceTable = "HRM-Staff Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = all;
                }
                field("Category Description"; Rec."Category Description")
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

