page 68399 "HRM-Training Sources"
{
    PageType = ListPart;
    SourceTable = "HRM-Training Source";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

