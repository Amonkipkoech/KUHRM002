report 72030 "PR Payroll Summary - Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PR Payroll Summary - Variance.rdl';

    dataset
    {
        dataitem("PRL-Transaction Codes"; "PRL-Transaction Codes")
        {
            column(TransactionCode_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Code")
            {
            }
            column(TransactionName_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Name")
            {
            }
            column(TransactionType_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(AppliedFilters; AppliedFilters)
            {
            }
            column(Variant_PeriodFilter; Variant_PeriodFilter)
            {
            }
            column(Variant_PeriodAmount; Variant_PeriodAmount)
            {
            }
            column(Variance_Amount; Variance_Amount)
            {
            }
            column(Cur_No_Assigned; Cur_No_Assigned)
            {
            }
            column(Var_No_Assigned; Var_No_Assigned)
            {
            }
            column(VarC_No_Assigned; VarC_No_Assigned)
            {
            }
            column(Cur_PNAME; Cur_PNAME)
            {
            }
            column(Var_PNAME; Var_PNAME)
            {
            }
            column(Num_I; Num_I)
            {
            }
            column(Num_D; Num_D)
            {
            }
            column(Variance_AmountPercentage; Variance_AmountPercentage)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Initialize {

                Amount := 0;
                Variant_PeriodAmount := 0;
                Variance_Amount := 0;
                Variance_AmountPercentage := 0;

                CurPeriod_Zero := FALSE;
                VarPeriod_Zero := FALSE;

                Cur_No_Assigned := 0;
                Var_No_Assigned := 0;
                VarC_No_Assigned := 0;

                //Selected Period
                fn_SR_PeriodTrans;
                IF PRPeriodTrans.FIND('-') THEN BEGIN
                    Cur_No_Assigned := PRPeriodTrans.COUNT;
                    PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                    Amount := PRPeriodTrans.Amount;
                END;
                //TEST
                // fn_SR_PeriodTrans2;
                // IF PRPeriodTrans.FIND('-') THEN BEGIN
                //     Cur_No_Assigned := PRPeriodTrans.COUNT;
                //     PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                //     Amount := PRPeriodTrans.Amount;
                // END;
                //VAR
                // fn_SR_Variant_PeriodTrans2;
                // IF PRPeriodTrans.FIND('-') THEN BEGIN
                //     Var_No_Assigned := PRPeriodTrans.COUNT;
                //     PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                //     Variant_PeriodAmount := PRPeriodTrans.Amount;
                // END;
                //Variant Period
                fn_SR_Variant_PeriodTrans;
                IF PRPeriodTrans.FIND('-') THEN BEGIN
                    Var_No_Assigned := PRPeriodTrans.COUNT;
                    PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                    Variant_PeriodAmount := PRPeriodTrans.Amount;
                END;

                //Variance
                Variance_Amount := Amount - Variant_PeriodAmount;
                VarC_No_Assigned := Cur_No_Assigned - Var_No_Assigned;

                //Output Bool
                IF Amount = 0 THEN CurPeriod_Zero := TRUE;
                IF Variant_PeriodAmount = 0 THEN VarPeriod_Zero := TRUE;
                IF VarPeriod_Zero AND CurPeriod_Zero THEN CurrReport.SKIP;


                //Variance Percentage
                IF Variant_PeriodAmount <> 0 THEN Variance_AmountPercentage := (Variance_Amount / Variant_PeriodAmount) * 100;

                //Counter
                IF "PRL-Transaction Codes"."Transaction Type" = "PRL-Transaction Codes"."Transaction Type"::Income THEN Num_I += 1;
                IF "PRL-Transaction Codes"."Transaction Type" = "PRL-Transaction Codes"."Transaction Type"::Deduction THEN Num_D += 1;
            end;

            trigger OnPreDataItem()
            begin
                //Skip this trans code
                SETFILTER("PRL-Transaction Codes"."Transaction Code", '<>%1', 'E31');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Period Filter';
                        TableRelation = "PRL-Payroll Periods";
                        ToolTip = 'Specifies the value of the Period Filter field.';
                    }
                    field(Variant_PeriodFilter; Variant_PeriodFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Variant Period Filter';
                        TableRelation = "PRL-Payroll Periods";
                        ToolTip = 'Specifies the value of the Variant Period Filter field.';
                    }
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
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods.Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            PeriodFilter := PRLPayrollPeriods."Date Opened";
        END ELSE
            ERROR('No Open period in the filters');

        PRLPayrollPeriodsCurr.RESET;
        PRLPayrollPeriodsCurr.SETRANGE(PRLPayrollPeriodsCurr."Date Opened", PeriodFilter);
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
            Variant_PeriodFilter := PRLPayrollPeriodsPrev."Date Opened";
        END;
    end;

    trigger OnPreReport()
    begin
        //HRCodeunit.fn_HRPRAccessList(USERID);

        IF ((Variant_PeriodFilter = 0D) OR (PeriodFilter = 0D)) THEN ERROR('Specify Periods');
        //Dann

        //Init
        Cur_PNAME := '';
        Var_PNAME := '';

        Num_I := 0;
        Num_D := 0;

        //Default Payroll Period
        IF PeriodFilter = 0D THEN BEGIN
            PRPayrollPeriods.RESET;
            PRPayrollPeriods.SETRANGE(PRPayrollPeriods.Closed, FALSE);
            IF PRPayrollPeriods.FIND('-') THEN PeriodFilter := PRPayrollPeriods."Date Opened";
        END;

        //Variant Period Filter
        IF Variant_PeriodFilter = 0D THEN BEGIN
            Variant_PeriodFilter := CALCDATE('-1M', PeriodFilter); //Prev Period
        END;

        //Use Period Name - Curr P
        PRPayrollPeriods.RESET;
        PRPayrollPeriods.SETRANGE(PRPayrollPeriods."Date Opened", PeriodFilter);
        IF PRPayrollPeriods.FIND('-') THEN Cur_PNAME := PRPayrollPeriods."Period Name";

        //Use Period Name - Var Period
        PRPayrollPeriods.RESET;
        PRPayrollPeriods.SETRANGE(PRPayrollPeriods."Date Opened", Variant_PeriodFilter);
        IF PRPayrollPeriods.FIND('-') THEN Var_PNAME := PRPayrollPeriods."Period Name";

        //Save Filters
        IF DepartmentCode <> '' THEN txt_DirectorateFilter := 'Directorate Code: ' + DepartmentCode;

        AppliedFilters := 'APPLIED FILTER(s) =' + 'Payroll Period: ' + FORMAT(Cur_PNAME)
                        + txt_DirectorateFilter
                        + "PRL-Transaction Codes".GETFILTERS;

        //Company Info
        fnCompanyInfo;
    end;

    var
        PRPeriodTrans: Record "PRL-Period Transactions";
        PeriodFilter: Date;
        Amount: Decimal;
        CompInfo: Record "Company Information";
        PeriodName: Text[30];
        DepartmentCode: Code[10];
        PRPayrollPeriods: Record "PRL-Payroll Periods";
        AppliedFilters: Text;
        Variant_PeriodFilter: Date;
        Variant_PeriodAmount: Decimal;
        Variance_Amount: Decimal;
        Variance_AmountPercentage: Decimal;
        CurPeriod_Zero: Boolean;
        VarPeriod_Zero: Boolean;
        Cur_No_Assigned: Integer;
        Var_No_Assigned: Integer;
        VarC_No_Assigned: Integer;
        Num_I: Integer;
        Num_D: Integer;
        Cur_PNAME: Text;
        Var_PNAME: Text;
        txt_DirectorateFilter: Text;
        txt_VarPeriodFilter: Text;
        // HRCodeunit: Codeunit "HR CheckList";
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

    procedure fnCompanyInfo()
    begin
        CompInfo.RESET;
        IF CompInfo.GET THEN
            CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    local procedure fn_SR_PeriodTrans()
    begin
        PRPeriodTrans.RESET;
        PRPeriodTrans.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month"
                                    , "Period Year", Membership, "Reference No");
        PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
        PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", PeriodFilter);
        IF DepartmentCode <> '' THEN BEGIN
            // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
        END;
    end;

    // local procedure fn_SR_PeriodTrans2()
    // begin
    //     PRPeriodTrans.RESET;
    //     PRPeriodTrans.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month"
    //                                 , "Period Year", Membership, "Reference No");
    //     PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", 'NPAY');
    //     PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", PeriodFilter);
    //     IF DepartmentCode <> '' THEN BEGIN
    //         // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
    //     END;
    // end;

    local procedure fn_SR_Variant_PeriodTrans()
    begin
        PRPeriodTrans.RESET;
        PRPeriodTrans.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month"
                                    , "Period Year", Membership, "Reference No");
        PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
        PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
        IF DepartmentCode <> '' THEN BEGIN
            // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
        END;
    end;

    // local procedure fn_SR_Variant_PeriodTrans2()
    // begin
    //     PRPeriodTrans.RESET;
    //      PRPeriodTrans.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month"
    //                                  , "Period Year", Membership, "Reference No");
    //     PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", 'NPAY');
    //     PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
    //     IF DepartmentCode <> '' THEN BEGIN
    //         // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
    //     END;
    // end;
}

