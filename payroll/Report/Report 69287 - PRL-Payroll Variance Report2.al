report 72029 "PRL-Payroll Variance Report2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-Payroll Variance Report2.rdlc';

    dataset
    {
        dataitem("PRL-Variance Trans. Code Buff"; "PRL-Variance Trans. Code Buff")
        {
            column(CompName; compInfo.Name)
            {
            }
            column(Address1; compInfo.Address)
            {
            }
            column(Address2; compInfo."Address 2")
            {
            }
            column(Phone1; compInfo."Phone No.")
            {
            }
            column(Phone2; compInfo."Phone No. 2")
            {
            }
            column(pics; compInfo.Picture)
            {
            }
            column(Emails; compInfo."E-Mail")
            {
            }
            column(Homep; compInfo."Home Page")
            {
            }
            column(DateFilter; PeriFilter)
            {
            }
            column(TransCode; "PRL-Variance Trans. Code Buff"."Transaction Code")
            {
            }
            column(EmpCode; "PRL-Variance Trans. Code Buff"."Emp. Code")
            {
            }
            column(TransName; "PRL-Variance Trans. Code Buff"."Transaction Name")
            {
            }
            column(EmpName; "PRL-Variance Trans. Code Buff"."Emp. Name")
            {
            }
            column(CurrAmount; "PRL-Variance Trans. Code Buff"."Current Amount")
            {
            }
            column(PrevAmount; "PRL-Variance Trans. Code Buff"."Previous Amount")
            {
            }
            column(CurrPeriod; PRLPayrollPeriodsCurr."Period Name")
            {
            }
            column(PrevPeriod; PRLPayrollPeriodsPrev."Period Name")
            {
            }
            column(variance; "PRL-Variance Trans. Code Buff"."Current Amount" - "PRL-Variance Trans. Code Buff"."Previous Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "PRL-Variance Trans. Code Buff"."Current Amount" = "PRL-Variance Trans. Code Buff"."Previous Amount" THEN CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PeriodFilter; PeriFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the Period Filter field.';
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

    trigger OnInitReport()
    begin
        compInfo.RESET;
        IF compInfo.FIND('-') THEN BEGIN
            compInfo.CALCFIELDS(compInfo.Picture);
        END;




        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods.Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            PeriFilter := PRLPayrollPeriods."Date Opened";
        END ELSE
            ERROR('No Open period in the filters');
    end;

    trigger OnPreReport()
    begin
        PRLVarianceTransCodeBuff2.RESET;
        IF PRLVarianceTransCodeBuff2.FIND('-') THEN PRLVarianceTransCodeBuff2.DELETEALL;
        IF PeriFilter = 0D THEN ERROR('Invalid date specified');
        PRLPayrollPeriodsCurr.RESET;
        PRLPayrollPeriodsCurr.SETRANGE(PRLPayrollPeriodsCurr."Date Opened", PeriFilter);
        IF PRLPayrollPeriodsCurr.FIND('-') THEN BEGIN
            CurrentMonth := PRLPayrollPeriodsCurr."Period Month";
            CurrentYear := PRLPayrollPeriodsCurr."Period Year";

            IF CurrentMonth = 1 THEN BEGIN
                PrevMonth := 12;
                PrevYear := CurrentYear - 1;
            END ELSE BEGIN
                PrevMonth := CurrentMonth - 1;
                PrevYear := CurrentYear;
            END;
        END;

        PRLPayrollPeriodsPrev.RESET;
        PRLPayrollPeriodsPrev.SETRANGE(PRLPayrollPeriodsPrev."Period Month", PrevMonth);
        PRLPayrollPeriodsPrev.SETRANGE(PRLPayrollPeriodsPrev."Period Year", PrevYear);
        IF PRLPayrollPeriodsPrev.FIND('-') THEN BEGIN
        END;
        // Curent Period data
        PRLPeriodTransactionsCurr.RESET;
        PRLPeriodTransactionsCurr.SETRANGE(PRLPeriodTransactionsCurr."Period Month", CurrentMonth);
        PRLPeriodTransactionsCurr.SETRANGE(PRLPeriodTransactionsCurr."Period Year", CurrentYear);
        PRLPeriodTransactionsCurr.SETFILTER(PRLPeriodTransactionsCurr."Group Order", '<>%1', 6);
        PRLPeriodTransactionsCurr.SETFILTER(PRLPeriodTransactionsCurr."Transaction Code", '<>%1', 'TOT-DED');
        IF PRLPeriodTransactionsCurr.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HRMEmployeeD.RESET;
                HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", PRLPeriodTransactionsCurr."Employee Code");
                IF HRMEmployeeD.FIND('-') THEN BEGIN
                END;

                PRLVarianceTransCodeBuff.RESET;
                PRLVarianceTransCodeBuff.SETRANGE(PRLVarianceTransCodeBuff."Transaction Code", PRLPeriodTransactionsCurr."Transaction Code");
                PRLVarianceTransCodeBuff.SETRANGE(PRLVarianceTransCodeBuff."Emp. Code", PRLPeriodTransactionsCurr."Employee Code");
                IF NOT PRLVarianceTransCodeBuff.FIND('-') THEN BEGIN
                    // Insert Here
                    PRLVarianceTransCodeBuff.INIT;
                    PRLVarianceTransCodeBuff."Transaction Code" := PRLPeriodTransactionsCurr."Transaction Code";
                    PRLVarianceTransCodeBuff."Transaction Name" := PRLPeriodTransactionsCurr."Transaction Name";
                    PRLVarianceTransCodeBuff."Emp. Code" := PRLPeriodTransactionsCurr."Employee Code";
                    PRLVarianceTransCodeBuff."Emp. Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                    PRLVarianceTransCodeBuff."Current Amount" := PRLPeriodTransactionsCurr.Amount;
                    PRLVarianceTransCodeBuff."Previous Amount" := 0;
                    PRLVarianceTransCodeBuff."Current Month" := CurrentMonth;
                    PRLVarianceTransCodeBuff."Previous Month" := PrevMonth;
                    PRLVarianceTransCodeBuff."Current Year" := CurrentYear;
                    PRLVarianceTransCodeBuff."Previous Year" := PrevYear;
                    PRLVarianceTransCodeBuff.INSERT;
                END ELSE BEGIN
                    //PRLVarianceTransCodeBuff."Transaction Code":=PRLPeriodTransactionsCurr."Transaction Code";
                    PRLVarianceTransCodeBuff."Transaction Name" := PRLPeriodTransactionsCurr."Transaction Name";
                    //PRLVarianceTransCodeBuff."Emp. Code":=PRLPeriodTransactionsCurr."Employee Code";
                    PRLVarianceTransCodeBuff."Emp. Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                    PRLVarianceTransCodeBuff."Current Amount" := PRLPeriodTransactionsCurr.Amount;
                    //PRLVarianceTransCodeBuff."Previous Amount":=0;
                    PRLVarianceTransCodeBuff.MODIFY;
                END;
            END;
            UNTIL PRLPeriodTransactionsCurr.NEXT = 0;
        END;

        // Insert fior Previous
        PRLPeriodTransactionsPrev.RESET;
        PRLPeriodTransactionsPrev.SETRANGE(PRLPeriodTransactionsPrev."Period Month", PrevMonth);
        PRLPeriodTransactionsPrev.SETRANGE(PRLPeriodTransactionsPrev."Period Year", PrevYear);
        PRLPeriodTransactionsPrev.SETFILTER(PRLPeriodTransactionsPrev."Group Order", '<>%1', 6);
        PRLPeriodTransactionsPrev.SETFILTER(PRLPeriodTransactionsPrev."Transaction Code", '<>%1', 'TOT-DED');
        IF PRLPeriodTransactionsPrev.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                HRMEmployeeD.RESET;
                HRMEmployeeD.SETRANGE(HRMEmployeeD."No.", PRLPeriodTransactionsPrev."Employee Code");
                IF HRMEmployeeD.FIND('-') THEN BEGIN
                END;
                PRLVarianceTransCodeBuff.RESET;
                PRLVarianceTransCodeBuff.SETRANGE(PRLVarianceTransCodeBuff."Transaction Code", PRLPeriodTransactionsPrev."Transaction Code");
                PRLVarianceTransCodeBuff.SETRANGE(PRLVarianceTransCodeBuff."Emp. Code", PRLPeriodTransactionsPrev."Employee Code");
                IF NOT PRLVarianceTransCodeBuff.FIND('-') THEN BEGIN
                    // Insert Here
                    PRLVarianceTransCodeBuff.INIT;
                    PRLVarianceTransCodeBuff."Transaction Code" := PRLPeriodTransactionsPrev."Transaction Code";
                    PRLVarianceTransCodeBuff."Transaction Name" := PRLPeriodTransactionsPrev."Transaction Name";
                    PRLVarianceTransCodeBuff."Emp. Code" := PRLPeriodTransactionsPrev."Employee Code";
                    PRLVarianceTransCodeBuff."Emp. Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                    PRLVarianceTransCodeBuff."Current Amount" := 0;
                    PRLVarianceTransCodeBuff."Previous Amount" := PRLPeriodTransactionsPrev.Amount;
                    PRLVarianceTransCodeBuff."Current Month" := CurrentMonth;
                    PRLVarianceTransCodeBuff."Previous Month" := PrevMonth;
                    PRLVarianceTransCodeBuff."Current Year" := CurrentYear;
                    PRLVarianceTransCodeBuff."Previous Year" := PrevYear;
                    PRLVarianceTransCodeBuff.INSERT;
                END ELSE BEGIN
                    PRLVarianceTransCodeBuff."Transaction Name" := PRLPeriodTransactionsPrev."Transaction Name";
                    PRLVarianceTransCodeBuff."Emp. Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                    // PRLVarianceTransCodeBuff."Current Amount":=0;
                    PRLVarianceTransCodeBuff."Previous Amount" := PRLPeriodTransactionsPrev.Amount;
                    // PRLVarianceTransCodeBuff."Current Month":=CurrentMonth;
                    // PRLVarianceTransCodeBuff."Previous Month":=PrevMonth;
                    // PRLVarianceTransCodeBuff."Current Year":=CurrentYear;
                    // PRLVarianceTransCodeBuff."Previous Year":=PrevYear;
                    PRLVarianceTransCodeBuff.MODIFY;
                END;
            END;
            UNTIL PRLPeriodTransactionsPrev.NEXT = 0;
        END;
        "PRL-Variance Trans. Code Buff".RESET;
        IF "PRL-Variance Trans. Code Buff".FIND('-') THEN BEGIN
        END;
    end;

    var
        PRLVarianceTransCodeBuff: Record "PRL-Variance Trans. Code Buff";
        PRLVarianceTransCodeBuff2: Record "PRL-Variance Trans. Code Buff";
        PeriFilter: Date;
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        PRLPayrollPeriodsCurr: Record "PRL-Payroll Periods";
        PRLPayrollPeriodsPrev: Record "PRL-Payroll Periods";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        PRLPeriodTransactionsCurr: Record "PRL-Period Transactions";
        PRLPeriodTransactionsPrev: Record "PRL-Period Transactions";
        HRMEmployeeD: Record "HRM-Employee (D)";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PrevMonth: Integer;
        PrevYear: Integer;
        CurrentAmount: Integer;
        PrevAmounts: Integer;
        "Emp|No": Integer;
        EmpName: Integer;
        compInfo: Record "Company Information";
}

