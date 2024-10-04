report 51146 "A third Rule Report"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './payroll/Report/SSR/A third Rule Report.rdl';
    Description = 'A third Rule Report';


    dataset
    {
        dataitem("PRL-Salary Card"; "PRL-Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(compname; companyinfo.Name)
            {

            }
            column(compadress; companyinfo.Address)
            {

            }
            column(companymail; companyinfo."E-Mail")
            {

            }

            column(Pic; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "PRL-Salary Card"."Employee Code")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(Athird; Athird)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(EmpNos; "PRL-Salary Card"."Employee Code")
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(Variance; Variance)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(TotVariance; TotVariance)
            {
            }
            column(A_third_Rule_ReportCaption; A_third_Rule_ReportCaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
            {
            }
            column(A_THIRD_Caption; A_THIRD_CaptionLbl)
            {
            }
            column(Net_Pay_Caption; Net_Pay_CaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(VarianceCaption; VarianceCaptionLbl)
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
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                BasicPay := 0;
                GrossPay := 0;
                NetPay := 0;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=1|=4|=9');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '<=1');
                PeriodTrans.SetCurrentKey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                if PeriodTrans.Find('-') then
                    repeat
                        if PeriodTrans."Group Order" = 1 then begin
                            BasicPay := PeriodTrans.Amount;
                        end;

                        if PeriodTrans."Group Order" = 4 then begin
                            GrossPay := PeriodTrans.Amount; //Gross pay
                        end;

                        if PeriodTrans."Group Order" = 9 then begin
                            NetPay := PeriodTrans.Amount; //Net pay
                        end;
                    until PeriodTrans.Next = 0;

                Athird := BasicPay * 0.33;
                Variance := NetPay - Athird;

                if NetPay <= 0 then
                    CurrReport.Skip;
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;
                TotVariance := TotVariance + Variance;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PeriodFilter := "PRL-Salary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "PRL-Salary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";
        BasicPay: Decimal;
        GrossPay: Decimal;
        NetPay: Decimal;
        TotBasicPay: Decimal;
        TotGrossPay: Decimal;
        TotNetPay: Decimal;
        EmployeeName: Text[250];
        objEmp: Record "HRM-Employee (D)";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[250];
        PeriodFilter: Text[250];
        companyinfo: Record "Company Information";
        Athird: Decimal;
        Variance: Decimal;
        TotVariance: Decimal;
        A_third_Rule_ReportCaptionLbl: Label 'A third Rule Report';
        Basic_Pay_CaptionLbl: Label 'Basic Pay:';
        A_THIRD_CaptionLbl: Label 'A THIRD:';
        Net_Pay_CaptionLbl: Label 'Net Pay:';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        VarianceCaptionLbl: Label 'Variance';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Totals_CaptionLbl: Label 'Totals:';
}

