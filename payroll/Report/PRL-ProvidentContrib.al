report 85539 "Provident Contribution"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    RDLCLayout = './payroll/Report/SSR/providentConribution.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            RequestFilterFields = "Payroll Period","Transaction Code";

            column(CurrUser; CurrUser)
            {

            }
            column(Transcode; "PRL-Period Transactions"."Transaction Code")
            {

            }
            column(EmpCode; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(Perdate; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(amt; "PRL-Period Transactions".Amount)
            {
            }
            column(EmpName; HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(PeriodName; prPayrollPeriods."Period Name")
            {
            }
            column(compName; info.Name)
            {
            }
            column(compAddress; info.Address)
            {
            }
            column(compPhone; info."Phone No.")
            {
            }
        }
    }

    requestpage
    {
        layout
        {

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
        Users.Reset;
        Users.SetRange(Users."User Name", UserId);
        if Users.Find('-') then begin
            if Users."Full Name" = '' then CurrUser := Users."User Name" else CurrUser := Users."Full Name";
        end;
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(Closed, false);
        if prPayrollPeriods.Find('-') then;
        periods := prPayrollPeriods."Date Opened";
    end;

    var
        prPayrollPeriods: Record "PRL-Payroll Periods";
        periods: Date;
        counts: Integer;
        prPeriodTransactions: Record "PRL-Period Transactions";
        TransName: array[1, 200] of Text[200];
        Transcode: array[1, 200] of Code[100];
        TransCount: Integer;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;
        NetPay: Decimal;
        NetPayTotal: Decimal;
        showdet: Boolean;
        payeamount: Decimal;
        payeamountTotal: Decimal;
        nssfam: Decimal;
        nssfamTotal: Decimal;
        nhifamt: Decimal;
        nhifamtTotal: Decimal;
        BasicPay: Decimal;
        BasicPayTotal: Decimal;
        GrossPay: Decimal;
        GrosspayTotal: Decimal;
        prtransCodes: Record "PRL-Transaction Codes";
        info: Record "Company Information";
        Users: Record User;
        CurrUser: Code[100];
        Gpay: Decimal;
        Gpaytotal: Decimal;
        DimensionValue: Record "Dimension Value";
        HRMEmployeeD: Record "HRM-Employee (D)";
}