report 72027 "Payroll Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/Payroll Variance Report.rdlc';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Group Order" = FILTER(<> 6));
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(CurrPerName; PeriodName1)
            {
            }
            column(PrevPerName; PeriodName2)
            {
            }
            column(PeriodFilters; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(PrevAmount; PeriodTrans1.Amount)
            {
            }
            column(pic; companyinfo.Picture)
            {
            }
            column(Gtext; "PRL-Period Transactions"."Group Text")
            {
            }
            column(EmpCode; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(TransName; UPPERCASE("PRL-Period Transactions"."Transaction Name"))
            {
            }
            column(TransAmount; "PRL-Period Transactions".Amount)
            {
            }
            column(VarianceAmount; "PRL-Period Transactions".Amount - PeriodTrans1.Amount)
            {
            }
            column(GO; "PRL-Period Transactions"."Group Order")
            {
            }
            column(SGO; "PRL-Period Transactions"."Sub Group Order")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Variance);
                seq := seq + 1;
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "PRL-Period Transactions"."Employee Code");
                objEmp.SETRANGE(objEmp.Status, objEmp.Status::Active);
                IF objEmp.FIND('-') THEN
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                CLEAR(statAmount);
                /*
                IF "PRL-Period Transactions"."Transaction Code"='TOT-DED' THEN BEGIN
                  PeriodTrans.RESET;
                  PeriodTrans.SETRANGE(PeriodTrans."Employee Code","PRL-Period Transactions"."Employee Code");
                  PeriodTrans.SETRANGE(PeriodTrans."Group Text",'STATUTORIES');
                  PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",StartPeriods);
                  IF PeriodTrans.FIND('-') THEN BEGIN
                    REPEAT
                      BEGIN
                        statAmount:=statAmount+PeriodTrans.Amount;
                      END;
                      UNTIL PeriodTrans.NEXT=0;
                    END;
                "PRL-Period Transactions".Amount:=statAmount+"PRL-Period Transactions".Amount;
                  END;*/

                PeriodTrans1.RESET;
                PeriodTrans1.SETRANGE(PeriodTrans1."Employee Code", "PRL-Period Transactions"."Employee Code");
                PeriodTrans1.SETRANGE(PeriodTrans1."Transaction Code", "PRL-Period Transactions"."Transaction Code");
                PeriodTrans1.SETRANGE(PeriodTrans1."Payroll Period", EndPeriods);
                IF PeriodTrans1.FIND('-') THEN BEGIN
                    /*
                      IF PeriodTrans1."Transaction Code"='TOT-DED' THEN BEGIN
                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE(PeriodTrans."Employee Code","PRL-Period Transactions"."Employee Code");
                    PeriodTrans.SETRANGE(PeriodTrans."Group Text",'STATUTORIES');
                    PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",EndPeriods);
                    IF PeriodTrans.FIND('-') THEN BEGIN
                      REPEAT
                        BEGIN
                          statAmount:=statAmount+PeriodTrans.Amount;
                        END;
                        UNTIL PeriodTrans.NEXT=0;
                      END;
                  PeriodTrans1.Amount:=statAmount+PeriodTrans1.Amount;

                    END;*/
                    IF PeriodTrans1."Transaction Code" = 'BPAY' THEN PeriodTrans1."Transaction Name" := 'BASIC';
                    IF PeriodTrans1."Transaction Code" = 'GPAY' THEN PeriodTrans1."Transaction Name" := 'GROSS';
                    IF PeriodTrans1."Transaction Code" = 'TOT-DED' THEN PeriodTrans1."Transaction Name" := 'DEDUCTIONS';
                    IF PeriodTrans1."Transaction Code" = 'NPAY' THEN PeriodTrans1."Transaction Name" := 'NET';

                    IF (("PRL-Period Transactions".Amount - PeriodTrans1.Amount) = 0) THEN CurrReport.SKIP;
                END;

                IF "PRL-Period Transactions"."Transaction Code" = 'BPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'BASIC';
                IF "PRL-Period Transactions"."Transaction Code" = 'GPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'GROSS';
                IF "PRL-Period Transactions"."Transaction Code" = 'TOT-DED' THEN "PRL-Period Transactions"."Transaction Name" := 'DEDUCTIONS';
                IF "PRL-Period Transactions"."Transaction Code" = 'NPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'NET';

                IF (("PRL-Period Transactions".Amount - PeriodTrans1.Amount) = 0) THEN CurrReport.SKIP;

            end;

            trigger OnPreDataItem()
            begin
                "PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period", '%1', StartPeriods);
                CLEAR(seq);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartPeriods; StartPeriods)
                {
                    Caption = 'Start Period';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Period field.';

                    trigger OnValidate()
                    begin
                        IF StartPeriods <> 0D THEN BEGIN
                            PayPeriods2.RESET;
                            PayPeriods2.SETRANGE(PayPeriods2."Period Month", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 2));
                            PayPeriods2.SETRANGE(PayPeriods2."Period Year", DATE2DMY((CALCDATE('<CM-2M+1D>', StartPeriods)), 3));
                            IF PayPeriods2.FIND('-') THEN BEGIN
                                EndPeriods := PayPeriods2."Date Opened";
                            END ELSE BEGIN
                                EndPeriods := 0D;
                            END;
                        END ELSE BEGIN
                            PayPeriods2.RESET;
                            PayPeriods2.SETRANGE(PayPeriods2.Closed, FALSE);
                            IF PayPeriods2.FIND('-') THEN BEGIN
                                EndPeriods := PayPeriods2."Date Opened";
                            END ELSE BEGIN
                                EndPeriods := 0D;
                            END;
                        END;

                        //currp
                    end;
                }
                field(EndPeriods; EndPeriods)
                {
                    ApplicationArea = all;
                    Caption = 'End Period';
                    Editable = true;
                    Enabled = true;
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                    ToolTip = 'Specifies the value of the End Period field.';
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

        IF companyinfo.GET() THEN
            companyinfo.CALCFIELDS(companyinfo.Picture);
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            StartPeriods := objPeriod."Date Opened";

            IF StartPeriods <> 0D THEN BEGIN
                PayPeriods2.RESET;
                PayPeriods2.SETRANGE(PayPeriods2."Period Month", DATE2DMY((CALCDATE('<CM-1M+1D>', StartPeriods)), 2));
                // PayPeriods2.SETRANGE("Period Year",DATE2DMY((CALCDATE ('<CM-1M+1D>', StartPeriods)),3));
                PayPeriods2.SETRANGE(PayPeriods2."Period Year", 2018);
                IF PayPeriods2.FIND('-') THEN BEGIN
                    EndPeriods := PayPeriods2."Date Opened";
                END ELSE BEGIN
                    EndPeriods := 0D;
                END;
            END ELSE BEGIN
                PayPeriods2.RESET;
                PayPeriods2.SETRANGE(PayPeriods2.Closed, FALSE);
                IF PayPeriods2.FIND('-') THEN BEGIN
                    // EndPeriods:=PayPeriods2."Date Opened";
                END ELSE BEGIN
                    EndPeriods := 0D;
                END;
            END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF StartPeriods = 0D THEN ERROR('Specify the start period!');
        objPeriod.RESET;
        IF objPeriod.GET(StartPeriods) THEN PeriodName1 := objPeriod."Period Name";

        objPeriod.RESET;
        IF objPeriod.GET(EndPeriods) THEN PeriodName2 := objPeriod."Period Name";
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";

        PeriodTrans1: Record "PRL-Period Transactions";
        EmployeeName: Text[100];
        objEmp: Record "HRM-Employee (D)";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName1: Text[30];
        PeriodName2: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        Gross_and_Net_pay_scheduleCaptionLbl: Label 'Gross and Net pay schedule';
        Basic_Pay_CaptionLbl: Label 'Basic Pay:';
        Gross_Pay_CaptionLbl: Label 'Gross Pay:';
        Net_Pay_CaptionLbl: Label 'Net Pay:';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by………………………………………………             Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………             Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………             Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by…………………………………………………              Date……………………………………………';
        Totals_CaptionLbl: Label 'Totals:';
        StartPeriods: Date;
        EndPeriods: Date;
        statAmount: Decimal;
        seq: Integer;
        PayPeriods2: Record "PRL-Payroll Periods";
        PayPeriods1: Record "PRL-Payroll Periods";
        Variance: Decimal;
}

