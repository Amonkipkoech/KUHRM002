codeunit 50901 "Leave Carry Forward"
{

    trigger OnRun()
    begin

        if Confirm('Generate Leave Balances to Carry Forward? (Ensure that you have already allocated annual leave balances)', true) = false then exit;
        Clear(ints);
        hremployee2.Reset;
        //hremployee2.SetRange("No.", '00762');
        hremployee2.SetRange(hremployee2.Status, hremployee2.Status::Active);
        if hremployee2.Find('-') then begin
            // Populate leave journal with

            // Delete Existing Journal Entries first
            leaveJournal.Reset;
            if leaveJournal.Find('-') then
                leaveJournal.DeleteAll;
            repeat



                // leaveledger.Reset;
                // //leaveledger.SetRange(leaveledger."Document No", hremployee2."No.");
                // leaveledger.SetRange(leaveledger."Employee No", hremployee2."No.");
                // //leaveledger.SetRange(leaveledger."Leave Period", (Date2DMY(Today, 3) - 1));
                // leaveledger.SetRange(leaveledger."Leave Period", Date2DMY(Today, 3));
                // //leaveledger.SetFilter(leaveledger."Transaction Type", '<>%1', leaveledger."Transaction Type"::"Positive Adjustment");
                // //leaveledger.SetFilter(leaveledger."Entry Type", '<>%1', leaveledger."Entry Type"::Allocation);
                // //if not leaveledger.Find('-') then begin
                // if leaveledger.Find('-') then begin
                //     // Insert the Journals

                ints := ints + 1;
                salaryGrades.Reset();
                salaryGrades.SetRange("Salary Grade code", hremployee2."Salary Grade");
                if salaryGrades.Find('-') then begin
                    CFDays := salaryGrades."Annual Leave Days" / 2;
                    janDays := salaryGrades."Monthly Leave Days";
                    hremployee2.CalcFields("Leave Balance");
                    dys := hremployee2."Leave Balance" - janDays;
                    if dys > CFDays then
                        forfeit := dys - CFDays;
                    // if hremployee2."Leave Balance" > 0 then begin
                    if forfeit > 0 then begin
                        ints := ints + 100;
                        leaveJournal.Init;
                        leaveJournal."Line No." := ints;
                        leaveJournal."Staff No." := hremployee2."No.";
                        leaveJournal."Staff Name" := hremployee2."First Name" + ' ' + hremployee2."Middle Name" + ' ' + hremployee2."Last Name";
                        leaveJournal."Transaction Description" := 'Leave Days forfeited ' + Format(Date2DMY(Today, 3));
                        leaveJournal."Leave Type" := 'ANNUAL';
                        //leaveJournal."No. of Days" := salaryGrades."Annual Leave Days";
                        leaveJournal."No. of Days" := forfeit;
                        leaveJournal."Transaction Type" := leaveJournal."Transaction Type"::"Negative Adjustment";
                        leaveJournal."Document No." := 'ALL-' + Format(Date2DMY(Today, 3));
                        leaveJournal."Posting Date" := Today;
                        leaveJournal."Leave Period" := Date2DMY(Today, 3);
                        leaveJournal.Insert;
                    end;
                end;
                Clear(CFDays);
                Clear(dys);
                Clear(forfeit);
                Clear(janDays);

            // leaveJournal.Init;
            // leaveJournal."Line No." := ints;
            // leaveJournal."Staff No." := hremployee2."No.";
            // leaveJournal."Staff Name" := hremployee2."First Name" + ' ' + hremployee2."Middle Name" + ' ' + hremployee2."Last Name";
            // leaveJournal."Transaction Description" := 'Leave Carry Forward for ' + Format(Date2DMY(Today, 3));
            // leaveJournal."Leave Type" := 'ANNUAL';
            // //leaveJournal."No. of Days" := salaryGrades."Annual Leave Days";
            // leaveJournal."No. of Days" := bal;
            // leaveJournal."Transaction Type" := leaveJournal."Transaction Type"::"Positive Adjustment";
            // leaveJournal."Document No." := 'ALL-' + Format(Date2DMY(Today, 3));
            // leaveJournal."Posting Date" := Today;
            // leaveJournal."Leave Period" := Date2DMY(Today, 3);
            // leaveJournal.Insert;
            //forfeited days



            //end;


            until hremployee2.Next = 0;
        end;
        Message('Annual Leave balance generated successfully!');
    end;

    var
        salaryGrades: Record "HRM-Job_Salary grade/steps";
        hremployee: Record "HRM-Employee (D)";
        hremployee2: Record "HRM-Employee (D)";
        leaveledger: Record "HRM-Leave Ledger";
        leaveJournal: Record "HRM-Employee Leave Journal";
        ints: Integer;
        bal: Decimal;
        CFDays: Decimal;
        forfeit: Decimal;
        dys: Decimal;
        janDays: Decimal;
}

