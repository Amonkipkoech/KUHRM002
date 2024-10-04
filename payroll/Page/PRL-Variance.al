report 50001 "PR Trans  Variance Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll\Report\SSR\PRTransVarianceAnalysis.rdl';

    Caption = 'PR Transactions Variance Analysis';

    dataset
    {
        dataitem(DataItem27; "PRL-Transaction Codes")
        {
            DataItemTableView = WHERE("Transaction Code" = FILTER(<> ''));
            RequestFilterFields = "Transaction Type", "Transaction Code";
            column(TransactionCode_PRTransactionCodes; "Transaction Code")
            {
            }
            column(TransactionName_PRTransactionCodes; "Transaction Name")
            {
            }
            column(Period1_Filter; Period1_Filter)
            {
            }
            column(Period2_Filter; Period2_Filter)
            {
            }
            column(Period_1_TransAmount; Period_1_TransAmount)
            {
            }
            column(Period_2_TransAmount; Period_2_TransAmount)
            {
            }
            column(Var_TransAmount; Var_TransAmount)
            {
            }
            column(AppliedFilters; AppliedFilters)
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

            trigger OnAfterGetRecord()
            begin
                //Initialize
                Period_1_TransAmount := 0;
                Period_2_TransAmount := 0;
                Var_TransAmount := 0;

                //Period 1
                PRPeriodTrans.RESET;
                PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", "Transaction Code");
                PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", Period1_Filter);
                //PRPeriodTrans.SETFILTER(PRPeriodTrans."Posting Group",PostingGroup);
                IF PRPeriodTrans.FIND('-') THEN BEGIN
                    PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                    Period_1_TransAmount := PRPeriodTrans.Amount;
                    Period_1_TransAmount := ROUND(Period_1_TransAmount, 0.1, '=');///

                END;

                //Period 2
                PRPeriodTrans.RESET;
                PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", "Transaction Code");
                PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", Period2_Filter);
                //PRPeriodTrans.SETFILTER(PRPeriodTrans."Posting Group",PostingGroup);
                IF PRPeriodTrans.FIND('-') THEN BEGIN
                    PRPeriodTrans.CALCSUMS(PRPeriodTrans.Amount);
                    Period_2_TransAmount := PRPeriodTrans.Amount;
                    Period_2_TransAmount := ROUND(PRPeriodTrans.Amount, 0.1, '=');

                END;

                //Variance
                Var_TransAmount := Period_2_TransAmount - Period_1_TransAmount;
                Var_TransAmount := ROUND(Period_2_TransAmount - Period_1_TransAmount, 0.1, '=');

                //Skip if no results
                IF Var_TransAmount = 0 THEN CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Payroll Period 1"; Period1_Filter)
                {
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
                field("Payroll Period 2"; Period2_Filter)
                {
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
                field(PostingGroup; PostingGroup)
                {
                    Caption = 'Posting Group';
                    TableRelation = "PRL-Employee Posting Group".Code;
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
        //Test Fields
        IF Period1_Filter = 0D THEN ERROR('Please select Period 1 filter');
        IF Period2_Filter = 0D THEN ERROR('Please select Period 2 filter');
        IF Period1_Filter = Period2_Filter THEN ERROR('Period 1 Filter cannot be same as Period 2 Filter');
        IF PostingGroup = '' THEN ERROR('Please select Posting Group');
        //Company Info
        fnCompanyInfo;

        //Applied Filters
        AppliedFilters := 'Period 1 Filter: ' + FORMAT(Period1_Filter) + ', Period 2 Filter: ' + FORMAT(Period2_Filter) +
                         ',' + 'Posting Group: ' + PostingGroup + ' ' + PRTransactionCodes.GETFILTERS;

        /*HRPRAccess.RESET;
        HRPRAccess.SETRANGE("User ID",USERID);
        HRPRAccess.SETRANGE(Module,HRPRAccess.Module::"Human Resources");
        IF HRPRAccess.FIND('-') THEN
        BEGIN
            IF NOT HRPRAccess."View Employee Card" THEN
                ERROR('%1 You have not been setup to access this Report',USERID );
        END ELSE
        BEGIN
            ERROR('%1 You have not been setup to access this Report',USERID );
        END;*/

    end;

    var
        Period_1_TransAmount: Decimal;
        Period_2_TransAmount: Decimal;
        Var_TransAmount: Decimal;
        PRPeriodTrans: Record "PRL-Period Transactions";
        PRTransactionCodes: Record "PRL-Transaction Codes";
        Period1_Filter: Date;
        Period2_Filter: Date;
        AppliedFilters: Text;
        CompInfo: Record 79;
        PostingGroup: Code[20];
    //HRCodeunit: Codeunit "50000";
    // HRPRAccess: Record "39004041";

    //[Scope('Internal')]
    procedure fnCompanyInfo()
    begin
        CompInfo.RESET;
        IF CompInfo.GET THEN
            CompInfo.CALCFIELDS(CompInfo.Picture);
    end;
}

