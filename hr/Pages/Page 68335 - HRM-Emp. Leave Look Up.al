page 68335 "HRM-Emp. Leave Look Up"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "HRM-Emp. Leaves";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Acrued Days"; Rec."Acrued Days")
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

