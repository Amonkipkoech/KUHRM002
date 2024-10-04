report 50948 "PRl-External Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/externalDeduction.rdl';

    dataset
    {
        dataitem("PRL-Transaction Codes"; "PRL-Transaction Codes")
        {
            column(Transaction_Code; "Transaction Code")
            {

            }
            column(Transaction_Name; "Transaction Name")
            {

            }
            column(AccountName; AccountName)
            {

            }
            column(ReceivingBank; ReceivingBank)
            {

            }
            column(RecevingBranch; RecevingBranch)
            {

            }
            column(BankCode; BankCode)
            {

            }
            column(AccountNo; AccountNo)
            {

            }

            column(Amount; format(Amount))
            {


            }
            column(periodName; periodName)
            {

            }
            column(Pic; CompInfo.Picture)
            {

            }
            column(Name; CompInfo.Name)
            {

            }
            trigger OnAfterGetRecord()
            begin
                prltranscode.Reset();
                prltranscode.SetRange("Transaction Type", prltranscode."Transaction Type"::Deduction);
                prltranscode.SetRange("Transaction Code", "PRL-Transaction Codes"."Transaction Code");
                prltranscode.SetRange("External Deduction", true);
                if prltranscode.Find('-') then begin
                    repeat
                        prl.Reset();
                        prl.SetRange("Payroll Period", PeriodFilter);
                        prl.SetRange("Transaction Code", "PRL-Transaction Codes"."Transaction Code");
                        if prl.Find('-') then begin
                            Amount := 0;
                            repeat
                                Amount := prl.Amount + Amount
                            until prl.Next() = 0;
                        end;
                    until prltranscode.Next() = 0;


                end;

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

                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompInfo.Reset();
        if compInfo.Get() then
            compInfo.CalcFields(compInfo.Picture);
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods.Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            PeriodFilter := PRLPayrollPeriods."Date Opened";
            periodName := PRLPayrollPeriods."Period Name";
        END ELSE
            ERROR('No Open period in the filters');
    end;

    var
        Amount: Decimal;
        transcode: Code[20];
        prl: Record "PRL-Period Transactions";
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        PeriodFilter: Date;
        prltranscode: Record "PRL-Transaction Codes";
        periodName: code[20];
        CompInfo: Record 79;
}

