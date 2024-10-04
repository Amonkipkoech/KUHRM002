page 68040 "HRM-Score Setup"
{
    PageType = Worksheet;
    SourceTable = "HRM-Score Setup";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
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

