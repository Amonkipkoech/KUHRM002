page 68735 "HRM-Job Shortlist Qualif."
{
    PageType = List;
    SourceTable = "HRM-ShortListQualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("ShortList Type"; Rec."ShortList Type")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

