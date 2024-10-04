page 68382 "HRM-Disciplinary Actions"
{
    PageType = ListPart;
    SourceTable = "HRM-Disciplinary Actions";

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
                field(Terminate; Rec.Terminate)
                {
                    ApplicationArea = All;
                }
                field(Document; Rec.Document)
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

