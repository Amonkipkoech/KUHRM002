page 68036 "HRM-Company Jobs"
{
    PageType = Document;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            field("Job ID"; Rec."Job ID")
            {
                ApplicationArea = All;
            }
            field("Job Description"; Rec."Job Description")
            {
                ApplicationArea = All;
            }
            field("Position Reporting to"; Rec."Position Reporting to")
            {
                ApplicationArea = All;
            }
            field("Dimension 1"; Rec."Dimension 1")
            {
                ApplicationArea = All;
            }
            field("Dimension 2"; Rec."Dimension 2")
            {
                ApplicationArea = All;
            }
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;
            }
            field(Objective; Rec.Objective)
            {
                Caption = 'Objective/Function';
                MultiLine = true;
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
            field("Vacant Posistions"; Rec."Vacant Posistions")
            {
                Caption = 'Vacant Positions';
                Editable = false;
                ApplicationArea = All;
            }
            field("Key Position"; Rec."Key Position")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {

                Caption = 'Job';
                action("Position Supervised")
                {
                    ApplicationArea = all;
                    Caption = 'Position Supervised';
                    RunObject = Page "HRM-J. Position Supervised";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Job Specification")
                {
                    ApplicationArea = all;
                    Caption = 'Job Specification';
                    RunObject = Page "HRM-J. Specification";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Key Responsibilities")
                {
                    ApplicationArea = all;
                    Caption = 'Key Responsibilities';
                    RunObject = Page "HRM-J. Responsiblities";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Working Relationships")
                {
                    ApplicationArea = all;
                    Caption = 'Working Relationships';
                    RunObject = Page "HRM-J. Working Relationships";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                separator(Separator1000000025)
                {
                }
                action("Vacant Positions")
                {
                    ApplicationArea = all;
                    Caption = 'Vacant Positions';
                    RunObject = Page "HRM-Vacant Positions";
                }
                action("Over Staffed Positions")
                {
                    ApplicationArea = all;
                    Caption = 'Over Staffed Positions';
                    RunObject = Page "HRM-Over Staffed Positions";
                }
            }
        }
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Jobs.Reset;
                    Jobs.SetRange(Jobs."Job ID", Rec."Job ID");
                    if Jobs.Find('-') then
                        REPORT.RunModal(60003, true, false, Jobs);
                end;
            }
        }
    }

    var
        Jobs: Record "HRM-Company Jobs";
}

