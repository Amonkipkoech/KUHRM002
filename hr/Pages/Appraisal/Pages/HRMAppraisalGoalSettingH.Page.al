page 68891 "HRM-Appraisal Goal Setting H"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = 61232;
    SourceTableView = WHERE(Sent = FILTER("At Appraisee"));

    layout
    {
        area(content)
        {
            group("Appraisee Information")
            {
                Caption = 'Appraisee Information';
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
                field("Overal Rating Desc"; Rec."Overal Rating Desc")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("SuperVisor Email"; Rec."SuperVisor Email")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
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
                field(Sent; Rec.Sent)
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
            group("Appraisal Ratings")
            {
                Caption = 'Appraisal Ratings';
                field("Total PTarget Score"; Rec."Total PTarget Score")
                {
                    ApplicationArea = All;
                }
                field("Total Value Assessment Score"; Rec."Total Value Assessment Score")
                {
                    ApplicationArea = All;
                }
                field("Total Score of Targets(Points)"; Rec."Total Score of Targets(Points)")
                {
                    ApplicationArea = All;
                }
                field("Total Score of Targets(%)"; Rec."Total Score of Targets(%)")
                {
                    ApplicationArea = All;
                }
            }
            part("Departmental Objectives"; 68893)
            {
                Caption = 'Departmental Objectives';
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Appraisal Type" = FIELD("Appraisal Type");
                ApplicationArea = All;
            }
            part(pg1; 69041)
            {
                ApplicationArea = All;
            }
            part(pg2; 68980)
            {
                ApplicationArea = All;
            }
            part(pg3; 68902)
            {
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(out; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(note; Notes)
            {
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
                action("Send To Supervisor")
                {
                    Caption = 'Send To Supervisor';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //LinesExists;

                        IF CONFIRM('Do you want to send this Appraisal Form to  your Supervisor?', FALSE) = TRUE THEN BEGIN
                            Rec.Sent := 1;
                            Rec.MODIFY;
                            MESSAGE('%1', 'Process Completed')
                        END;
                    end;
                }
            }
        }
    }

    var
        HasLines: Boolean;
        Text19033494: Label 'Set your goals and objectives in line with your departments strategy.';
        "Goal Setting": Record 61233;
        HRAppraisalGoals: Record 61233;

    procedure LinesExists(): Boolean
    var
        HRAppraisalGoals: Record 61121;
    begin
        /*HasLines:=FALSE;
        HRAppraisalGoals.RESET;
        HRAppraisalGoals.SETRANGE(HRAppraisalGoals."Appraisal No","Appraisal No");
        IF HRAppraisalGoals.FIND('-') THEN BEGIN
             HasLines:=TRUE;
             EXIT(HasLines);
          END;
         */

    end;
}

