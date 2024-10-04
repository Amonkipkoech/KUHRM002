page 68395 "HRM-Position Supervised"
{
    PageType = ListPart;
    SourceTable = "HRM-Position Supervised";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Position Supervised"; Rec."Position Supervised")
                {
                    Caption = 'Job ID';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

