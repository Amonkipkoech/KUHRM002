page 75043 "HRM-Appraisal Appraisee Comm."
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HRM-Appraisal Appraisee Commen";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Appraisee Comments"; Rec."Appraisee Comments")
                {
                    Caption = 'Agreed Performance Targets/ Specific Tasks Assignment';
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
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        //HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        editability: Boolean;
}

