report 51848 "Detailed Payrol Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/Detailed Payrol Summary.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Group Order" = FILTER(1 | 3 | 4 | 7 | 8 | 9),
                                      "Transaction Code" = FILTER('<>TXEP&<>TOT-DED'));
            column(GO; "PRL-Period Transactions"."Group Order")
            {
            }
            column(SGO; "PRL-Period Transactions"."Sub Group Order")
            {
            }
            column(DeptCodes; "Dimension Value".Code)
            {
            }
            column(DeptName; "Dimension Value".Name)
            {
            }
            column(DeptCodez; HRMEmployeeD."Department Code")
            {
            }
            column(DeptNames; HRMEmployeeD."Total Hours Worked")
            {
            }
            column(UserId; CurrUser)
            {
            }
            column(DateToday; TODAY)
            {
            }
            column(PrintTime; TIME)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(PrintBy; 'PRINTED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(CheckedBy; 'CHECKED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(VerifiedBy; 'VERIFIED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(ApprovedBy; 'APPROVED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(BasicPayLbl; 'BASIC PAY')
            {
            }
            column(payelbl; 'PAYE.')
            {
            }
            column(nssflbl; 'NSSF')
            {
            }
            column(nhiflbl; 'NHIF')
            {
            }
            column(Netpaylbl; 'Net Pay')
            {
            }
            column(payeamount; payeamount)
            {
            }
            column(nssfam; nssfam)
            {
            }
            column(nhifamt; nhifamt)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(periods; 'PAYROLL SUMMARY for ' + FORMAT(periods, 0, 4))
            {
            }
            column(empNo; HRMEmployeeD."No.")
            {
            }
            column(empName; HRMEmployeeD."No." + ': ' + HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name")
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(TransAmount; "PRL-Period Transactions".Amount)
            {
            }
            column(TransBalance; "PRL-Period Transactions".Balance)
            {
            }
            column(OrigAmount; "PRL-Period Transactions"."Original Amount")
            {
            }
            column(GroupText; "PRL-Period Transactions"."Group Text")
            {
            }
            column(GroupOrder; "PRL-Period Transactions"."Group Order")
            {
            }
            column(SubGroupOrder; "PRL-Period Transactions"."Sub Group Order")
            {
            }
            column(seq; PaySummAry.Serial)
            {
            }
            column(compName; info.Name)
            {
            }
            column(compConstituent; info."Name 2")
            {
            }
            column(compTown; info.City)
            {
            }
            column(compMail; info."E-Mail")
            {
            }
            column(address; info.Address)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF (("PRL-Period Transactions"."Group Order" = 8) AND ("PRL-Period Transactions"."Sub Group Order" = 9)) THEN CurrReport.SKIP;

                PaySummAry.RESET;
                PaySummAry.SETRANGE("User Name", USERID);
                PaySummAry.SETRANGE("Staff No.", "PRL-Period Transactions"."Employee Code");
                PaySummAry.SETRANGE(Period, "PRL-Period Transactions"."Payroll Period");
                IF PaySummAry.FIND('-') THEN;

                HRMEmployeeD.RESET;
                HRMEmployeeD.SETRANGE("No.", "PRL-Period Transactions"."Employee Code");
                IF HRMEmployeeD.FIND('-') THEN BEGIN
                    "Dimension Value".RESET;
                    "Dimension Value".SETFILTER("Dimension Value"."Dimension Code", '%1|%2', 'DEPARTMENTS', 'DEPARTMENT');
                    "Dimension Value".SETFILTER("Dimension Value".Code, HRMEmployeeD."Department Code");
                    IF "Dimension Value".FIND('-') THEN BEGIN
                    END;
                END;
                //IF "PRL-Period Transactions"."Transaction Code" IN ['NPAY','PAYE','NSSF','NHIF','BPAY','GPAY'] THEN CurrReport.SKIP;
                IF "PRL-Period Transactions"."Transaction Code" IN ['E-105'] THEN "PRL-Period Transactions"."Group Text" := 'HOUSE ALLOWANCE';
                IF "PRL-Period Transactions"."Transaction Code" IN ['E-130'] THEN "PRL-Period Transactions"."Group Text" := 'RESPONSIBILITY ALLOWANCE';
                IF "PRL-Period Transactions"."Transaction Code" IN ['E-192'] THEN "PRL-Period Transactions"."Group Text" := 'Car Allowance';
                IF "PRL-Period Transactions"."Transaction Code" IN ['E-193'] THEN "PRL-Period Transactions"."Group Text" := 'Commuter Allowance';
                IF "PRL-Period Transactions"."Group Text" IN ['ALLOWANCE'] THEN "PRL-Period Transactions"."Group Text" := 'OTHER ALLOWANCES';
                IF "PRL-Period Transactions"."Group Text" IN ['STATUTORIES'] THEN "PRL-Period Transactions"."Group Text" := 'DEDUCTIONS';
            end;

            trigger OnPreDataItem()
            begin
                "PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period", '=%1', periods);
                CLEAR(seq);
                prPeriodTransactions.RESET;
                prPeriodTransactions.COPYFILTERS("PRL-Period Transactions");
                IF prPeriodTransactions.FIND('-') THEN BEGIN

                    PaySummAry.RESET;
                    PaySummAry.SETRANGE("User Name", USERID);
                    IF PaySummAry.FIND('-') THEN PaySummAry.DELETEALL;
                    REPEAT
                    BEGIN
                        PaySummAry.RESET;
                        PaySummAry.SETRANGE("User Name", USERID);
                        PaySummAry.SETRANGE("Staff No.", prPeriodTransactions."Employee Code");
                        PaySummAry.SETRANGE(Period, prPeriodTransactions."Payroll Period");
                        IF NOT (PaySummAry.FIND('-')) THEN BEGIN
                            PaySummAry.INIT;
                            PaySummAry."User Name" := USERID;
                            PaySummAry."Staff No." := prPeriodTransactions."Employee Code";
                            PaySummAry.Period := prPeriodTransactions."Payroll Period";
                            PaySummAry.INSERT;
                        END;
                    END;
                    UNTIL prPeriodTransactions.NEXT = 0;
                END;

                PaySummAry.RESET;
                PaySummAry.SETRANGE("User Name", USERID);
                // PaySummAry.SETRANGE("Staff No.",prPeriodTransactions."Employee Code");
                PaySummAry.SETRANGE(Period, prPeriodTransactions."Payroll Period");
                IF PaySummAry.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        seq := seq + 1;
                        PaySummAry.Serial := seq;
                        PaySummAry.MODIFY;
                    END;
                    UNTIL PaySummAry.NEXT = 0;
                END;
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
        Users.RESET;
        Users.SETRANGE(Users."User Name", USERID);
        IF Users.FIND('-') THEN BEGIN
            IF Users."Full Name" = '' THEN CurrUser := Users."User Name" ELSE CurrUser := Users."Full Name";
        END;

        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(info.Picture);

        prPayrollPeriods.RESET;
        prPayrollPeriods.SETRANGE(Closed, FALSE);
        IF prPayrollPeriods.FIND('-') THEN BEGIN
            periods := prPayrollPeriods."Date Opened";
        END;

        IF periods = 0D THEN ERROR('Please Specify the Period first.');
        counts := 0;
        NetPayTotal := 0;
        BasicPayTotal := 0;
        payeamountTotal := 0;
        nssfamTotal := 0;
        nhifamtTotal := 0;
        TransCount := 0;
        showdet := TRUE;
        NetPay := 0;
        BasicPay := 0;
        CLEAR(TranscAmount);
        payeamount := 0;
        nssfam := 0;
        nhifamt := 0;
        GrossPay := 0;
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
        "Dimension Value": Record "Dimension Value";
        HRMEmployeeD: Record "HRM-Employee (D)";
        seq: Integer;
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        PaySummAry: Record "PRL-Payroll Summary Numbers";
}

