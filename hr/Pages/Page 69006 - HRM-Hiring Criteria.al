page 69006 "HRM-Hiring Criteria"
{
    PageType = List;
    SourceTable = "HRM-Hiring Criteria";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = All;
                }
                field("Hiring Criteria"; Rec."Hiring Criteria")
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

