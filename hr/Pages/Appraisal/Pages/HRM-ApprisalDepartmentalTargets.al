page 85516 "HRM-Departmental Targets"
{
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "HRM-Departmental Tragets";

    layout
    {
        area(content)
        {
            repeater(rep)
            {

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    Editable = true;

                }

            }
        }
    }

    actions
    {
    }

    // trigger OnAfterGetRecord()
    // begin
    //     Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    // end;

    // trigger OnOpenPage()
    // begin
    //     HRMAppraisalYears.RESET;
    //     HRMAppraisalYears.SETRANGE(Closed, FALSE);
    //     IF HRMAppraisalYears.FIND('-') THEN
    //         Rec.SETFILTER("Appraisal year Code", HRMAppraisalYears.Code);
    // end;

    var
        UserSetup: Record 91;
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
    //editability: Boolean;
}

