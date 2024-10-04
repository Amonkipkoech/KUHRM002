report 60090 "PRL-Detailed Payroll Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Payroll/Report/ssr/PRL-Detailed Payroll Variance.rdlc';
    dataset
    {
        dataitem(DataItem1; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Transaction Code" = FILTER('BPAY' | 'GPAY' | 'TOT-DED' | 'NPAY'));
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PeriodName; PeriodName)
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
                seq := seq + 1;
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "PRL-Period Transactions"."Employee Code");
                IF objEmp.FIND('-') THEN
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                CLEAR(statAmount);
                IF "PRL-Period Transactions"."Transaction Code" = 'TOT-DED' THEN BEGIN
                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "PRL-Period Transactions"."Employee Code");
                    PeriodTrans.SETRANGE(PeriodTrans."Group Text", 'STATUTORIES');
                    PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                    IF PeriodTrans.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            statAmount := statAmount + PeriodTrans.Amount;
                        END;
                        UNTIL PeriodTrans.NEXT = 0;
                    END;
                    "PRL-Period Transactions".Amount := statAmount + "PRL-Period Transactions".Amount;
                END;
                IF "PRL-Period Transactions"."Transaction Code" = 'BPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'BASIC';
                IF "PRL-Period Transactions"."Transaction Code" = 'GPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'GROSS';
                IF "PRL-Period Transactions"."Transaction Code" = 'TOT-DED' THEN "PRL-Period Transactions"."Transaction Name" := 'DEDUCTIONS';
                IF "PRL-Period Transactions"."Transaction Code" = 'NPAY' THEN "PRL-Period Transactions"."Transaction Name" := 'NET';
            end;

            trigger OnPreDataItem()
            begin
                "PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period", '=%1', SelectedPeriod);
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
                field(Periods; Periods)
                {
                    ApplicationArea = all;
                    Visible = true;
                    Caption = 'Payroll Period';
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

        IF companyinfo.GET() THEN
            companyinfo.CALCFIELDS(companyinfo.Picture);
        objPeriod.RESET;
        objPeriod.SETRANGE(Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            Periods := objPeriod."Date Opened"
        END;
    end;

    trigger OnPreReport()
    begin

        SelectedPeriod := Periods;
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN PeriodName := objPeriod."Period Name";

        IF SelectedPeriod = 0D THEN ERROR('Specify The Periods!');
    end;

    var
        "PRL-Period Transactions": record "PRL-Period Transactions";
        PeriodTrans: Record "PRL-Period Transactions";
        EmployeeName: Text[100];
        objEmp: Record "HRM-Employee (D)";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
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
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        Totals_CaptionLbl: Label 'Totals:';
        Periods: Date;
        statAmount: Decimal;
        seq: Integer;
}

