report 50942 "Provident Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/providentReport.rdl';

    dataset
    {
        dataitem(PRLPeriodTransactions; "PRL-Period Transactions")
        {
            DataItemTableView = where("Transaction Code" = filter('D-20'));
            column(EmployeeCode_Periodtrans; "Employee Code")
            {
            }
            column(datefilter; datefilter)
            {

            }
            column(Amount; Hlevy)
            {

            }
            column(EmployerAmount; EmplAmount)
            {

            }
            column(basicsal; Gpay)
            {

            }
            column(totalContr; EmplAmount + Hlevy)
            {

            }
            column(idno; idno)
            {

            }
            column(empName; empName)
            {

            }
            column(DetDate; DetDate)
            {

            }
            column(name; CompanyInformation.Name)
            {

            }
            column(Seq; Seq)
            {

            }





            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
                Gpay := GetBasicPay(PRLPeriodTransactions."Employee Code");
                Hlevy := GetHlevy(PRLPeriodTransactions."Employee Code");
                Employee.Reset();
                Employee.SetRange("No.", "Employee Code");
                if Employee.Find('-') then begin
                    empName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    IDno := Employee."ID Number";

                end;


            end;



            trigger OnPreDataItem()
            begin
                PRLPeriodTransactions.SetFilter("Payroll Period", '=%1', PeriodFilter);
            end;
        }


    }





    requestpage
    {
        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then begin

        end;
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        PeriodFilter := objPeriod."Date Opened";

    end;

    trigger OnPreReport()
    begin
        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
            DetDate := FORMAT(objPeriod."Period Name");
        END;
    end;

    local procedure GetBasicPay(EmpCode: code[20]) Gpay: Decimal;
    begin
        periodtrans.SetRange("Employee Code", EmpCode);
        periodtrans.SetRange("Transaction Code", 'BPAY');
        periodtrans.SetRange("Payroll Period", PeriodFilter);
        IF periodtrans.FindSet(TRUE, TRUE) THEN BEGIN
            repeat
                Gpay := periodtrans.Amount;
                EmplAmount := 0.06 * Gpay;
            until periodtrans.Next() = 0
        END;
    end;

    local procedure GetHlevy(EmpCode: code[20]) Hlevy: Decimal;
    begin
        periodtrans.SetRange("Employee Code", EmpCode);
        periodtrans.SetRange("Transaction Code", 'D-20');
        periodtrans.SetRange("Payroll Period", PeriodFilter);
        IF periodtrans.FindSet(TRUE, TRUE) THEN BEGIN
            repeat
                Hlevy := periodtrans.Amount;
            until periodtrans.Next() = 0
        END;
    end;






    var
        Seq: Integer;
        EmplAmount: DECIMAL;
        periodtrans: Record "PRL-Period Transactions";
        Prlemployer: record "PRL-Employer Deductions";

        PayrollPeriods: Record "PRL-Payroll Periods";
        CompanyInformation: Record "Company Information";

        SelectedPeriod: Date;
        PeriodFilter: Date;
        objPeriod: Record "PRL-Payroll Periods";
        PeriodName: Text[30];
        DetDate: Text[100];
        empContr: Decimal;
        bossContr: Decimal;
        totalContr: Decimal;
        empName: text[200];

        Transcode: array[1, 200] of Code[100];
        counts: Integer;
        TransCount: Integer;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;

        empTotal: Decimal;
        employer: Decimal;
        emplyrTotal: Decimal;
        prlEmpTrans: Record "PRL-Period Transactions";
        basicsal: Decimal;
        emplContrib: Decimal;
        idno: code[20];
        salCard: Record "PRL-Salary Card";
        Employeer: Decimal;
        Name: text[100];

        Transcodes: Record "PRL-Transaction Codes";
        datefilter: date;
        PRLPayrollPeriods: Record "PRL-Payroll Periods";

        Amount: Decimal;
        Basicpay: Decimal;
        Hlevy: Decimal;
        Gpay: Decimal;
        Employee: Record "HRM-Employee (D)";


}