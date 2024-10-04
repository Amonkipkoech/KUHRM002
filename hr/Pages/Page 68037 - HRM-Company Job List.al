page 68037 "HRM-Company Job List"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = All;
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Job)
            {
                Caption = 'Job';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "HRM-Company Jobs";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    ApplicationArea = All;
                }
            }
        }
    }
}

