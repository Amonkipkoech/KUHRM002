page 68344 "HRM-Key Performance Areas"
{
    PageType = Worksheet;
    SourceTable = "HRM-Key Performance Areas";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Self; Rec.Self)
                {
                    ApplicationArea = All;
                }
                field(Reviewer; Rec.Reviewer)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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

