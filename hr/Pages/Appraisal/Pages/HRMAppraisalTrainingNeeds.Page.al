page 75042 "HRM-Appraisal Training Needs"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Training Needs";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("PF. No."; Rec."PF. No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Training Need Code"; Rec."Training Need Code")
                {
                    Caption = 'Appraisees training and development needs';
                    ApplicationArea = All;
                }
                field("Duration of Training"; Rec."Duration of Tranning")
                {
                    ApplicationArea = All;
                }
                field("Comments Of staff Trainning";Rec."Comments Of staff Trainning")
                {
                    ApplicationArea = All;
                }
                field("Training offered"; Rec."Training offered")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
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
        HRMAppraisalYears: Record 75001;
        HRMAppraisalPeriods: Record 75016;
        editability: Boolean;
}

