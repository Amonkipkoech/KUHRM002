page 75037 "HRM-Appraisal Emp Targets-HR"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    Caption = 'Agreed Performance Targets/ Specific Tasks Assignment';
                    ApplicationArea = All;
                }
                field("Expected Performance Indicator"; Rec."Expected Performance Indicator")
                {
                    ApplicationArea = All;
                }
                field("Mid Year Review (Remarks)"; Rec."Mid Year Review (Remarks)")
                {
                    ApplicationArea = All;
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AppraisalReport)
            {
                Caption = 'Appraisal Report';
                Image = AdjustEntries;
                
                ApplicationArea = All;

                trigger OnAction()
                begin
                    HRMAppraisalEmpTargets.RESET;
                    HRMAppraisalEmpTargets.SETRANGE("Appraisal Period Code", Rec."Appraisal Period Code");
                    HRMAppraisalEmpTargets.SETRANGE("Appraisal year Code", Rec."Appraisal year Code");
                    HRMAppraisalEmpTargets.SETRANGE("PF. No.", Rec."PF. No.");
                    IF HRMAppraisalEmpTargets.FIND('-') THEN
                        REPORT.RUN(78900, TRUE, FALSE, HRMAppraisalEmpTargets);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    trigger OnOpenPage()
    begin
        HRMAppraisalYears.RESET;
        HRMAppraisalYears.SETRANGE(Closed, FALSE);
        IF HRMAppraisalYears.FIND('-') THEN
            Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    end;

    var
        UserSetup: Record 91;
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
        HRMAppraisalEmpTargets: Record "HRM-Appraisal Emp. Targets";
}

