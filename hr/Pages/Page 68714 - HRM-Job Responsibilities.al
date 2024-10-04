page 68714 "HRM-Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HRM-Job Responsiblities (B)";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID", Rec."Job ID");
                    if HRJobResponsibilities.Find('-') then
                        HRJobResponsibilities.DeleteAll;

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset;
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."Assign To", Rec."Job ID");
                    if HRAppraisalEvaluationAreas.Find('-') then
                        HRAppraisalEvaluationAreas.FindFirst;
                    begin
                        HRJobResponsibilities.Reset;
                        repeat
                            HRJobResponsibilities.Init;
                            HRJobResponsibilities."Job ID" := Rec."Job ID";
                            HRJobResponsibilities."Responsibility Code" := HRAppraisalEvaluationAreas.Code;
                            HRJobResponsibilities."Responsibility Description" := HRAppraisalEvaluationAreas.Description;
                            HRJobResponsibilities.Insert();
                        until HRAppraisalEvaluationAreas.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HRM-Job Responsiblities (B)";
        HRAppraisalEvaluationAreas: Record "HRM-Appraisal Evaluation Areas";
}

