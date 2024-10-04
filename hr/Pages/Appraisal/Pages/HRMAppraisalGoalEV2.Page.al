page 68897 "HRM-Appraisal Goal EV 2"
{
    PageType = Document;
    SourceTable = 61232;
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
            }
            /* part(SF; 68120)
            {
            } */
            label(rec)
            {
                CaptionClass = Text19043501;
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Send To Appraisee")
                {
                    Caption = 'Send To Appraisee';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to send this Appraisal Form to  your Supervisor?', FALSE) = TRUE THEN BEGIN
                            Rec.Status := 0;
                            Rec.MODIFY;
                            MESSAGE('%1', 'Process Completed')
                        END;
                    end;
                }
                action("Import Evaluation Areas")
                {
                    Caption = 'Import Evaluation Areas';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        HRAppraisalEvaluations.RESET;
                        HRAppraisalEvaluations.SETRANGE(HRAppraisalEvaluations."Employee No", Rec."Employee No");
                        HRAppraisalEvaluations.SETRANGE(HRAppraisalEvaluations.Category, HRAppraisalEvaluations.Category::"EMPLOYEE PERFORMANCE FACTOR");
                        IF HRAppraisalEvaluations.FIND('-') THEN
                            HRAppraisalEvaluations.DELETEALL;

                        //COPY EVALUATION AREA FOR ONE EMPLOYEE
                        HRAppraisalEvaluationAreas.RESET;
                        HRAppraisalEvaluationAreas.SETRANGE
                        (HRAppraisalEvaluationAreas."Categorize As", HRAppraisalEvaluationAreas."Categorize As"::"EMPLOYEE PERFORMANCE FACTOR");
                        IF HRAppraisalEvaluationAreas.FIND('-') THEN
                            HRAppraisalEvaluationAreas.FINDFIRST;
                        BEGIN
                            HRAppraisalEvaluations.RESET;
                            REPEAT
                                HRAppraisalEvaluations.INIT;
                                HRAppraisalEvaluations."Employee No" := Rec."Employee No";
                                HRAppraisalEvaluations."Evaluation Code" := HRAppraisalEvaluationAreas.Code;
                                HRAppraisalEvaluations."Sub Category" := HRAppraisalEvaluationAreas."Sub Category";
                                HRAppraisalEvaluations.Group := HRAppraisalEvaluationAreas.Group;
                                HRAppraisalEvaluations.Category := HRAppraisalEvaluationAreas."Categorize As";
                                HRAppraisalEvaluations."Appraisal Period" := Rec."Appraisal Period";
                                HRAppraisalEvaluations."Line No" := HRAppraisalEvaluationAreas."Line No";
                                //HRAppraisalEvaluations."Line No":=HRAppraisalEvaluations."Line No"+1;
                                HRAppraisalEvaluations.INSERT();
                            UNTIL HRAppraisalEvaluationAreas.NEXT = 0;
                            // HRAppraisalEvaluationAreas.FINDFIRST;
                        END;
                    end;
                }
            }
        }
    }

    var
        HRAppraisalEvaluationAreas: Record 61236;
        HRAppraisalEvaluations: Record 61235;
        HRAppraisalEvaluationsF: Page 68888;
        Text19043501: Label 'EMPLOYEE PERFORMANCE FACTORS ';
}

