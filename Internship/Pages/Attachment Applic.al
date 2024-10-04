page 50011 "Attachment Applic"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Internship-Attachment Applic";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;

                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;

                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;

                }
                field("ID Card Number"; Rec."ID Card Number")
                {
                    ApplicationArea = All;

                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;

                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;

                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;

                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;

                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;

                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;

                }

                field(Town; Rec.Town)
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    //Editable = false;

                }
                field(Institute; Rec.Institute)
                {
                    ApplicationArea = All;
                    Caption = 'University/Institute Name';

                }
                field("Adm No."; Rec."Adm No.")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;

                }
                field("Disability Status"; Rec."Disability Status")
                {
                    ApplicationArea = All;
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;

                }


            }
            group(Insurance)
            {
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;

                }
                field("Policy No."; Rec."Policy No.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
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
                    //    AppMgmt: Codeunit IntCodeunit;
                    begin
                        if Confirm('Send this Case for Approval ?', true) = false then exit;
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
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Disciplinary Cases (B)", DocumentType, Rec.Code);
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}