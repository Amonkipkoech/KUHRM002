page 69008 "HRM-Appraisal Evaluation Line"
{
    PageType = ListPart;
    SourceTable = "HRM-Training Evaluation Action";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Action; Rec.Action)
                {
                    ApplicationArea = All;
                }
                field("How to implement"; Rec."How to implement")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
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

