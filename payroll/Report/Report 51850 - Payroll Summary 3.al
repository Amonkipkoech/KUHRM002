report 51850 "Payroll Summary 3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/Payroll Summary 3.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Group Order") ORDER(Ascending) WHERE("Group Order" = FILTER(1 | 3 | 4 | 7 | 8 | 9));

            column(DeptCodes; DeptCodes)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(UserId; CurrUser)
            {
            }
            column(DateToday; Today)
            {
            }
            column(PrintTime; Time)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(EmpCode; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(GO; "PRL-Period Transactions"."Group Order")
            {
            }
            column(Perdate; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(amt; "PRL-Period Transactions".Amount)
            {
            }
            column(bal; "PRL-Period Transactions".Balance)
            {
            }
            column(EmpName; HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(campus; HRMEmployeeD.campus)
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
            column(periods; format(periods))
            {

            }
            column(DetDate; DetDate)
            {

            }

            trigger OnAfterGetRecord()
            begin
                HRMEmployeeD.Reset;
                HRMEmployeeD.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                if HRMEmployeeD.Find('-') then begin
                    DimensionValue.Reset;
                    DimensionValue.SetRange(DimensionValue."Dimension Code", 'DEPARTMENT');
                    DimensionValue.SetRange(DimensionValue.Code, HRMEmployeeD."Department Code");
                    if DimensionValue.Find('-') then begin
                        //DeptCodes := DimensionValue.Code;
                    end;
                end;
            end;



            trigger OnPreDataItem()
            begin
                "PRL-Period Transactions".SetRange("PRL-Period Transactions"."Payroll Period", periods);
                prPayrollPeriods.Reset;
                prPayrollPeriods.SetRange("Date Opened", periods);
                if prPayrollPeriods.Find('-') then;

                if info.Get then info.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Period; periods)
                {
                    ApplicationArea = all;
                    Caption = 'Period:';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
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

    trigger OnPreReport()
    begin

        SelectedPeriod := periods;
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
            CLEAR(DetDate);
            DetDate := FORMAT(objPeriod."Period Name");
        END;
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
        DeptCodes: Code[20];
        DeptName: text[100];
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        DetDate: Text[100];


}

