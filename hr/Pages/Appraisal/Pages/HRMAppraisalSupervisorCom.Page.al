page 75044 "HRM-Appraisal Supervisor Com."
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 75012;

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = All;
                }
                field("Mitigating Factor"; Rec."Mitigating Factor")
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

