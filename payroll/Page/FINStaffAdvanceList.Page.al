// page 68288 "FIN-Staff Advance List"
// {
//     CardPageID = "FIN-Staff Advance Req.";
//     Editable = false;
//     PageType = List;
//     SourceTable = Table61197;

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field("No."; "No.")
//                 {
//                 }
//                 field(Date; Date)
//                 {
//                 }
//                 field(Cashier; Cashier)
//                 {
//                     Caption = 'Requestor ID';
//                 }
//                 field("Account No."; "Account No.")
//                 {
//                 }
//                 field(Payee; Payee)
//                 {
//                 }
//                 field("Responsibility Center"; "Responsibility Center")
//                 {
//                 }
//                 field("Currency Code"; "Currency Code")
//                 {
//                 }
//                 field("Total Net Amount"; "Total Net Amount")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         BCSetup: Record "61721";
//         FINBudgetEntries: Record "77078";
//         FINStaffAdvanceLines: Record "61198";

//     local procedure CommitBudget()
//     var
//         GLAccount: Record "15";
//         DimensionValue: Record "349";
//         PostBudgetEnties: Codeunit "67108";
//     begin
//         BCSetup.GET;
//         IF NOT ((BCSetup.Mandatory) AND (BCSetup."Imprest Budget mandatory")) THEN EXIT;
//         BCSetup.TESTFIELD("Current Budget Code");
//         Rec.TESTFIELD("Shortcut Dimension 2 Code");
//         //Get Current Lines to loop through
//         FINStaffAdvanceLines.RESET;
//         FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
//         IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
//             REPEAT
//             BEGIN
//                 // Check if budget exists
//                 FINStaffAdvanceLines.TESTFIELD("Account No:");
//                 GLAccount.RESET;
//                 GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
//                 IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
//                 DimensionValue.RESET;
//                 DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
//                 DimensionValue.SETRANGE("Global Dimension No.", 2);
//                 IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
//                 FINBudgetEntries.RESET;
//                 FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
//                 FINBudgetEntries.SETRANGE("G/L Account No.", FINStaffAdvanceLines."Account No:");
//                 FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
//                 FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
//                 , FINBudgetEntries."Transaction Type"::Allocation);
//                 FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2',
//                 FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
//                 FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec.Date));
//                 IF FINBudgetEntries.FIND('-') THEN BEGIN
//                     IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
//                         IF FINBudgetEntries.Amount > 0 THEN BEGIN
//                             IF (FINStaffAdvanceLines.Amount > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
//                             // Commit Budget Here
//                             PostBudgetEnties.CheckBudgetAvailability(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
//                             Rec."Shortcut Dimension 3 Code", FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
//                         END ELSE
//                             ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
//                     END;
//                 END ELSE
//                     ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
//             END;
//             UNTIL FINStaffAdvanceLines.NEXT = 0;
//         END;
//     end;

//     local procedure ExpenseBudget()
//     var
//         GLAccount: Record "15";
//         DimensionValue: Record "349";
//         PostBudgetEnties: Codeunit "67108";
//     begin
//         BCSetup.GET;
//         IF NOT ((BCSetup.Mandatory) AND (BCSetup."Imprest Budget mandatory")) THEN EXIT;
//         BCSetup.TESTFIELD("Current Budget Code");
//         Rec.TESTFIELD("Shortcut Dimension 2 Code");
//         //Get Current Lines to loop through
//         FINStaffAdvanceLines.RESET;
//         FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
//         IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
//             REPEAT
//             BEGIN
//                 // Expense Budget Here
//                 FINStaffAdvanceLines.TESTFIELD("Account No:");
//                 GLAccount.RESET;
//                 GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
//                 IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
//                 DimensionValue.RESET;
//                 DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
//                 DimensionValue.SETRANGE("Global Dimension No.", 2);
//                 IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
//                 IF (FINStaffAdvanceLines.Amount > 0) THEN BEGIN
//                     // Commit Budget Here
//                     PostBudgetEnties.ExpenseBudget(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
//                     Rec."Shortcut Dimension 3 Code", FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", USERID, TODAY, 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
//                 END;
//             END;
//             UNTIL FINStaffAdvanceLines.NEXT = 0;
//         END;
//     end;

//     local procedure CancelCommitment()
//     var
//         GLAccount: Record "15";
//         DimensionValue: Record "349";
//         PostBudgetEnties: Codeunit "67108";
//     begin
//         BCSetup.GET;
//         IF NOT ((BCSetup.Mandatory) AND (BCSetup."Imprest Budget mandatory")) THEN EXIT;
//         BCSetup.TESTFIELD("Current Budget Code");
//         Rec.TESTFIELD("Shortcut Dimension 2 Code");
//         //Get Current Lines to loop through
//         FINStaffAdvanceLines.RESET;
//         FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
//         IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
//             REPEAT
//             BEGIN
//                 // Expense Budget Here
//                 FINStaffAdvanceLines.TESTFIELD("Account No:");
//                 GLAccount.RESET;
//                 GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
//                 IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
//                 DimensionValue.RESET;
//                 DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
//                 DimensionValue.SETRANGE("Global Dimension No.", 2);
//                 IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
//                 IF (FINStaffAdvanceLines.Amount > 0) THEN BEGIN
//                     // Commit Budget Here
//                     PostBudgetEnties.CancelBudgetCommitment(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
//                     Rec."Shortcut Dimension 3 Code", FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", USERID, 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
//                 END;
//             END;
//             UNTIL FINStaffAdvanceLines.NEXT = 0;
//         END;
//     end;
// }

