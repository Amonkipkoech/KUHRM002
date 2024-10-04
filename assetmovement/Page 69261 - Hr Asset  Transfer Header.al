page 70027 "Hr Asset  Transfer Header"
{
    Caption = 'Asset Transfer Header';
    PageType = Card;
    SourceTable = "HR Asset Transfer Header";
}


//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Issuing Admin/Asst"; Rec."Issuing Admin/Asst")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Editable = true;
//                     ApplicationArea = All;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//             part(AssetLines; "HR Asset Transfer Lines")
//             {
//                 SubPageLink = "No." = FIELD("No.");
//                 ApplicationArea = All;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(sendApproval)
//             {
//                 Caption = 'Send A&pproval Request';
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var

//                 begin
//                     //CommitBudget;

//                 end;
//             }
//             action(cancellsApproval)
//             {
//                 Caption = 'Cancel Approval Re&quest';
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var

//                 begin
//                 end;
//             }
//             action("Print Review")
//             {
//                 Caption = 'Print Review';
//                 Image = TileCamera;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin

//                     Reclines.RESET;
//                     Reclines.SETFILTER(Reclines."No.", xRec."No.");
//                     REPORT.RUN(51277, TRUE, TRUE, Reclines);
//                 end;
//             }
//             action(Transfer)
//             {
//                 Caption = 'Transfer';
//                 Image = "Action";
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                     IF Rec.Status <> Rec.Status::Approved THEN ERROR('Transfer must be approved');
//                     Reclines.RESET;
//                     Reclines.SETRANGE("No.", Rec."No.");
//                     IF Reclines.FINDFIRST THEN
//                         REPEAT
//                             Fa.SETRANGE("No.", Reclines."Asset No.");
//                             IF Fa.FIND('-') THEN BEGIN
//                                 //MESSAGE('%1',Fa."No.");
//                                 Fa.VALIDATE("FA Location Code", Reclines."New Asset Location");
//                                 Fa."Responsible Employee" := Reclines."Responsible Employee Code";
//                                 Fa.VALIDATE("Responsible Employee", Reclines."New Responsible Employee Code");
//                                 //   Fa.VALIDATE(Facility,Reclines."New Global Dimension 3 Code");
//                                 Fa.VALIDATE("Global Dimension 1 Code", Reclines."New Global Dimension 1 Code");
//                                 Fa.VALIDATE("Global Dimension 2 Code", Reclines."New Global Dimension 2 Code");
//                                 //Fa.VALIDATE(Facility,Reclines."New Global Dimension 3 Code");
//                                 //Fa.VALIDATE("Sub County",Reclines.gl)
//                                 //MESSAGE('%1',Fa."Location Code");
//                                 Fa.MODIFY;
//                                 /* Reclines.RESET;
//                                  Reclines.SETRANGE("No.","No.");

//                                  IF Reclines."New Responsible Employee Code":='' THEN BEGIN
//                                  Fa.INIT;
//                                  Fa.SETRANGE(fa."No.",Reclines."Asset No.");
//                                  IF Fa.FIND('-') THEN BEGIN
//                                  Fa."Responsible Employee":=Reclines."Responsible Employee Code";
//                                  END
//                                  ELSE BEGIN
//                                  Fa.INIT;
//                                  Fa.SETRANGE(fa."No.",Reclines."Asset No.");
//                                  IF Fa.FIND('-') THEN BEGIN
//                                  Fa."Responsible Employee":=Reclines."New Responsible Employee Code";
//                                  END*/

//                                 MESSAGE('The fixed asset  has been transfered successifully');
//                                 Rec.Transfered := TRUE;
//                                 Rec."Transfered By" := USERID;
//                                 Rec.MODIFY;
//                             END;
//                         UNTIL Reclines.NEXT = 0;

//                 end;
//             }
//             action(Approvals)
//             {
//                 Caption = 'Approvals';
//                 Image = Approvals;
//                 Promoted = true;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                     DocumentType := DocumentType::Requisition;
//                     ApprovalEntries.Setfilters(DATABASE::"HR Asset Transfer Header", DocumentType, Rec."No.");
//                     ApprovalEntries.RUN;
//                 end;
//             }
//         }
//     }

//     var
//         RecHeader: Record "HR Asset Transfer Header";
//         Fa: Record "Fixed Asset";
//         Reclines: Record "HR Asset Transfer Lines";
//         // UserMgt: Codeunit "User Setup Management BR";
//         // ApprovalMgt: Codeunit "439";
//         ReqLine: Record "PROC-Store Requistion Lines";
//         InventorySetup: Record "Inventory Setup";
//         GenJnline: Record "Item Journal Line";
//         LineNo: Integer;
//         Post: Boolean;
//         JournlPosted: Codeunit "Journal Post Successful";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,"Asset Transfer";
//         HasLines: Boolean;
//         AllKeyFieldsEntered: Boolean;
//         FixedAsset: Record "Fixed Asset";
//         //MinorAssetsIssue: Record "FIN-Minor Ass. Issue & Returns";
//         Commitment: Codeunit "Budgetary Control";
//         BCSetup: Record "FIN-Budgetary Control Setup";
//         // DeleteCommitment: Record "61722";
//         Loc: Record Location;
//         ApprovalEntries: Page "Approval Entries";
//         FINBudgetEntries: Record "FIN-Budget Entries";
//         PROCStoreRequistionHeader: Record "PROC-Store Requistion Header";
//         PROCStoreRequistionLines: Record "PROC-Store Requistion Lines";
//         Item: Record Item;

//     procedure LinesExists(): Boolean
//     var
//         PayLines: Record "PROC-Store Requistion Lines";
//     begin
//         HasLines := FALSE;
//         PayLines.RESET;
//         PayLines.SETRANGE(PayLines."No.", Rec."No.");
//         IF PayLines.FIND('-') THEN BEGIN
//             HasLines := TRUE;
//             EXIT(HasLines);
//         END;
//     end;
// }

