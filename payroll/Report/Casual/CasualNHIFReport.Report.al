report 70267 "Casual - NHIF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/Casual/CasualNHIFReport.rdl';

    dataset
    {
        dataitem("PRL-Casual Period Transactions"; "PRL-Casual Period Transactions")
        {
            DataItemTableView = WHERE("Transaction Code" = FILTER('NHIF'));
            PrintOnlyIfDetail = true;
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
            dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
            {
                DataItemLink = "No." = FIELD("Employee Code");
                DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
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

                trigger OnAfterGetRecord()
                var
                    "HRM-Employee (D)": Record "HRM-Employee (D)";
                begin
                    PRLEmployerDeductions.RESET;
                    PRLEmployerDeductions.SETRANGE(PRLEmployerDeductions."Employee Code", "No.");
                    PRLEmployerDeductions.SETRANGE(PRLEmployerDeductions."Transaction Code", 'NHIF');
                    PRLEmployerDeductions.SETRANGE(PRLEmployerDeductions."Payroll Period", datefilter);
                    PRLEmployerDeductions.SETRANGE("Current Instalment", NoofInstalments);
                    IF PRLEmployerDeductions.FIND('-') THEN BEGIN
                    END;

                    PRLPeriodTransactions.RESET;
                    PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code", "No.");
                    PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code", 'NHIF');
                    PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period", datefilter);
                    PRLEmployerDeductions.SETRANGE("Current Instalment", NoofInstalments);
                    IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                    END ELSE
                        CurrReport.SKIP;

                    Gtoto := PRLPeriodTransactions.Amount;//+PRLEmployerDeductions.Amount;
                end;
            }


            trigger OnPreDataItem()

            var
                "PRL-Casual Period Transactions": Record "PRL-Casual Period Transactions";
            begin
                IF datefilter = 0D THEN ERROR('Specify the Period Date');
                CLEAR(Gtoto);
                "PRL-Casual Period Transactions".SETFILTER("PRL-Casual Period Transactions"."Payroll Period", '=%1', datefilter);

                "PRL-Casual Period Transactions".SETFILTER("PRL-Casual Period Transactions"."Current Instalment", '=%1', NoofInstalments);
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
                field(NoofInstalments; NoofInstalments)
                {
                    Caption = 'NoOfInstalments';
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
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            datefilter := objPeriod."Date Openned";
            NoofInstalments := objPeriod."Current Instalment";
            PeriodName := objPeriod."Period Name";
        END;
        IF CompanyInformation.GET() THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    end;

    var
        datefilter: Date;
        PRLPayrollPeriods: Record "PRL-Casual Payroll Periods";
        CompanyInformation: Record 79;
        PRLPeriodTransactions: Record "PRL-Casual Period Transactions";
        PRLEmployerDeductions: Record "PRL-Casual Employer Deductions";
        Gtoto: Decimal;
        PRLTransactionCodes: Record "PRL-Transaction Codes";
        PeriodName: Code[20];
        objPeriod: Record "PRL-Casual Payroll Periods";
        NoofInstalments: Integer;
}

