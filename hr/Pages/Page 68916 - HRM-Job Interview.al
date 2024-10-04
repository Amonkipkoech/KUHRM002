page 68916  "HRM-Job Interview"
{
    PageType = List;
    SourceTable = "HRM-Job Interview";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview Code"; Rec."Interview Code")
                {
                    ApplicationArea = All;
                }
                field("Interview Description"; Rec."Interview Description")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field(comments; Rec.comments)
                {
                    ApplicationArea = All;
                }
                field(Interviewer; Rec.Interviewer)
                {
                    ApplicationArea = All;
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("Hiring Criteria")
                {
                    Caption = 'Hiring Criteria';
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "HRM-Hiring Criteria";
                    RunPageLink = "Application Code" = FIELD("Applicant No");
                    ApplicationArea = All;
                }
            }
        }
    }
}

