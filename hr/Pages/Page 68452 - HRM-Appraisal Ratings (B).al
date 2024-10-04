page 68452 "HRM-Appraisal Ratings (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Ratings";
    SourceTableView = SORTING("Up To")
                      ORDER(Descending);

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
                field("Up To"; Rec."Up To")
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

