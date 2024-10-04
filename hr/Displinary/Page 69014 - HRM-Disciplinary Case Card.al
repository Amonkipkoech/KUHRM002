page 69014 "HRM-Disciplinary Case Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HRM-Disciplinary Cases (B)";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = all;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    Caption = 'Incident Date';
                    ApplicationArea = all;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ToolTip = 'Specifies the value of the Incident Date field.';
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ToolTip = 'Specifies the value of the Campus field.';
                    ApplicationArea = All;
                }
                field("Case Category"; Rec."Case Category")
                {
                    ToolTip = 'Specifies the value of the Case Category field.';
                    ApplicationArea = All;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ToolTip = 'Specifies the value of the Case Description field.';
                    ApplicationArea = All;
                }
                field("Disc. Committee Case Date"; Rec."Disc. Committee Case Date")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Committee Case Date field.';
                    ApplicationArea = All;
                }
                field("Disciplinary Committee Verdict"; Rec."Disciplinary Committee Verdict")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Committee Verdict field.';
                    ApplicationArea = All;
                }
                field("Appeal (Yes/No)"; Rec."Appeal (Yes/No)")
                {
                    ToolTip = 'Specifies the value of the Appeal (Yes/No) field.';
                    ApplicationArea = All;
                }
                field("Appeal Date"; Rec."Appeal Date")
                {
                    ToolTip = 'Specifies the value of the Appeal Date field.';
                    ApplicationArea = All;
                }
                field("Verdict on Appeal"; Rec."Verdict on Appeal")
                {
                    ToolTip = 'Specifies the value of the Verdict on Appeal field.';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("HR Disciplinary Cases Factbox"; "HRM-Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = FIELD("Case Number");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Send Case Approval Request")
                {
                    Caption = 'Send Case Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                      //  AppMgmt: Codeunit IntCodeunit;
                    begin
                      //  if Confirm('Send this Case for Approval ?', true) = false then exit;
                        //AppMgmt.OnSendDisCasesforApproval(Rec);
                    end;
                }
                action("Cancel Case Approval Request")
                {
                    Caption = 'Cancel Case Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Case Approval Request?', true) = false then exit;
                        //AppMgmt.CancelDiscipplinaryAppApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Disciplinary Approvals";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::"Disciplinary Approvals";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Disciplinary Cases (B)", DocumentType, Rec."Case Number");
                        ApprovalEntries.Run;
                    end;
                }
            }
            group("Case Status")
            {
                action("Under Investigation")
                {
                    Caption = 'Under Investigation';
                    Image = OpenWorksheet;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Closed then exit;
                        // IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under review" THEN EXIT;


                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Investigation ";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;
                    end;
                }
                action("In Progress")
                {
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;


                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        //IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Investigation " THEN EXIT;
                        IF Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        IF Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Closed then exit;
                        IF Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to open Investigations for these Case?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Inprogress;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;
                    end;
                }

                action(Close)
                {
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        // IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"InProgress" THEN EXIT;
                        //  IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::Closed THEN EXIT;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Closed;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                        end;
                    end;
                }
                action(Appeal)
                {
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec.Appealed = true then begin
                            Error('A case can only be Appealed once');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Under review";
                            Rec.Appealed := true;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
                action(UploadRecon)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = process;
                    Caption = 'Upload Agreed recommendation';
                }
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        HRDisciplinary: Record "HRM-Disciplinary Cases (B)";
        //todo  AppMgmt: Codeunit "Approvals Management";
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;

    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::New then begin
            RecommendedActionEditable := false;
            ActionTakenEditable := false;
            DisciplinaryRemarksEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            CurrPage.Editable := false;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            CurrPage.Editable := false;
        end;
    end;
}

