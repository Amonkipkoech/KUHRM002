page 68387 "HRM-Grades"
{
    PageType = Worksheet;
    SourceTable = "HRM-Grades";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
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

