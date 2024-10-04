codeunit 50904 "HR Post Leave Journal Ent."
{

    trigger OnRun()
    var
        progre: Dialog;
        counts: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
        Var1: Code[10];
    begin

        IF CONFIRM('Post Leave Journal Lines?', FALSE) = FALSE THEN EXIT;

        hrLeaveJournal.RESET;
        // HrEmployee.SETRANGE(HrEmployee."Employee Type",HrEmployee."Employee Type"::Permanent);
        //HrEmployee.SETRANGE(HrEmployee.Status,HrEmployee.Status::Normal);
        IF hrLeaveJournal.FIND('-') THEN BEGIN

            CLEAR(RecCount1);
            CLEAR(RecCount2);
            CLEAR(RecCount3);
            CLEAR(RecCount4);
            CLEAR(RecCount5);
            CLEAR(RecCount6);
            CLEAR(RecCount7);
            CLEAR(RecCount8);
            CLEAR(RecCount9);
            CLEAR(RecCount10);
            CLEAR(counts);
            progre.OPEN('Processing Please wait..............\#1###############################################################' +
            '\#2###############################################################' +
            '\#3###############################################################' +
            '\#4###############################################################' +
            '\#5###############################################################' +
            '\#6###############################################################' +
            '\#7###############################################################' +
            '\#8###############################################################' +
            '\#9###############################################################' +
            '\#10###############################################################' +
            '\#11###############################################################' +
            '\#12###############################################################' +
            '\#13###############################################################',
                RecCount1,
                RecCount2,
                RecCount3,
                RecCount4,
                RecCount5,
                RecCount6,
                RecCount7,
                RecCount8,
                RecCount9,
                RecCount10,
                Var1,
                Var1,
                BufferString
            );
            CLEAR(lastNo);
            leaveLedger.RESET;
            leaveLedger.SETFILTER(leaveLedger."Entry No.", '<>%1', 0);
            IF leaveLedger.FINDLAST THEN BEGIN
                lastNo := leaveLedger."Entry No." + 10;
            END ELSE
                lastNo := 10;
            REPEAT
                //Post Leave Journals
                leaveLedger.INIT;
                leaveLedger."Entry No." := lastNo;
                leaveLedger."Employee No" := hrLeaveJournal."Staff No.";
                leaveLedger."Document No" := hrLeaveJournal."Document No.";
                leaveLedger."Leave Type" := hrLeaveJournal."Leave Type";
                leaveLedger."Transaction Date" := hrLeaveJournal."Posting Date";
                leaveLedger."Transaction Type" := hrLeaveJournal."Transaction Type";
                IF ((hrLeaveJournal."Transaction Type" = hrLeaveJournal."Transaction Type"::"Positive Adjustment") OR
                (hrLeaveJournal."Transaction Type" = hrLeaveJournal."Transaction Type"::Allocation)) THEN
                    leaveLedger."No. of Days" := hrLeaveJournal."No. of Days"
                ELSE
                    IF ((hrLeaveJournal."Transaction Type" = hrLeaveJournal."Transaction Type"::"Negative Adjustment") OR
                    (hrLeaveJournal."Transaction Type" = hrLeaveJournal."Transaction Type"::Application)) THEN
                        leaveLedger."No. of Days" := ((hrLeaveJournal."No. of Days") * (-1));

                leaveLedger."Transaction Description" := hrLeaveJournal."Transaction Description";
                leaveLedger."Leave Period" := DATE2DWY(TODAY, 3);
                leaveLedger.INSERT;
                lastNo := lastNo + 10;
                // Insert into the ledger entry table
                IF HrEmployee.GET(hrLeaveJournal."Staff No.") THEN BEGIN
                END;
                CLEAR(Var1);
                counts := counts + 1;
                IF counts = 1 THEN
                    RecCount1 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                ELSE
                    IF counts = 2 THEN BEGIN
                        RecCount2 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                    END
                    ELSE
                        IF counts = 3 THEN BEGIN
                            RecCount3 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                        END
                        ELSE
                            IF counts = 4 THEN BEGIN
                                RecCount4 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                            END
                            ELSE
                                IF counts = 5 THEN BEGIN
                                    RecCount5 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                END
                                ELSE
                                    IF counts = 6 THEN BEGIN
                                        RecCount6 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                    END
                                    ELSE
                                        IF counts = 7 THEN BEGIN
                                            RecCount7 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                        END
                                        ELSE
                                            IF counts = 8 THEN BEGIN
                                                RecCount8 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                            END
                                            ELSE
                                                IF counts = 9 THEN BEGIN
                                                    RecCount9 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                END
                                                ELSE
                                                    IF counts = 10 THEN BEGIN
                                                        RecCount10 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                    END ELSE
                                                        IF counts > 10 THEN BEGIN
                                                            RecCount1 := RecCount2;
                                                            RecCount2 := RecCount3;
                                                            RecCount3 := RecCount4;
                                                            RecCount4 := RecCount5;
                                                            RecCount5 := RecCount6;
                                                            RecCount6 := RecCount7;
                                                            RecCount7 := RecCount8;
                                                            RecCount8 := RecCount9;
                                                            RecCount9 := RecCount10;
                                                            RecCount10 := FORMAT(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                                                        END;
                CLEAR(BufferString);
                BufferString := 'Total Records processed = ' + FORMAT(counts);

                progre.UPDATE();

            UNTIL hrLeaveJournal.NEXT = 0;
            ////Progress Window
            progre.CLOSE;
        END;
        hrLeaveJournal.DELETEALL;
        MESSAGE('Leave Journal posted successfully!');
    end;

    var
        lastNo: Integer;
        hrLeaveJournal: Record "HRM-Employee Leave Journal";
        leaveLedger: Record "HRM-Leave Ledger";
        objEmp: Record "HRM-Employee (D)";
        SalCard: Record "PRL-Salary Card";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "prPayrollProcessing";
        HrEmployee: Record "HRM-Employee (D)";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PRL-Period Transactions";
        prEmployerDeductions: Record "PRL-Employer Deductions";
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";
        HREmp: Record "HRM-Employee (D)";
        j: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        salaryCard: Record "PRL-Salary Card";
        dateofJoining: Date;
        dateofLeaving: Date;
        GetsPAYERelief: Boolean;
        DOJ: Date;
        SalCard2: Record "PRL-Salary Card";
}

