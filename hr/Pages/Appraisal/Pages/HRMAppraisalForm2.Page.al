page 68449 "HRM-Appraisal Form 2"
{
    PageType = Document;
    SourceTable = "HRM-Employee Appraisals";

    layout
    {
        area(content)
        {
            part(Part1; "HRM-Performance Plan")
            {
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Type" = FIELD("Appraisal Type"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(Part2; "HRM-Career Developement Plan")
            {
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Type" = FIELD("Appraisal Type"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
            field("Agreement With Rating"; Rec."Agreement With Rating")
            {
                ApplicationArea = All;
            }
            field("General Comments"; Rec."General Comments")
            {
                ApplicationArea = All;
            }
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
            }
            label(Lab10)
            {
                CaptionClass = Text19024403;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            label(Lab11)
            {
                CaptionClass = Text19066736;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            label(Lab12)
            {
                CaptionClass = Text19023489;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
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
                    EmployeeAppraisals.RESET;
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Employee No", Rec."Employee No");
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Appraisal Type", Rec."Appraisal Type");
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Appraisal Period", Rec."Appraisal Period");
                    IF EmployeeAppraisals.FIND('-') THEN
                        REPORT.RUNMODAL(60004, TRUE, FALSE, EmployeeAppraisals);
                end;
            }
        }
    }

    var
        EmployeeAppraisals: Record "HRM-Employee Appraisals";
        Text19023489: Label 'Performance Plan (Part 1- Agreed Key Indicators)';
        Text19066736: Label 'Career Development Plan (Part 2 - To be established by both officer and supervisor)';
        Text19024403: Label 'Staff Member Review (Part 3 - Review of Ratings/Assessment by Supervisor )';
}

