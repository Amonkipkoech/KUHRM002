page 75035 "HRM-Appraisal Setup 3"
{
    PageType = Card;
    SourceTable = 75014;

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

