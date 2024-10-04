page 75046 "HRM-Appraisal Setup"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Res. Setup";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field("Max. Score"; Rec."Max. Score")
                {
                    ApplicationArea = All;
                }
                field("% Contrib. Final Score"; Rec."% Contrib. Final Score")
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

