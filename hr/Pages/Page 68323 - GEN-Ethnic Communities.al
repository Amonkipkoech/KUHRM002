page 68323 "GEN-Ethnic Communities"
{
    PageType = ListPart;
    SourceTable = "HRM-Hiring Criteria";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = All;
                }
                field("Hiring Criteria"; Rec."Hiring Criteria")
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

