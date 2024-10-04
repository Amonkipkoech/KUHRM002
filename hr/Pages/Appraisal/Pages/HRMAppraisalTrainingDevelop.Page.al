page 69010 "HRM-Appraisal Training Develop"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Training Develop";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Category"; Rec."Training Category")
                {
                    ApplicationArea = All;
                }
                field(KSAR; Rec.KSAR)
                {
                    Caption = 'Knowledge, skills, attitudes required.';
                    ApplicationArea = All;
                }
                field(HOW; Rec.HOW)
                {
                    Caption = 'How could you achieve this?';
                    ApplicationArea = All;
                }
                field(IMPACT; Rec.IMPACT)
                {
                    Caption = 'What impact will this make on your work/ research, what will be the evidence this has been achieved?';
                    ApplicationArea = All;
                }
                field(COMMENTS; Rec.COMMENTS)
                {
                    Caption = 'Manager''s comments & priority:';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

