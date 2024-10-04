page 68392 "HRM-J. Responsiblities"
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
            }
            part(KPA; "HRM-Job Responsiblities")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
            field(Control1000000006; '')
            {
                CaptionClass = Text19035248;
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
        Text19035248: Label 'Key Responsibilities';
}

