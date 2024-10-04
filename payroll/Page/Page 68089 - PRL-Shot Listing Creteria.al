page 68089 "PRL-Shot Listing Creteria"
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
                field("Stage filter"; Rec."Stage filter")
                {
                    Caption = 'Recruitment Stage filter';
                    ApplicationArea = All;
                }
            }
            part(Control1000000008; "PRL-Short Listing Lines")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

