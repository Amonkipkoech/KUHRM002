page 80006 "Payroll Journal Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payroll Journal Batches";




    layout
    {
        area(Content)
        {
            group("Journal Details")
            {
                field(payrollPeriod; Rec.payrollPeriod)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the payrollPeriod field.';
                }
                field(periodName; Rec.periodName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the periodName field.';
                }
                field(createdBy; Rec.createdBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the createdBy field.';
                }
                field(dateCreated; Rec.dateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dateCreated field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }

            }
            part(JounalLines; PrlJournals)
            {
                //Editable = enabledisFields;
                Caption = 'JounalLines';
                SubPageLink = "Payroll Period" = field(payrollPeriod);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Journals")
            {
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                begin
                    getTrans();
                end;
            }
            action("Send to Finance")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Verified;
                    Rec."Verified By" := UserId;
                    Rec.Modify();
                end;
            }
            action("Post Journal Lines")
            {
                ApplicationArea = All;
                Image = PostBatch;

                trigger OnAction()
                begin
                    postJournalLines();
                end;
            }
        }
    }

    var
        journalDetailed: Record "Journals Buffer";
        PeriodTrans: Record "PRL-Period Transactions";
        TransCode: Record "PRL-Transaction Codes";
        transSum: decimal;
        hrEmp: Record "HRM-Employee (D)";
        department: Record "Dimension Value";
        glAcc: Record "G/L Account";
        empDed: Record "PRL-Employer Deductions";
        basc: Decimal;
        GeneraljnlLine: Record 81;
        GeneraljnlLineBatch: Record 232;
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        PostingDate: Date;
        GLPosting: Codeunit 12;
        amountToPost: Decimal;
        enabledisFields: Boolean;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            enabledisFields := false;
    end;

    procedure postJournalLines()
    begin
        GeneraljnlLineBatch.RESET;
        GeneraljnlLineBatch.SETRANGE(GeneraljnlLineBatch."Journal Template Name", 'GENERAL');
        GeneraljnlLineBatch.SETRANGE(GeneraljnlLineBatch.Name, 'SALARIES');
        IF GeneraljnlLineBatch.FIND('-') = FALSE THEN BEGIN
            GeneraljnlLineBatch.INIT;
            GeneraljnlLineBatch."Journal Template Name" := 'GENERAL';
            GeneraljnlLineBatch.Name := 'SALARIES';
            GeneraljnlLineBatch.INSERT;
        END;
        GeneraljnlLine.RESET;
        GeneraljnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GeneraljnlLine.SETRANGE("Journal Batch Name", 'SALARIES');
        IF GeneraljnlLine.FIND('-') THEN GeneraljnlLine.DELETEALL;
        journalDetailed.Reset();
        journalDetailed.SetRange("Payroll Period", Rec.payrollPeriod);
        if journalDetailed.Find('-') then begin
            repeat
                CreateJnlEntry(rec.periodName, journalDetailed."G/L Account", journalDetailed.BalancingAcc, journalDetailed.Amount, journalDetailed."Account Name" + ' ' + Rec.periodName, journalDetailed."Department Code");
            until journalDetailed.Next() = 0;
        end;
    end;

    procedure CreateJnlEntry(docNo: code[20]; accountNo: code[20]; balAcc: code[20]; amount: decimal; desc: text[100]; GlobalDime2: Code[20])
    begin
        // Clear the journal Lines
        GeneraljnlLine.INIT;
        GeneraljnlLine."Line No." := GeneraljnlLine."Line No." + 110000;
        GeneraljnlLine."Posting Date" := Rec."Posting Date";
        GeneraljnlLine."Document No." := docNo;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Document No.");
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'SALARIES';
        GeneraljnlLine."Document Type" := GeneraljnlLine."Document Type"::Payment;
        GeneraljnlLine."Account Type" := GeneraljnlLine."Account Type"::"G/L Account";
        GeneraljnlLine."External Document No." := docNo;
        GeneraljnlLine."Account No." := accountNo;
        GeneraljnlLine."Bal. Account No." := balAcc;
        GeneraljnlLine.Amount := Round(amount, 1);
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
        GeneraljnlLine.VALIDATE(GeneraljnlLine.Amount);
        GeneraljnlLine.Description := desc;
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.INSERT;

        //posting
        // GeneraljnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        // GeneraljnlLine.SetRange("Journal Batch Name", 'SALARIES');
        // IF GeneraljnlLine.FIND('-') THEN BEGIN
        //     REPEAT
        //         GLPosting.RUN(GeneraljnlLine);
        //     UNTIL GeneraljnlLine.NEXT = 0;
        // END;
    end;

    procedure getTrans()
    begin
        TransCode.Reset();
        TransCode.SetRange("Transaction Type", TransCode."Transaction Type"::Deduction);
        if TransCode.Find('-') then begin
            //journalDetailed.DeleteAll();
            Clear(transSum);
            repeat
                PeriodTrans.Reset();
                PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
                PeriodTrans.SetRange("Transaction Code", TransCode."Transaction Code");
                PeriodTrans.SetFilter("Group Text", '%1|%2', 'DEDUCTIONS', 'STATUTORIES');
                //PeriodTrans.SetRange("Group Text", 'STATUTORIES');
                if PeriodTrans.Find('-') then begin
                    journalDetailed.Init();
                    journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
                    journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                    journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
                    journalDetailed."Period Month" := PeriodTrans."Period Month";
                    journalDetailed."Period YearS" := PeriodTrans."Period Year";
                    journalDetailed."G/L Account" := TransCode."GL Account";
                    glAcc.Reset();
                    glAcc.SetRange("No.", TransCode."GL Account");
                    if glAcc.Find('-') then begin
                        journalDetailed."Account Name" := glAcc.Name;
                    end;
                    repeat
                        transSum += PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;
                    journalDetailed.Amount := transSum * -1;
                    journalDetailed.Insert();
                    Clear(transSum);
                end;

            until TransCode.Next() = 0;
        end;

        //netpay
        TransCode.Reset();
        TransCode.SetRange("Transaction Code", 'NPAY');
        if TransCode.Find('-') then begin
            //journalDetailed.DeleteAll();
            Clear(transSum);
            PeriodTrans.Reset();
            PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
            PeriodTrans.SetRange("Transaction Code", TransCode."Transaction Code");
            // PeriodTrans.SetRange("Group Text", 'DEDUCTIONS');
            if PeriodTrans.Find('-') then begin
                journalDetailed.Init();
                journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
                journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
                journalDetailed."Period Month" := PeriodTrans."Period Month";
                journalDetailed."Period YearS" := PeriodTrans."Period Year";
                journalDetailed."G/L Account" := TransCode."GL Account";
                glAcc.Reset();
                glAcc.SetRange("No.", TransCode."GL Account");
                if glAcc.Find('-') then begin
                    journalDetailed."Account Name" := glAcc.Name;
                end;
                repeat
                    transSum += PeriodTrans.Amount;
                until PeriodTrans.Next() = 0;
                journalDetailed.Amount := transSum * -1;
                journalDetailed.Insert();
                Clear(transSum);
            end;
        end;

        //CALCULATE Employer
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
        PeriodTrans.SetRange("Transaction Code", 'NSSF(I)');
        if PeriodTrans.Find('-') then begin
            journalDetailed.Init();
            journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
            journalDetailed."Transaction Name" := 'NSSF EMPLOYER';
            journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
            journalDetailed."Period Month" := PeriodTrans."Period Month";
            journalDetailed."Period YearS" := PeriodTrans."Period Year";
            journalDetailed."G/L Account" := '15060704';
            journalDetailed.BalancingAcc := '23214901';
            journalDetailed."Account Name" := 'Nssf Deductions';
            repeat
                transSum += PeriodTrans.Amount;
            until PeriodTrans.Next() = 0;
            journalDetailed.Amount := transSum * -1;
            journalDetailed.Insert();
            Clear(transSum);
        end;
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
        PeriodTrans.SetRange("Transaction Code", 'D-55');
        if PeriodTrans.Find('-') then begin
            journalDetailed.Init();
            journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
            journalDetailed."Transaction Name" := 'HL-Employer';
            journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
            journalDetailed."Period Month" := PeriodTrans."Period Month";
            journalDetailed."Period YearS" := PeriodTrans."Period Year";
            journalDetailed."G/L Account" := '15060707';
            journalDetailed.BalancingAcc := '23214901';
            journalDetailed."Account Name" := 'Housing Levy Employer';
            repeat
                transSum += PeriodTrans.Amount;
            until PeriodTrans.Next() = 0;
            journalDetailed.Amount := transSum * -1;
            journalDetailed.Insert();
            Clear(transSum);
        end;
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
        PeriodTrans.SetRange("Transaction Code", 'D-56');
        if PeriodTrans.Find('-') then begin
            journalDetailed.Init();
            journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
            journalDetailed."Transaction Name" := 'HL-Employer Arreas';
            journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
            journalDetailed."Period Month" := PeriodTrans."Period Month";
            journalDetailed."Period YearS" := PeriodTrans."Period Year";
            journalDetailed."G/L Account" := '15060707';
            journalDetailed.BalancingAcc := '23214901';
            journalDetailed."Account Name" := 'Housing Levy Employer Arreas';
            repeat
                transSum += PeriodTrans.Amount;
            until PeriodTrans.Next() = 0;
            journalDetailed.Amount := transSum * -1;
            journalDetailed.Insert();
            Clear(transSum);
        end;
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
        PeriodTrans.SetRange("Transaction Code", 'D-20');
        IF PeriodTrans.Find('-') then begin
            journalDetailed.Init();
            journalDetailed."Transaction Code" := 'PRV-EMP';
            journalDetailed."Transaction Name" := 'PROVIDENT CONTRIBUTION';
            journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
            journalDetailed."Period Month" := PeriodTrans."Period Month";
            journalDetailed."Period YearS" := PeriodTrans."Period Year";
            journalDetailed."G/L Account" := '15060921';
            journalDetailed.BalancingAcc := '23213300';
            journalDetailed."Account Name" := 'Provident Fund Deductions';
            repeat
                basc := (PeriodTrans.Amount * 100) / 5;
                transSum += (basc) * 0.06;
            until PeriodTrans.Next() = 0;
            journalDetailed.Amount := transSum * -1;
            journalDetailed.Insert();
            Clear(transSum);
        end;

        TransCode.Reset();
        TransCode.SetRange("Transaction Type", TransCode."Transaction Type"::Income);
        //TransCode.SetFilter("Transaction Code", '<>%1', 'BPAY');
        //TransCode.SetFilter("Transaction Code", '<>%1', 'NPAY');
        if TransCode.Find('-') then begin
            //journalDetailed.DeleteAll();
            Clear(transSum);
            repeat
                department.Reset();
                department.SetRange("Global Dimension No.", 2);
                if department.Find('-') then begin
                    repeat
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange("Payroll Period", Rec.payrollPeriod);
                        PeriodTrans.SetRange("Transaction Code", TransCode."Transaction Code");
                        PeriodTrans.SetRange("Department Code", department.Code);
                        if PeriodTrans.Find('-') then begin
                            IF (PeriodTrans."Transaction Code" <> 'NPAY') then begin
                                journalDetailed.Init();
                                journalDetailed."Transaction Code" := PeriodTrans."Transaction Code";
                                journalDetailed."Transaction Name" := PeriodTrans."Transaction Name";
                                journalDetailed."Payroll Period" := PeriodTrans."Payroll Period";
                                journalDetailed."Period Month" := PeriodTrans."Period Month";
                                journalDetailed."Period YearS" := PeriodTrans."Period Year";
                                journalDetailed."G/L Account" := TransCode."GL Account";
                                glAcc.Reset();
                                glAcc.SetRange("No.", TransCode."GL Account");
                                if glAcc.Find('-') then begin
                                    journalDetailed."Account Name" := glAcc.Name;
                                end;
                                repeat
                                    transSum += PeriodTrans.Amount;
                                until PeriodTrans.Next() = 0;
                                journalDetailed.Amount := transSum;
                                journalDetailed."Department Code" := PeriodTrans."Department Code";
                                journalDetailed.Insert();
                                Clear(transSum);
                            end


                        end;
                    until department.Next() = 0;
                end;
            until TransCode.Next() = 0;
        end;

    end;
}