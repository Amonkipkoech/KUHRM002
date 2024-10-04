report 70269 "Casual-NSSF Report (B)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/Casual/CasualNSSFReportB.rdl';

    dataset
    {
        dataitem(DataItem1000000009; "HRM-Employee (D)")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
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
            column(CompPin; CompanyInformation."Company P.I.N")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(PerName; PRLPayrollPeriods."Period Name" + ' (' + FORMAT(NoOfInstalments) + ')')
            {
            }
            column(pfNo; "No.")
            {
            }
            column(EmpPin; "PIN Number")
            {
            }
            column(EmpId; "ID Number")
            {
            }
            column(FName; "Last Name")
            {
            }
            column(MName; "Middle Name")
            {
            }
            column(LName; "First Name")
            {
            }
            column(EmployeeAmount; PRLPeriodTransactions.Amount)
            {
            }
            column(EmployerAmount; PRLEmployerDeductions.Amount)
            {
            }
            column(NHIFNo; "NHIF No.")
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
            column(region; Region)
            {
            }
            column(seq; seq)
            {
            }
            column(NssFNo; "NSSF No.")
            {
            }
            column(CurrGross; CurrGross)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SaccoSh);
                CLEAR(SaccoLoanRep);
                CLEAR(LoanInt);
                CLEAR(XmasSav);
                CLEAR(PapoUpesi);
                CLEAR(CurrGross);
                CLEAR(NSSFAmount);
                /*//Shares
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'NSSF');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Group Text",'STATUTORIES');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                NSSFAmount:=PRLPeriodTransactions.Amount;
                  END;
                  */
                //Gross
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code", "No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code", 'GPAY');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period", datefilter);
                PRLPeriodTransactions.SETRANGE("Current Instalment", NoOfInstalments);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                    CurrGross := PRLPeriodTransactions.Amount;
                END;
                /*
                //Loan Interest
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'INT001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                LoanInt:=PRLPeriodTransactions.Amount;
                  END;
                
                //Xmas Savings
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'XMA001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                XmasSav:=PRLPeriodTransactions.Amount;
                  END;
                
                //Papo & Upesi
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'PAP001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                PapoUpesi:=PRLPeriodTransactions.Amount;
                  END;
                
                */

                Gtoto := CurrGross;//+PRLEmployerDeductions.Amount;
                IF Gtoto = 0 THEN CurrReport.SKIP ELSE seq := seq + 1;

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
                    Caption = 'Date Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened" WHERE("Payroll Code" = FILTER('CASUAL' | 'CASUALS'));
                    ApplicationArea = All;
                }
                field(NoOfInstalments; NoOfInstalments)
                {
                    Caption = 'Instalments';
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

    trigger OnInitReport()
    begin
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods.Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            datefilter := PRLPayrollPeriods."Date Openned";
            NoOfInstalments := PRLPayrollPeriods."Current Instalment";
        END;

        IF CompanyInformation.GET() THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CLEAR(Gtoto);
        CLEAR("Tot-SaccoSh");
        CLEAR("Tot-SaccoLoanRep");
        CLEAR("Tot-LoanInt");
        CLEAR("Tot-XmasSav");
        CLEAR("Tot-PapoUpesi");
        CLEAR(seq);
    end;

    trigger OnPreReport()
    begin
        IF datefilter = 0D THEN ERROR('Specify the Period Date');
        //"PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period",'=%1',datefilter)
    end;

    var
        datefilter: Date;
        PRLPayrollPeriods: Record 70250;
        CompanyInformation: Record 79;
        PRLPeriodTransactions: Record 70252;
        PRLEmployerDeductions: Record 70253;
        Gtoto: Decimal;
        PRLTransactionCodes: Record 61082;
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
        HelbAm: Decimal;
        seq: Integer;
        NSSFAmount: Decimal;
        CurrGross: Decimal;
        NoOfInstalments: Integer;
}

