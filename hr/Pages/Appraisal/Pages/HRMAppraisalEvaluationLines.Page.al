page 68888 "HRM-Appraisal Evaluation Lines"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Evaluations";
    SourceTableView = WHERE(Category = CONST("JOB SPECIFIC EVALUATION AREA"));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
            }
            field("Evaluation Code"; Rec."Evaluation Code")
            {
                ApplicationArea = All;
            }
            field("Evaluation Description"; Rec."Evaluation Description")
            {
                ApplicationArea = All;
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
            }
            field("Sub Category"; Rec."Sub Category")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        YesNo: Boolean;
        HRAppraisalEvaluations: Record "PRL-Payroll Variations";
        HREmp: Record "HRM-Short Listed Applicant";
        HRAppraisalRatings: Record "HRM-Leave Requisition";
        TotalScore: Decimal;

    procedure TotScore()
    begin
    end;
}

