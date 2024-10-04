page 68333 "HRM-Job Occupants"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "HRM-Jobs";

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = false;
                field("Job ID"; Rec."Job ID")
                {
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
            }

        }
        area(factboxes)
        {

            systempart(Control1102755003; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print HR Job Occupants")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //todo RunObject = Report "HR Job Occupants";

                trigger OnAction()
                begin
                    //Display report
                    HrJob.SetRange(HrJob."Job id", Rec."Job ID");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty then
            Error('No jobs have been setup');
    end;

    var
        Text19006026: Label 'Job Occupants';
        HrJob: Record "HRM-Jobs per Dimension";
}

