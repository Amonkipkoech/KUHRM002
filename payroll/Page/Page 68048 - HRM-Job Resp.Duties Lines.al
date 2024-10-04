page 68048 "HRM-Job Resp./Duties Lines"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Resp/Duties";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Job Responsibilities/Duties"; Rec."Job Responsibilities/Duties")
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

