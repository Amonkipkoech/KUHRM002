page 68080 "PRL-Payroll Type"
{
    PageType = List;
    SourceTable = "PRL-Payroll Type";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = all;
                }
                field("Payroll Name"; Rec."Payroll Name")
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("Period Length"; Rec."Period Length")
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

