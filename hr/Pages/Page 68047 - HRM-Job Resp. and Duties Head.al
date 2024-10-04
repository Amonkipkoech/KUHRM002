page 68047 "HRM-Job Resp. and Duties Head"
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
                field("Job ID"; Rec."Job ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                part(Control1000000008; "HRM-Job Resp./Duties Lines")
                {
                    SubPageLink = "Job ID" = FIELD("Job ID");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

