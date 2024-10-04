page 68334 "HRM-Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HRM-Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Job Reference Number"; Rec."Job Reference Number")
                {
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = All;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Job Type"; Rec."Job Type")
                {
                    ToolTip = 'Specifies the value of the Job Type field.';
                    ApplicationArea = All;
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    //  Caption = 'Cost Center Code';
                    ApplicationArea = all;
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    //Caption = 'Cost Center Name';
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                    //  Caption = 'Department';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }

                field("Main Objective"; Rec."Main Objective")
                {
                    ApplicationArea = all;
                }
                field("Reason for Job creation"; Rec."Reason for Job creation")
                {
                    ApplicationArea = all;
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    ApplicationArea = all;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = all;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = all;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = all;
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = all;
                }
                field("Key Position"; Rec."Key Position")
                {
                    ApplicationArea = all;
                }
                field("Memo Ref No."; Rec."Memo Ref No.")
                {
                    ApplicationArea = all;
                }
                field("Memo Approval Date"; Rec."Memo Approval Date")
                {
                    ApplicationArea = all;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Employment Category"; Rec."Employment Category")
                {
                    ApplicationArea = all;
                    Caption = 'Job Cadre';
                }
                field("Employment Grade"; Rec."Employment Grade")
                {
                    ApplicationArea = all;
                    Caption = 'Job Grade';
                }
            }
            part("Job Responsibilities"; "HRM-Job Resp. Lines")
            {
                ApplicationArea = all;
                Caption = 'Job Responsibilities';
                SubPageLink = "Job ID" = FIELD("Job ID");
            }

        }
        area(factboxes)
        {
            part(Control1102755004; "HRM-Jobs Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                Enabled = false;
                Visible = false;
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Enabled = false;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::Job;
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Jobs", DocumentType, Rec."Job ID");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Send Approval Request';
                    Enabled = false;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Send this job position for Approval?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.SendJobApprovalReq(Rec);
                        */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Request';
                    Enabled = false;
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.CancelJobAppRequest(Rec,TRUE,TRUE);
                         */

                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action("Raise Requisition")
                {
                    ApplicationArea = all;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Employee Requisitions List";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    RunPageOnRec = false;

                    trigger OnAction()
                    begin
                        CurrPage.Close;
                    end;
                }
                action(Requirements)
                {
                    ApplicationArea = all;
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Job Requirement Lines";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = all;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Job Resp. Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action(Occupants)
                {
                    ApplicationArea = all;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Job Occupants";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("ShortListing Criteria")
                {
                    ApplicationArea = all;
                    Caption = 'ShortListing Criteria';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Job Shortlist Qualif.";
                    Visible = true;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Vacant Positions");
    end;

    var
        HREmployees: Record "HRM-Employee (D)";
        //todo AppMgmt: Codeunit "Approvals Management";
        Jobreq: Record "HRM-Job Requirements";
}

