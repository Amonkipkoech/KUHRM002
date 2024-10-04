page 68400 "HRM-J. Specification"
{
    PageType = Document;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
            }
            part(KPA; "HRM-Job Requirement Lines (B)")
            {
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
            field(Control1000000006; '')
            {
                CaptionClass = Text19024070;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        Text19024070: Label 'Job Specification';
}

