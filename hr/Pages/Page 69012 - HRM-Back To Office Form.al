page 69012 "HRM-Back To Office Form"
{
    PageType = Card;
    SourceTable = "HRM-Back To Office Form";
    PromotedActionCategories = 'New,Action,Navigation,Update';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = all;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                }
                field(Trainer; Rec.Trainer)
                {
                    ApplicationArea = all;
                }
                field("Training Institution"; Rec."Training Institution")
                {
                    ApplicationArea = all;
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Text 1"; Rec."Text 1")
                {
                    ApplicationArea = all;
                    Caption = '1.Please state how the course has benefited you and the organization';
                    MultiLine = true;
                }
                field("Text 2"; Rec."Text 2")
                {
                    ApplicationArea = all;
                    Caption = '2.Which specific areas do you think need improvement in your area of operation?';
                    MultiLine = true;
                }
                field("Text 4"; Rec."Text 4")
                {
                    ApplicationArea = all;
                    Caption = '4.Provide timeline within which you will cascade the skills learned to others in your Department/organization';
                    MultiLine = true;
                }
                field("Text 3"; Rec."Text 3")
                {
                    ApplicationArea = all;
                    Caption = '3.How will you use the skills acquired to address the problem?';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    ApplicationArea = all;
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        /*
                        DocumentType:=DocumentType::"Training Application";
                        
                        ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.RUN;
                        */

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,BackToOffice;
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := DocumentType::BackToOffice;
                        //ApprovalEntries.Setfilters(DATABASE::"HRBack To Office Form",DocumentType,"Document No");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval &Request")
                {
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMnt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin

                    end;
                }
                action("&Cancel Approval request")
                {
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMnt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin

                    end;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin


                    end;
                }
                separator(Separator1)
                {
                }
                action(Post)
                {
                    ApplicationArea = all;
                    Caption = 'Mark as Back to Office';
                    Image = Undo;

                    trigger OnAction()
                    begin
                        if Confirm('Do you really want to mark the employee as back to office?') then begin
                            HREmp.Get(Rec."Employee No.");
                            HREmp."On Leave" := false;
                            HREmp.Modify;

                        end;
                    end;
                }
            }
        }
    }

    var
        //todo ApprovalMgt: Codeunit "Approvals Management";
        HREmp: Record "HRM-Employee (D)";
}

