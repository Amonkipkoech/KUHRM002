page 68081 "PRL-Salary Grades"
{
    PageType = Card;
    SourceTable = "HRM-Salary Grades";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Amount"; Rec."Salary Amount")
                {
                    ApplicationArea = all;
                }
                field("Weekly Hours"; Rec."Weekly Hours")
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

