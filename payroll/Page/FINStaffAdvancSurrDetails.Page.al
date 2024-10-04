// page 68286 "FIN-Staff Advanc Surr. Details"
// {
//     PageType = List;
//     SourceTable = Table61203;

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field("Imprest Type"; "Imprest Type")
//                 {
//                 }
//                 field("Account No:"; "Account No:")
//                 {
//                 }
//                 field("Account Name"; "Account Name")
//                 {
//                 }
//                 field(Amount; Amount)
//                 {
//                     Editable = false;
//                 }
//                 field("Actual Spent"; "Actual Spent")
//                 {
//                 }
//                 field("Cash Receipt No"; "Cash Receipt No")
//                 {
//                 }
//                 field("Cash Receipt Amount"; "Cash Receipt Amount")
//                 {
//                 }
//                 field("Apply to"; "Apply to")
//                 {

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         "Apply to" := '';
//                         "Apply to ID" := '';

//                         //Amt:=0;

//                         Custledger.RESET;
//                         Custledger.SETCURRENTKEY(Custledger."Customer No.", Open, "Document No.");
//                         Custledger.SETRANGE(Custledger."Customer No.", "Advance Holder");
//                         Custledger.SETRANGE(Open, TRUE);
//                         //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
//                         Custledger.CALCFIELDS(Custledger.Amount);
//                         IF PAGE.RUNMODAL(25, Custledger) = ACTION::LookupOK THEN BEGIN

//                             IF Custledger."Applies-to ID" <> '' THEN BEGIN
//                                 Custledger1.RESET;
//                                 Custledger1.SETCURRENTKEY(Custledger1."Customer No.", Open, "Applies-to ID");
//                                 Custledger1.SETRANGE(Custledger1."Customer No.", "Advance Holder");
//                                 Custledger1.SETRANGE(Open, TRUE);
//                                 //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
//                                 Custledger1.SETRANGE("Applies-to ID", Custledger."Applies-to ID");
//                                 IF Custledger1.FIND('-') THEN BEGIN
//                                     REPEAT
//                                         Custledger1.CALCFIELDS(Custledger1.Amount);
//                                         Amt := Amt + ABS(Custledger1.Amount);
//                                     UNTIL Custledger1.NEXT = 0;
//                                 END;

//                                 IF Amt <> Amt THEN
//                                     //ERROR('Amount is not equal to the amount applied on the application form');
//                                     /*Amount:=Amt;
//                                     VALIDATE(Amount);*/
//                            "Apply to" := Custledger."Document No.";
//                                 "Apply to ID" := Custledger."Applies-to ID";
//                             END ELSE BEGIN
//                                 IF Amount <> ABS(Custledger.Amount) THEN
//                                     Custledger.CALCFIELDS(Custledger."Remaining Amount");

//                                 /*Amount:=ABS(CustLedger."Remaining Amount");
//                                  VALIDATE(Amount);*/
//                                 //ERROR('Amount is not equal to the amount applied on the application form');

//                                 "Apply to" := Custledger."Document No.";
//                                 "Apply to ID" := Custledger."Applies-to ID";

//                             END;
//                         END;

//                         IF "Apply to ID" <> '' THEN
//                             "Apply to" := '';

//                         VALIDATE(Amount);

//                     end;
//                 }
//                 field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
//                 {
//                 }
//                 field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
//                 {
//                 }
//                 field("Difference Owed"; "Difference Owed")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         Custledger: Record "21";
//         Custledger1: Record "21";
//         Amt: Decimal;
// }

