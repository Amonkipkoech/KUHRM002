page 68886 "HRM-Appraisal Goal (B)"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    SourceTable = "HRM-Appraisal Goal Setting H";
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
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part("PERSONAL GOALS/OBJECTIVES"; 69000)
            {
                Caption = 'PERSONAL GOALS/OBJECTIVES';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                ApplicationArea = All;
            }
            part(SF; 69008)
            {
                Caption = 'PERSONAL PROFESSIONAL ATTRIBUTES';
                SubPageLink = "Training Code" = FIELD("Appraisal No");
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
            }
        }
        area(processing)
        {
            action("&Next Page")
            {
                Caption = '&Next Page';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HRM-Appraisal Goal Setting";
                RunPageLink = "Appraisal No" = FIELD("Appraisal No");
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //FORM.RUNMODAL(39005843
                    //PAGE.RUN(39003985,Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF HREmp.GET(Rec."Employee No") THEN
            Rec."Job Title" := HREmp."Job Title";
    end;

    var
        //HRAppraisalEvaluationAreas: Record 61124;
        HRAppraisalEvaluations: Record 61123;
        HRAppraisalEvaluationsF: Page 68888;
        HREmp: Record 61067;
}

