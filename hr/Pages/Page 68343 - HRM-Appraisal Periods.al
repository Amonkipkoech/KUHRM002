page 68343 "HRM-Appraisal Periods"
{
    PageType = Worksheet;
    SourceTable = "HRM-Appraisal Periods";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Period; Rec.Period)
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

