page 68896 "HRM-Appraisal Evaluation 3"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Evaluations";
    SourceTableView = WHERE(Category = CONST("EMPLOYEE PERFORMANCE FACTOR"));

    layout
    {
    }

    actions
    {
    }

    var
        YesNo: Boolean;
        HRAppraisalEvaluations: Record "HRM-Appraisal Evaluations";
        HREmp: Record "HRM-Employee (D)";
        HRAppraisalRatings: Record "HRM-Appraisal Ratings (B)";
        TotalScore: Decimal;
        HRLookupValues: Record "HRM-Lookup Values";

    procedure TotScore()
    begin
    end;
}

