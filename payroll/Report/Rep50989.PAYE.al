report 50947 PAYE
{
    Caption = 'PAYE';
    DefaultLayout = RDLC;
    RDLCLayout = '.\payroll\Report\SSR\PAYE.rdl';
    dataset
    {
        dataitem(Employee; "HRM-Employee (D)")
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.";
            column(SNo; SNo) { }
            column(EmployeeCode; "No.") { }
            column(EmployeeName; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name") { }
            column(Full___Part_Time; "Full / Part Time") { }
            column(Employee_Category; "Employee Category") { }
            column(KRAPIN; "PIN Number") { }
            column(PayPeriod; Format(PayPeriod, 0, '<Month Text> <Year4>')) { }
            column(OtherIncome; OtherIncome) { }
            column(Pension; Pension) { }
            column(PensionRelief; PensionRelief) { }
            column(InsuranceRelief; InsuranceRelief) { }
            column(PersonalRelief; PersonalRelief) { }
            column(NetTax; NetTax) { }
            column(GPay; GPay) { }

            trigger OnAfterGetRecord()
            var

            begin

                SNo := SNo + 1;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 4);
                if PeriodTransactions.FindFirst() then
                    GPay := PeriodTransactions.Amount;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 6);
                PeriodTransactions.SetRange("Sub Group Order", 9);
                if PeriodTransactions.FindFirst() then
                    PersonalRelief := PeriodTransactions.Amount;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 6);
                PeriodTransactions.SetRange("Sub Group Order", 1);
                if PeriodTransactions.FindFirst() then
                    PensionRelief := PeriodTransactions.Amount;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 6);
                PeriodTransactions.SetRange("Sub Group Order", 8);
                if PeriodTransactions.FindFirst() then
                    InsuranceRelief := PeriodTransactions.Amount;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 1);
                PeriodTransactions.SetRange("Sub Group Order", 1);
                if PeriodTransactions.FindFirst() then
                    BPay := PeriodTransactions.Amount;

                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetRange("Group Order", 7);
                PeriodTransactions.SetRange("Sub Group Order", 3);
                if PeriodTransactions.FindFirst() then
                    NetTax := PeriodTransactions.Amount;

                Pension := 0;
                PeriodTransactions.Reset();
                PeriodTransactions.SetRange("Payroll Period", PayPeriod);
                PeriodTransactions.SetRange("Employee Code", "No.");
                PeriodTransactions.SetFilter("Group Order", '%1|%2', 7, 8);
                PeriodTransactions.SetFilter("Sub Group Order", '%1|%2', 1, 13);
                if PeriodTransactions.FindSet() then
                    repeat
                        Pension := Pension + PeriodTransactions.Amount;
                    until PeriodTransactions.Next() = 0;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Payroll Period"; PayPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        SNo := 0;
        PayrollPeriods.Reset();
        PayrollPeriods.SetRange(Closed, true);
        if PayrollPeriods.FindLast() then
            PayPeriod := PayrollPeriods."Date Opened";

        if PayPeriod <> 0D then begin
            PeriodTransactions.SetRange("Payroll Period", PayPeriod);
        end else
            Error(PayPeriodErr);
    end;

    var
        PersonalRelief, GPay, BPay, OtherIncome, Pension, NetTax, PensionRelief, InsuranceRelief : Decimal;
        PayPeriod: Date;
        PayrollPeriods: Record "PRL-Payroll Periods";
        PayPeriodErr: Label 'Please input your payroll period';
        PeriodTransactions: Record "PRL-Period Transactions";
        SNo: Integer;
}
