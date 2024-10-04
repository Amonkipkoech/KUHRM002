page 75045 "HRM-Appraisal Category"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Category";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Code; Rec.Code)
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

