page 75064 "HRM-Disciplinary Cases New"
{
    Caption = 'Employee Disciplinary Cases ';
    CardPageID = "HRM-Disciplinary Case Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HRM-Disciplinary Cases (B)";
    SourceTableView = where(Status = filter(New));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = all;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = all;
                }
                field("Type Complaint"; Rec."Type Complaint")
                {
                    ApplicationArea = all;
                }
                field(Accuser; Rec.Accuser)
                {
                    ApplicationArea = all;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                    ApplicationArea = all;
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Disciplinary Stage Status"; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = all;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part("HR Disciplinary Cases Factbox"; "HRM-Disciplinary Cases Factbox")
            {
                ApplicationArea = all;
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = FIELD("Case Number");
            }
            systempart(Control1102755009; Outlook)
            {
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
                    begin
                        if Confirm('Send this Case for Approval ?', true) = false then exit;
                        //AppMgmt.SendDisciplinaryApprovalReq(Rec);
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
                    ApplicationArea = all;
                    Caption = 'Under Investigation';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        /*
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Investigation" THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"In Progress" THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::Closed THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Review" THEN EXIT;
                        */

                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Investigation ";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;

                    end;
                }
                action("In Progress")
                {
                    ApplicationArea = all;
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        /*
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Investigation" THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"In Progress" THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::Closed THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Review" THEN EXIT;
                        */

                        if Confirm('Are you sure you want to open Investigations for these Case?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Inprogress;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = all;
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        /*
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Investigation" THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"In Progress" THEN EXIT;
                      //  IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::Closed THEN EXIT;
                        IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under Review" THEN EXIT;
                        */

                        if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Closed;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                        end;

                    end;
                }
                action(Appeal)
                {
                    ApplicationArea = all;
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Under review";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
            }
        }
    }

    var
        //todo AppMgmt: Codeunit "Approvals Management";
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
}

