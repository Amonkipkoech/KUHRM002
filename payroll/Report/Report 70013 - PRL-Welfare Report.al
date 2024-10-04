report 70013 "PRL-Welfare Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-Welfare Report.rdl';

    dataset
    {
        dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
        {
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone1; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompPage; CompanyInformation."Home Page")
            {
            }
            /* column(CompPin; CompanyInformation."Company P.I.N")
            {
            } */
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(PerName; PRLPayrollPeriods."Period Name")
            {
            }
            column(pfNo; "HRM-Employee (D)"."No.")
            {
            }
            column(EmpPin; "HRM-Employee (D)"."PIN Number")
            {
            }
            column(EmpId; "HRM-Employee (D)"."ID Number")
            {
            }
            column(FName; "HRM-Employee (D)"."Last Name")
            {
            }
            column(MName; "HRM-Employee (D)"."Middle Name")
            {
            }
            column(LName; "HRM-Employee (D)"."First Name")
            {
            }
            column(EmployeeAmount; PRLPeriodTransactions.Amount)
            {
            }
            column(EmployerAmount; PRLEmployerDeductions.Amount)
            {
            }
            column(NHIFNo; "HRM-Employee (D)"."NHIF No.")
            {
            }
            column(Gtot; Gtoto)
            {
            }
            column(SaccoSh; SaccoSh)
            {
            }
            column(SaccoLoanRep; SaccoLoanRep)
            {
            }
            column(LoanInt; LoanInt)
            {
            }
            column(XmasSav; XmasSav)
            {
            }
            column(PapoUpesi; PapoUpesi)
            {
            }
            column(region; "HRM-Employee (D)".Region)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(SaccoSh);
                Clear(SaccoLoanRep);
                Clear(LoanInt);
                Clear(XmasSav);
                Clear(PapoUpesi);
                //Shares
                PRLPeriodTransactions.Reset;
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", 'D013');
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
                if PRLPeriodTransactions.Find('-') then begin
                    SaccoSh := PRLPeriodTransactions.Amount;
                end;

                //Loan Repayment
                PRLPeriodTransactions.Reset;
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", 'D002');
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
                if PRLPeriodTransactions.Find('-') then begin
                    SaccoLoanRep := PRLPeriodTransactions.Amount;
                end;

                //Loan Interest
                PRLPeriodTransactions.Reset;
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", 'D014');
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
                if PRLPeriodTransactions.Find('-') then begin
                    LoanInt := PRLPeriodTransactions.Amount;
                end;

                //Staff Welfare
                PRLPeriodTransactions.Reset;
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", 'D001');
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
                if PRLPeriodTransactions.Find('-') then begin
                    XmasSav := PRLPeriodTransactions.Amount;
                end;

                //Papo & Upesi
                PRLPeriodTransactions.Reset;
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Employee Code", "HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Transaction Code", 'D007');
                PRLPeriodTransactions.SetRange(PRLPeriodTransactions."Payroll Period", datefilter);
                if PRLPeriodTransactions.Find('-') then begin
                    PapoUpesi := PRLPeriodTransactions.Amount;
                end;



                Gtoto := SaccoSh + SaccoLoanRep + LoanInt + XmasSav + PapoUpesi;//+PRLEmployerDeductions.Amount;
                if Gtoto = 0 then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateFil; datefilter)
                {
                    ApplicationArea = all;
                    Caption = 'Date Filter';
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
        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(PRLPayrollPeriods.Closed, false);
        if PRLPayrollPeriods.Find('-') then begin
            datefilter := PRLPayrollPeriods."Date Opened";
        end;

        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        Clear(Gtoto);
        Clear("Tot-SaccoSh");
        Clear("Tot-SaccoLoanRep");
        Clear("Tot-LoanInt");
        Clear("Tot-XmasSav");
        Clear("Tot-PapoUpesi");
    end;

    trigger OnPreReport()
    begin
        if datefilter = 0D then Error('Specify the Period Date');
        //"PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period",'=%1',datefilter)
    end;

    var
        datefilter: Date;
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        CompanyInformation: Record "Company Information";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        PRLEmployerDeductions: Record "PRL-Employer Deductions";
        Gtoto: Decimal;
        PRLTransactionCodes: Record "PRL-Transaction Codes";
        SaccoSh: Decimal;
        SaccoLoanRep: Decimal;
        LoanInt: Decimal;
        XmasSav: Decimal;
        PapoUpesi: Decimal;
        "Tot-SaccoSh": Decimal;
        "Tot-SaccoLoanRep": Decimal;
        "Tot-LoanInt": Decimal;
        "Tot-XmasSav": Decimal;
        "Tot-PapoUpesi": Decimal;
}

