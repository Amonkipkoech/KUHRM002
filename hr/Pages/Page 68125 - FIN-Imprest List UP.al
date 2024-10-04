// /*page 68125 "FIN-Imprest List UP"
// {
//     CardPageID = "FIN-Travel Advance Req. UP";
//     Editable = false;
//     PageType = List;
//     SourceTable = "FIN-Imprest Header";
//     SourceTableView = WHERE(Status = FILTER(= Pending | = "Pending Approval"));

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     Applicationarea = all;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     Applicationarea = all;
//                 }
//                 field("Account No."; Rec."Account No.")
//                 {
//                     Applicationarea = all;
//                 }
//                 field(Payee; Rec.Payee)
//                 {
//                     Applicationarea = all;
//                 }
//                 field("Total Net Amount"; Rec."Total Net Amount")
//                 {
//                     Applicationarea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("&Functions")
//             {
//                 Caption = '&Functions';
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     begin
//                         DocumentType := DocumentType::Imprest;
//                         ApprovalEntries.Setfilters(DATABASE::"FIN-Imprest Header", DocumentType, Rec."No.");
//                         ApprovalEntries.Run;
//                     end;
//                 }
//                 action(sendApproval)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         //   ApprovalMgt: Codeunit "Approvals Management";
//                         showmessage: Boolean;
//                         ManualCancel: Boolean;
//                         State: Option Open,"Pending Approval",Cancelled,Approved;
//                         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
//                         tableNo: Integer;
//                     begin
//                         if not LinesExists then
//                             Error('There are no Lines created for this Document');

//                         if not AllFieldsEntered then
//                             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

//                         //Ensure No Items That should be committed that are not
//                         if LinesCommitmentStatus then
//                             Error('There are some lines that have not been committed');


//                         //Release the Imprest for Approval
//                         State := State::Open;
//                         if Rec.Status <> Rec.Status::Pending then State := State::"Pending Approval";
//                         DocType := DocType::Imprest;
//                         Clear(tableNo);
//                         tableNo := DATABASE::"FIN-Imprest Header";
//                         //    if ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State) then;
//                         //  IF ApprovalMgt.SendLeaveApprovalRequest(Rec) THEN;
//                     end;
//                 }
//                 action(cancellsApproval)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         //    ApprovalMgt: Codeunit "Approvals Management";
//                         showmessage: Boolean;
//                         ManualCancel: Boolean;
//                         State: Option Open,"Pending Approval",Cancelled,Approved;
//                         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
//                         tableNo: Integer;
//                     begin
//                         DocType := DocType::Imprest;
//                         showmessage := true;
//                         ManualCancel := true;
//                         Clear(tableNo);
//                         tableNo := DATABASE::"FIN-Imprest Header";
//                         //    if ApprovalMgt.CancelApproval(tableNo,DocType,Rec."No.",showmessage,ManualCancel) then;

//                         // IF ApprovalMgt.CancelLeaveApprovalRequest(Rec,TRUE,TRUE) THEN;
//                     end;
//                 }
//                 separator(Separator7)
//                 {
//                 }
//                 action("Check Budgetary Availability")
//                 {
//                     Caption = 'Check Budgetary Availability';
//                     Image = CheckLedger;
//                     Promoted = true;

//                     trigger OnAction()
//                     var
//                         BCSetup: Record "FIN-Budgetary Control Setup";
//                     begin

//                         BCSetup.Get;
//                         if not BCSetup.Mandatory then
//                             exit;

//                         if not LinesExists then
//                             Error('There are no Lines created for this Document');

//                         if not AllFieldsEntered then
//                             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

//                         //First Check whether other lines are already committed.
//                         Commitments.Reset;
//                         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
//                         Commitments.SetRange(Commitments."Document No.", Rec."No.");
//                         if Commitments.Find('-') then begin
//                             if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
//                             Commitments.Reset;
//                             Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
//                             Commitments.SetRange(Commitments."Document No.", Rec."No.");
//                             Commitments.DeleteAll;
//                         end;

//                         CheckBudgetAvail.CheckImprest(Rec);
//                     end;
//                 }
//                 action("Cancel Budget Commitment")
//                 {
//                     Caption = 'Cancel Budget Commitment';
//                     Image = CancelledEntries;
//                     Promoted = true;

//                     trigger OnAction()
//                     begin
//                         if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

//                         Commitments.Reset;
//                         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
//                         Commitments.SetRange(Commitments."Document No.", Rec."No.");
//                         Commitments.DeleteAll;

//                         PayLine.Reset;
//                         PayLine.SetRange(PayLine.No, Rec."No.");
//                         if PayLine.Find('-') then begin
//                             repeat
//                                 PayLine.Committed := false;
//                                 PayLine.Modify;
//                             until PayLine.Next = 0;
//                         end;
//                     end;
//                 }
//                 separator(Separator4)
//                 {
//                 }
//                 action("Print/Preview")
//                 {
//                     Caption = 'Print/Preview';
//                     Image = PrintAttachment;
//                     Promoted = true;

//                     trigger OnAction()
//                     begin
//                         if Rec.Status = Rec.Status::Pending then
//                             //  ERROR('You can only print after the document is released for approval');
//                             Rec.Reset;
//                         Rec.SetFilter("No.", Rec."No.");
//                         REPORT.Run(51260, true, true, Rec);
//                         Rec.Reset;
//                     end;
//                 }
//                 separator(Separator2)
//                 {
//                 }
//                 action("Cancel Document")
//                 {
//                     Caption = 'Cancel Document';
//                     Image = CancelAllLines;
//                     Promoted = true;

//                     trigger OnAction()
//                     var
//                         Text000: Label 'Are you sure you want to Cancel this Document?';
//                         Text001: Label 'You have selected not to Cancel this Document';
//                     begin
//                         //TESTFIELD(Status,Status::Approved);
//                         if Confirm(Text000, true) then begin
//                             //Post Committment Reversals
//                             Doc_Type := Doc_Type::Imprest;
//                             BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
//                             Rec.Status := Rec.Status::Cancelled;
//                             Rec.Modify;
//                         end else
//                             Error(Text001);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin

//         Rec.SetFilter("Requested By", '=%1', UserId);
//     end;

//     trigger OnQueryClosePage(CloseAction: Action): Boolean
//     begin
//         if CloseAction = ACTION::LookupOK then
//             LookupOKOnPush;
//     end;

//     var
//         ImprestHeader: Record "FIN-Imprest Header";
//         Rcpt: Record "FIN-Imprest Header";
//         ApprovalEntries: Page "Approval Entries";
//         PayLine: Record "FIN-Payment Line";
//         PVUsers: Record "FIN-CshMgt PV Steps Users";
//         strFilter: Text[250];
//         IntC: Integer;
//         IntCount: Integer;
//         Payments: Record "FIN-Payments Header";
//         RecPayTypes: Record "FIN-Receipts and Payment Types";
//         TarriffCodes: Record "FIN-Tariff Codes";
//         GenJnlLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         CashierLinks: Record "FIN-Cash Office User Template";
//         LineNo: Integer;
//         Temp: Record "FIN-Cash Office User Template";
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         //PCheck: Codeunit "Posting Check FP";
//         Post: Boolean;
//         strText: Text[100];
//         PVHead: Record "FIN-Payments Header";
//         BankAcc: Record "Bank Account";
//         CheckBudgetAvail: Codeunit "Budgetary Control";
//         Commitments: Record "FIN-Committment";
//         UserMgt: Codeunit "User Setup Management BR";
//         JournlPosted: Codeunit "Journal Post Successful";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
//         HasLines: Boolean;
//         AllKeyFieldsEntered: Boolean;
//         Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
//         BudgetControl: Codeunit "Budgetary Control";
//         GLEntry: Record "G/L Entry";
//         LastEntry: Integer;
//         VBank: Record "Customer Bank Account";
//         BankPayment: Record "FIN-Bank Payments";
//         [InDataSet]
//         "Payment Release DateEditable": Boolean;
//         [InDataSet]
//         "Paying Bank AccountEditable": Boolean;
//         [InDataSet]
//         "Pay ModeEditable": Boolean;
//         [InDataSet]
//         "Cheque No.Editable": Boolean;
//         [InDataSet]
//         GlobalDimension1CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension2CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension3CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension4CodeEditable: Boolean;
//         [InDataSet]
//         DateEditable: Boolean;
//         [InDataSet]
//         "Currency CodeEditable": Boolean;
//         Setup: Record "FIN-Cash Office Setup";

//     local procedure LookupOKOnPush()
//     begin
//         PayLine."Account No." := ImprestHeader."Account No.";
//     end;

//     procedure LinesCommitmentStatus() Exists: Boolean
//     var
//         BCsetup: Record "FIN-Budgetary Control Setup";
//     begin
//         if BCsetup.Get() then begin
//             if not BCsetup.Mandatory then begin
//                 Exists := false;
//                 exit;
//             end;
//         end else begin
//             Exists := false;
//             exit;
//         end;
//         Exists := false;
//         PayLine.Reset;
//         PayLine.SetRange(PayLine.No, Rec."No.");
//         PayLine.SetRange(PayLine.Committed, false);
//         PayLine.SetRange(PayLine."Budgetary Control A/C", true);
//         if PayLine.Find('-') then
//             Exists := true;
//     end;

//     procedure PostImprest()
//     begin

//         if Temp.Get(UserId) then begin
//             GenJnlLine.Reset;
//             GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//             GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//             GenJnlLine.DeleteAll;
//         end;

//         LineNo := LineNo + 1000;
//         GenJnlLine.Init;
//         GenJnlLine."Journal Template Name" := JTemplate;
//         GenJnlLine."Journal Batch Name" := JBatch;
//         GenJnlLine."Line No." := LineNo;
//         GenJnlLine."Source Code" := 'PAYMENTJNL';
//         GenJnlLine."Posting Date" := Rec."Payment Release Date";
//         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
//         GenJnlLine."Document No." := Rec."No.";
//         GenJnlLine."External Document No." := Rec."Cheque No.";
//         GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
//         GenJnlLine."Account No." := Rec."Account No.";
//         GenJnlLine.Validate(GenJnlLine."Account No.");
//         GenJnlLine.Description := 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
//         Rec.CalcFields("Total Net Amount");
//         GenJnlLine.Amount := Rec."Total Net Amount";
//         GenJnlLine.Validate(GenJnlLine.Amount);
//         GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
//         GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
//         GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
//         //Added for Currency Codes
//         GenJnlLine."Currency Code" := Rec."Currency Code";
//         GenJnlLine.Validate("Currency Code");
//         GenJnlLine."Currency Factor" := Rec."Currency Factor";
//         GenJnlLine.Validate("Currency Factor");
//         /*
//         GenJnlLine."Currency Factor":=Payments."Currency Factor";
//         GenJnlLine.VALIDATE("Currency Factor");
//         */
//    /*     GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//         GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//         GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
//         GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

//         if GenJnlLine.Amount <> 0 then
//             GenJnlLine.Insert;

//         if GLEntry.FindLast then LastEntry := GLEntry."Entry No.";

//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//         CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

//         //EFT
//         PayLine.Reset;
//         PayLine.SetRange(PayLine.No, Rec."No.");
//         if PayLine.Find('-') then begin
//             repeat
//                 if Rec."Pay Mode" = Rec."Pay Mode"::EFT then begin
//                     if PayLine."Account No." <> '' then begin
//                         BankPayment.SetRange(BankPayment."Doc No", Rec."No.");
//                         if BankPayment.Find('-') then BankPayment.Delete;

//                         PayLine.TestField(PayLine."EFT Bank Account No");
//                         // PayLine.TESTFIELD(PayLine."EFT Branch No.");
//                         PayLine.TestField(PayLine."EFT Bank Code");
//                         PayLine.TestField(PayLine."EFT Account Name");

//                         BankPayment.Init;
//                         BankPayment."Doc No" := Rec."No.";
//                         BankPayment.Payee := PayLine."Account No.";
//                         BankPayment.Amount := Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total VAT Amount");
//                         BankPayment."Bank A/C No" := PayLine."EFT Bank Account No";
//                         //  BankPayment."Bank Branch No":=PayLine."EFT Branch No.";
//                         //  BankPayment."Bank Code":=PayLine."EFT Bank Code";
//                         BankPayment."Bank A/C Name" := PayLine."EFT Account Name";
//                         // END;
//                         BankPayment.Date := Today;
//                         BankPayment.Insert;
//                     end;
//                 end;
//             until PayLine.Next = 0;
//         end;
//         Post := false;
//         //Post:=JournlPosted.PostedSuccessfully();

//         if Post then begin
//             Rec.Posted := true;
//             Rec."Date Posted" := Today;
//             Rec."Time Posted" := Time;
//             Rec."Posted By" := UserId;
//             Rec.Status := Rec.Status::Posted;
//             Rec.Modify;
//         end;

//     end;

//     procedure CheckImprestRequiredItems()
//     begin

//         Rec.TestField("Payment Release Date");
//         Rec.TestField("Paying Bank Account");
//         Rec.TestField("Account No.");
//         Rec.TestField("Account Type", Rec."Account Type"::Customer);

//         if Rec.Posted then begin
//             Error('The Document has already been posted');
//         end;

//         Rec.TestField(Status, Rec.Status::Approved);

//         /*Check if the user has selected all the relevant fields*/

//         Temp.Get(UserId);
//         JTemplate := Temp."Imprest Template";
//         JBatch := Temp."Imprest  Batch";

//         if JTemplate = '' then begin
//             Error('Ensure the Imprest Template is set up in Cash Office Setup');
//         end;

//         if JBatch = '' then begin
//             Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
//         end;

//         if not LinesExists then
//             Error('There are no Lines created for this Document');

//     end;

//     procedure UpdateControls()
//     begin
//         if Rec.Status <> Rec.Status::Approved then begin
//             "Payment Release DateEditable" := false;
//             "Paying Bank AccountEditable" := false;
//             "Pay ModeEditable" := false;
//             //CurrForm."Currency Code".EDITABLE:=FALSE;
//             "Cheque No.Editable" := false;
//             // CurrForm."Serial No".EDITABLE:=FALSE;
//             // CurrPage.UpdateControls();
//         end else begin
//             "Payment Release DateEditable" := true;
//             "Paying Bank AccountEditable" := true;
//             "Pay ModeEditable" := true;
//             "Cheque No.Editable" := true;
//             //CurrForm."Currency Code".EDITABLE:=TRUE;
//             //CurrPage.UpdateControls();
//         end;

//         if Rec.Status = Rec.Status::Pending then begin
//             GlobalDimension1CodeEditable := true;
//             ShortcutDimension2CodeEditable := true;
//             //CurrForm.Payee.EDITABLE:=TRUE;
//             ShortcutDimension3CodeEditable := true;
//             ShortcutDimension4CodeEditable := true;
//             DateEditable := true;
//             //CurrForm."Account No.".EDITABLE:=TRUE;
//             "Currency CodeEditable" := true;
//             //  CurrForm."Serial No".EDITABLE:=TRUE;
//             //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
//             //CurrPage.UpdateControls();
//         end else begin
//             GlobalDimension1CodeEditable := false;
//             ShortcutDimension2CodeEditable := true;
//             //CurrForm.Payee.EDITABLE:=FALSE;
//             ShortcutDimension3CodeEditable := false;
//             ShortcutDimension4CodeEditable := false;
//             DateEditable := false;
//             //  CurrForm."Serial No".EDITABLE:=FALSE;
//             //CurrForm."Account No.".EDITABLE:=FALSE;
//             "Currency CodeEditable" := false;
//             //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
//             //CurrPage.UpdateControls();
//         end
//     end;

//     procedure LinesExists(): Boolean
//     var
//         PayLines: Record "FIN-Imprest Lines";
//     begin
//         HasLines := false;
//         PayLines.Reset;
//         PayLines.SetRange(PayLines.No, Rec."No.");
//         if PayLines.Find('-') then begin
//             HasLines := true;
//             exit(HasLines);
//         end;
//     end;

//     procedure AllFieldsEntered(): Boolean
//     var
//         PayLines: Record "FIN-Imprest Lines";
//     begin
//         AllKeyFieldsEntered := true;
//         PayLines.Reset;
//         PayLines.SetRange(PayLines.No, Rec."No.");
//         if PayLines.Find('-') then begin
//             repeat
//                 if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) then
//                     AllKeyFieldsEntered := false;
//             until PayLines.Next = 0;
//             exit(AllKeyFieldsEntered);
//         end;
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         UpdateControls();
//     end;
// }*/

