page 68812 "HRM-Train Need Analysis List"
{
    CardPageID = "HRM-TNA Card";
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Training Needs Analysis";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = all;
                }
                field("Individual Course"; Rec."Individual Course")
                {
                    ApplicationArea = all;
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = all;
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HRM-Trainings Factbox")
            {
                SubPageLink = "Application No" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

