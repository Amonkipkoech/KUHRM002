report 51103 prPayrollJournalTransfer
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem6207; "PRL-Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code", "Period Month";

            trigger OnAfterGetRecord()
            begin
                //For use when posting Pension and NSSF
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
                IF objPeriod.FIND('-') THEN BEGIN

                    //Get the staff details (header)
                    objEmp.SETRANGE(objEmp."No.", "Employee Code");
                    IF objEmp.FIND('-') THEN BEGIN
                        strEmpName := '[' + "Employee Code" + '] ' + objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                        //GlobalDim1 := objEmp."Department Code";
                    END;

                    LineNumber := LineNumber + 10;


                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                    IF PeriodTrans.FIND('-') THEN BEGIN
                        REPEAT
                            Clear(campusCode);
                            Clear(departCode);
                            IF PeriodTrans."Journal Account Code" <> '' THEN BEGIN

                                /* SaccoTransactionType:=SaccoTransactionType::" ";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan THEN
                                   SaccoTransactionType:=SaccoTransactionType::Repayment;

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Interest Paid";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Welfare Contribution";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Deposit Contribution";
                                */

                                hrEmp.Reset();
                                hrEmp.SetRange("No.", PeriodTrans."Employee Code");
                                if hrEmp.Find('-') then begin
                                    departCode := hrEmp."Department Code";
                                    campusCode := hrEmp.Campus;
                                end;
                                // Insert into Journal Details

                                PayrollJournalDetails.RESET;
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Employee Code", PeriodTrans."Employee Code");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Transaction Code", PeriodTrans."Transaction Code");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Period Month", PeriodTrans."Period Month");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Period Year", PeriodTrans."Period Year");
                                IF PayrollJournalDetails.FIND('-') THEN BEGIN
                                    PayrollJournalDetails."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalDetails."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalDetails.Amount := PeriodTrans.Amount;
                                    PayrollJournalDetails."Post as" := PeriodTrans."Post As";
                                    PayrollJournalDetails."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalDetails."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalDetails."Department Code" := departCode;
                                    PayrollJournalDetails.Campus := campusCode;
                                    PayrollJournalDetails.MODIFY;
                                END ELSE BEGIN
                                    PayrollJournalDetails.INIT;
                                    PayrollJournalDetails."Employee Code" := PeriodTrans."Employee Code";
                                    PayrollJournalDetails."Transaction Code" := PeriodTrans."Transaction Code";
                                    PayrollJournalDetails."Period Month" := PeriodTrans."Period Month";
                                    PayrollJournalDetails."Period Year" := PeriodTrans."Period Year";
                                    PayrollJournalDetails."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalDetails."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalDetails."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalDetails.Amount := PeriodTrans.Amount;
                                    PayrollJournalDetails."Post as" := PeriodTrans."Post As";
                                    PayrollJournalDetails."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalDetails."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalDetails."Department Code" := departCode;
                                    PayrollJournalDetails.Campus := campusCode;
                                    PayrollJournalDetails.INSERT;
                                END;// Does not exist, Insert

                                //test test
                                // journalDetailed.RESET;
                                // journalDetailed.SETRANGE(journalDetailed."Transaction Code", PeriodTrans."Transaction Code");
                                // journalDetailed.SETRANGE(journalDetailed."Period Month", PeriodTrans."Period Month");
                                // journalDetailed.SETRANGE(journalDetailed."Period YearS", PeriodTrans."Period Year");
                                // journalDetailed.SetRange("Department Code", departCode);
                                // IF journalDetailed.FIND('-') THEN BEGIN
                                //     journalDetailed."G/L Account" := PeriodTrans."Journal Account Code";
                                //     journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                                //     journalDetailed."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                //     journalDetailed."Post as" := PeriodTrans."Post As";
                                //     journalDetailed."coop parameters" := PeriodTrans."coop parameters";
                                //     journalDetailed."Journal Account Type" := PeriodTrans."Journal Account Type";
                                //     journalDetailed."Department Code" := departCode;
                                //     journalDetailed.Campus := campusCode;
                                //     journalDetailed.MODIFY;
                                // END ELSE BEGIN
                                //     journalDetailed.INIT;
                                //     journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
                                //     journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                                //     journalDetailed."G/L Account" := PeriodTrans."Journal Account Code";
                                //     journalDetailed."Period Month" := PeriodTrans."Period Month";
                                //     journalDetailed."Period YearS" := PeriodTrans."Period Year";
                                //     journalDetailed."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                //     journalDetailed."Post as" := PeriodTrans."Post As";
                                //     journalDetailed."coop parameters" := PeriodTrans."coop parameters";
                                //     journalDetailed."Journal Account Type" := PeriodTrans."Journal Account Type";
                                //     journalDetailed."Department Code" := departCode;
                                //     journalDetailed.Campus := campusCode;
                                //     journalDetailed.INSERT;
                                // END;
                                //end test
                                // Insert into Journal Summary
                                PayrollJournalSummary.RESET;
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Transaction Code", PeriodTrans."Transaction Code");
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period Month", PeriodTrans."Period Month");
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period YearS", PeriodTrans."Period Year");
                                PayrollJournalSummary.SetRange("Department Code", departCode);
                                IF PayrollJournalSummary.FIND('-') THEN BEGIN
                                    PayrollJournalSummary."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalSummary."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalSummary."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalSummary."Post as" := PeriodTrans."Post As";
                                    PayrollJournalSummary."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalSummary."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalSummary."Department Code" := departCode;
                                    PayrollJournalSummary.Campus := campusCode;
                                    PayrollJournalSummary.MODIFY;
                                END ELSE BEGIN
                                    PayrollJournalSummary.INIT;
                                    PayrollJournalSummary."Transaction Code" := PeriodTrans."Transaction Code";
                                    PayrollJournalSummary."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalSummary."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalSummary."Period Month" := PeriodTrans."Period Month";
                                    PayrollJournalSummary."Period YearS" := PeriodTrans."Period Year";
                                    PayrollJournalSummary."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalSummary."Post as" := PeriodTrans."Post As";
                                    PayrollJournalSummary."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalSummary."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalSummary."Department Code" := departCode;
                                    PayrollJournalSummary.Campus := campusCode;
                                    PayrollJournalSummary.INSERT;
                                END;

                                /*

                                    //Pension
                                    IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::Pension THEN BEGIN
                                      //Get from Employer Deduction
                                      EmployerDed.RESET;
                                      EmployerDed.SETRANGE(EmployerDed."Employee Code",PeriodTrans."Employee Code");
                                      EmployerDed.SETRANGE(EmployerDed."Transaction Code",PeriodTrans."Transaction Code");
                                      EmployerDed.SETRANGE(EmployerDed."Payroll Period",PeriodTrans."Payroll Period");
                                      IF EmployerDed.FIND('-') THEN BEGIN
                                      //Credit Payables
                                          CreateJnlEntry(0,PostingGroup."Pension Employee Acc",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,
                                          EmployerDed.Amount,PeriodTrans."Post As",'',SaccoTransactionType,PostingGroup."Pension Payable Acc");

                                      //Debit Staff Expense
                                          CreateJnlEntry(0,PostingGroup."Pension Employer Acc",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",EmployerDed.Amount,0,1,'',
                                          SaccoTransactionType,PostingGroup."Pension Payable Acc");

                                      END;
                                    END;

                                    //NSSF
                                    IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::NSSF THEN BEGIN
                                       //Credit Payables
                                      //Credit Payables

                                          CreateJnlEntry(0,PostingGroup."NSSF Employee Account",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,PeriodTrans.Amount,
                                          PeriodTrans."Post As",'',SaccoTransactionType,PostingGroup."NSSF Payable Acc");

                                      //Debit Staff Expense

                                          CreateJnlEntry(0,PostingGroup."NSSF Employer Account",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",PeriodTrans.Amount,0,1,'',
                                          SaccoTransactionType,PostingGroup."NSSF Payable Acc");


                                    END;*/


                            END;
                        UNTIL PeriodTrans.NEXT = 0;
                    END;
                END;

            end;

            trigger OnPostDataItem()
            var
                PensionAmountToPost: Decimal;
                NssfAmountToPost: Decimal;
            begin
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
                IF objPeriod.FIND('-') THEN BEGIN
                    "Slip/Receipt No" := UpperCase(objPeriod."Period Name");
                    PayrollJournalSummary.RESET;
                    PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period Month", objPeriod."Period Month");
                    PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period YearS", objPeriod."Period Year");
                    //PayrollJournalSummary.SetRange(PayrollJournalSummary."Department Code", departCode);
                    IF PayrollJournalSummary.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            TransCode.Reset();
                            TransCode.SetRange("Transaction Code", PayrollJournalSummary."Transaction Code");
                            if TransCode.Find('-') then begin
                                IF TransCode."Transaction Type" = TransCode."Transaction Type"::Deduction then begin
                                    PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.Amount2);

                                    AmountToDebit := 0;
                                    AmountToCredit := 0;
                                    IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Debit THEN
                                        AmountToDebit := PayrollJournalSummary.Amount2;

                                    IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Credit THEN
                                        AmountToCredit := PayrollJournalSummary.Amount2;

                                    IF PayrollJournalSummary."Journal Account Type" = 1 THEN
                                        IntegerPostAs := 0;
                                    IF PayrollJournalSummary."Journal Account Type" = 2 THEN
                                        IntegerPostAs := 1;

                                    IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::Pension) THEN BEGIN
                                        IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::NSSF) THEN BEGIN
                                            // Neither NSSF Nor Pension


                                            CreateJnlEntry(IntegerPostAs, PayrollJournalSummary."G/L Account",
                                            PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", PayrollJournalSummary."Posting Description", AmountToDebit, AmountToCredit,
                                            PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Net Salary Payable");
                                        END ELSE BEGIN
                                            // NSSF i.e. has employer Factor for NSSF
                                            CLEAR(NssfAmountToPost);
                                            PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.Amount2);
                                            NssfAmountToPost := PayrollJournalSummary.Amount2;
                                            //EmployerDed.RESET;

                                            //EmployerDed.SETRANGE(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                            // EmployerDed.SETRANGE(EmployerDed."Transaction Code", PayrollJournalSummary."Transaction Code");
                                            // EmployerDed.SETRANGE(EmployerDed."Payroll Period", objPeriod."Date Opened");
                                            // IF EmployerDed.FIND('-') THEN BEGIN
                                            // REPEAT
                                            // BEGIN
                                            //     NssfAmountToPost := NssfAmountToPost + EmployerDed.Amount;
                                            // END;
                                            // UNTIL EmployerDed.NEXT = 0;

                                            // PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.employerAmount);
                                            // NssfAmountToPost := PayrollJournalSummary.employerAmount;
                                            // PeriodTrans.Reset();
                                            // PeriodTrans.SetRange("Period Year", objPeriod."Period Year");
                                            // PeriodTrans.SetRange("Period Month", objPeriod."Period Month");
                                            // PeriodTrans.SetRange("Transaction Code", 'NSSF');
                                            // PeriodTrans.SetRange("Department Code", PayrollJournalSummary."Department Code");
                                            // if PeriodTrans.Find('-') then begin
                                            //     PeriodTrans.CalcSums(Amount);
                                            //     //NssfAmountToPost := PeriodTrans.Amount;
                                            // end;

                                            //Credit Payables
                                            CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                                            PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employeee-' + PayrollJournalSummary."Posting Description", 0,
                                            NssfAmountToPost, PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Net Salary Payable");

                                            //Debit Staff Expense
                                            CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                                            PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employee-' + PayrollJournalSummary."Posting Description", NssfAmountToPost, 0, 1, '',
                                            0, PostingGroup."NSSF Payable Acc");
                                            //END;
                                        END;
                                    end;

                                end
                                else begin
                                    if TransCode."Transaction Type" = TransCode."Transaction Type"::Income then begin
                                        PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.Amount);

                                        AmountToDebit := 0;
                                        AmountToCredit := 0;
                                        IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Debit THEN
                                            AmountToDebit := PayrollJournalSummary.Amount;

                                        IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Credit THEN
                                            AmountToCredit := PayrollJournalSummary.Amount;

                                        IF PayrollJournalSummary."Journal Account Type" = 1 THEN
                                            IntegerPostAs := 0;
                                        IF PayrollJournalSummary."Journal Account Type" = 2 THEN
                                            IntegerPostAs := 1;

                                        IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::Pension) THEN BEGIN
                                            IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::NSSF) THEN BEGIN
                                                // Neither NSSF Nor Pension


                                                CreateJnlEntry(IntegerPostAs, PayrollJournalSummary."G/L Account",
                                                PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", PayrollJournalSummary."Posting Description", AmountToDebit, AmountToCredit,
                                                PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Net Salary Payable");
                                            END ELSE BEGIN
                                                // NSSF i.e. has employer Factor for NSSF
                                                CLEAR(NssfAmountToPost);
                                                PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.Amount);
                                                NssfAmountToPost := PayrollJournalSummary.Amount;
                                                //EmployerDed.RESET;

                                                //EmployerDed.SETRANGE(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                                // EmployerDed.SETRANGE(EmployerDed."Transaction Code", PayrollJournalSummary."Transaction Code");
                                                // EmployerDed.SETRANGE(EmployerDed."Payroll Period", objPeriod."Date Opened");
                                                // IF EmployerDed.FIND('-') THEN BEGIN
                                                // REPEAT
                                                // BEGIN
                                                //     NssfAmountToPost := NssfAmountToPost + EmployerDed.Amount;
                                                // END;
                                                // UNTIL EmployerDed.NEXT = 0;

                                                // PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.employerAmount);
                                                // NssfAmountToPost := PayrollJournalSummary.employerAmount;
                                                // PeriodTrans.Reset();
                                                // PeriodTrans.SetRange("Period Year", objPeriod."Period Year");
                                                // PeriodTrans.SetRange("Period Month", objPeriod."Period Month");
                                                // PeriodTrans.SetRange("Transaction Code", 'NSSF');
                                                // PeriodTrans.SetRange("Department Code", PayrollJournalSummary."Department Code");
                                                // if PeriodTrans.Find('-') then begin
                                                //     PeriodTrans.CalcSums(Amount);
                                                //     //NssfAmountToPost := PeriodTrans.Amount;
                                                // end;

                                                //Credit Payables
                                                CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                                                PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employeee-' + PayrollJournalSummary."Posting Description", 0,
                                                NssfAmountToPost, PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Net Salary Payable");

                                                //Debit Staff Expense
                                                CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                                                PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employee-' + PayrollJournalSummary."Posting Description", NssfAmountToPost, 0, 1, '',
                                                0, PostingGroup."NSSF Payable Acc");
                                                //END;
                                            END;
                                        end;

                                    end;
                                end;



                            END ELSE BEGIN
                                // Pension i.e. has employer Factor
                                CLEAR(PensionAmountToPost);
                                EmployerDed.RESET;
                                // EmployerDed.SETRANGE(EmployerDed."Employee Code",PeriodTrans."Employee Code");
                                EmployerDed.SETRANGE(EmployerDed."Transaction Code", PayrollJournalSummary."Transaction Code");
                                EmployerDed.SETRANGE(EmployerDed."Payroll Period", objPeriod."Date Opened");
                                EmployerDed.SetRange(EmployerDed."Department Code", PayrollJournalSummary."Department Code");
                                IF EmployerDed.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        PensionAmountToPost := PensionAmountToPost + EmployerDed.Amount;
                                    END;
                                    UNTIL EmployerDed.NEXT = 0;

                                    //Credit Payables

                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employer-' + PayrollJournalSummary."Posting Description", 0,
                                    PensionAmountToPost, PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Pension Payable Acc");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    PayrollJournalSummary.Campus, PayrollJournalSummary."Department Code", 'Employer-' + PayrollJournalSummary."Posting Description", PensionAmountToPost, 0, 1, '',
                                    0, PostingGroup."Pension Payable Acc");
                                END;
                            END;
                        END;
                        UNTIL PayrollJournalSummary.NEXT = 0;
                    END;
                END;

                PayrollJournalDetails.RESET;
                IF PayrollJournalDetails.FIND('-') THEN BEGIN
                    PayrollJournalDetails.DELETEALL
                END;

                PayrollJournalSummary.RESET;
                IF PayrollJournalSummary.FIND('-') THEN BEGIN
                    PayrollJournalSummary.DELETEALL
                END;

                MESSAGE('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin
                PostingGroup.GET('PAYROLL');
                PostingGroup.TESTFIELD("NSSF Employer Account");
                PostingGroup.TESTFIELD("NSSF Employee Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                PostingGroup.TESTFIELD("Pension Employee Acc");
                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.RESET;
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name, 'SALARIES');
                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                    GenJnlBatch.INIT;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARIES';
                    GenJnlBatch.INSERT;
                END;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SETRANGE(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                IF GeneraljnlLine.FIND('-') THEN
                    GeneraljnlLine.DELETEALL;

                //"Slip/Receipt No" := UPPERCASE(PeriodName);

                //"PRL-Salary Card".SETRANGE("PRL-Salary Card"."Payroll Period",SelectedPeriod);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PeriodFilter; PeriodFilter)
                {
                    Caption = 'Period Filter';
                    Lookup = true;
                    LookupPageID = "PRL-Payroll Periods";
                    TableRelation = "PRL-Payroll Periods";
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN PeriodName := objPeriod."Period Name";

        PostingDate := CALCDATE('1M-1D', SelectedPeriod);
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";
        objEmp: Record "HRM-Employee (D)";
        PeriodName: Text[30];
        PeriodFilter: Date;
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Payroll Periods";
        ControlInfo: Record "HRM-Control-Information";
        strEmpName: Text[150];
        GeneraljnlLine: Record 81;
        GenJnlBatch: Record 232;
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record 61105;
        TaxableAmount: Decimal;
        PostingGroup: Record "PRL-Employee Posting Group";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        TransCode: Record "PRL-Transaction Codes";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        EmployerDed: Record "PRL-Employer Deductions";
        PeriodFilter2: Code[20];
        PayrollJournalDetails: Record "Payroll Journal Details";
        PayrollJournalSummary: Record "Payroll Journal Summary";
        hrEmp: Record "HRM-Employee (D)";
        departCode: Text;
        campusCode: Text;
        journalDetailed: Record "Journals Buffer";




    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; BalAccountNo: Code[20])
    begin

        LineNumber := LineNumber + 100;
        GeneraljnlLine.INIT;
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'SALARIES';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        //GeneraljnlLine."Loan No":=LoanNo;
        //GeneraljnlLine."Transaction Type":=TransType;
        GeneraljnlLine."Posting Date" := PostingDate;
#pragma warning disable AL0603
        GeneraljnlLine."Account Type" := AccountType;
#pragma warning restore AL0603
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        IF PostAs = PostAs::Debit THEN BEGIN
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.VALIDATE("Debit Amount");
        END ELSE BEGIN
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.VALIDATE("Credit Amount");
        END;
        GeneraljnlLine."Bal. Account No." := BalAccountNo;
        GeneraljnlLine."Gen. Bus. Posting Group" := '';
        GeneraljnlLine."Gen. Prod. Posting Group" := '';
        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        //GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        //GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
        IF GeneraljnlLine.Amount <> 0 THEN
            GeneraljnlLine.INSERT;
    end;

    procedure getTrans1()
    begin
        TransCode.Reset();
        TransCode.SetRange("Transaction Type", TransCode."Transaction Type"::Deduction);
        if TransCode.Find('-') then begin
            repeat
                PeriodTrans.Reset();
                PeriodTrans.SetRange("Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange("Transaction Code", TransCode."Transaction Code");
                if PeriodTrans.Find('-') then begin
                    PeriodTrans.CalcSums(Amount);
                    journalDetailed.DeleteAll();
                    journalDetailed.Init();
                    journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
                    journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                    journalDetailed.Amount := PeriodTrans.Amount;
                    journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
                    journalDetailed."Period Month" := PeriodTrans."Period Month";
                    journalDetailed."Period YearS" := PeriodTrans."Period Year";
                    journalDetailed.Insert();
                end;
            until TransCode.Next() = 0;
        end;
    end;
}

