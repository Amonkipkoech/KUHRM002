report 51098 prGrossNetPay
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/prGrossNetPay2.rdl';

    dataset
    {
        dataitem("PRL-Employee P9 Info"; "PRL-Employee P9 Info")
        {
            //RequestFilterFields = "Period Month", "Period Year";
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(Employee_Code; "Employee Code")
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(infoPhone; companyinfo."Phone No.")
            {
            }
            column(infoAddress; companyinfo.Address)
            {
            }
            column(infoName; companyinfo.Name)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "PRL-Employee P9 Info"."Employee Code")
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(TotGrossPay; TotGrossPay)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(Gross_and_Net_pay_scheduleCaption; Gross_and_Net_pay_scheduleCaptionLbl)
            {
            }
            column(Basic_Pay_Caption; Basic_Pay_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
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
            column(TotalDed; TotalDeductions)
            {
            }


            trigger OnAfterGetRecord()
            begin
                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "PRL-Employee P9 Info"."Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";


                BasicPay := 0;
                GrossPay := 0;
                NetPay := 0;
                TotalDeductions := 0;



                P9.Reset;
                P9.SetRange(P9."Employee Code", "PRL-Employee P9 Info"."Employee Code");
                P9.SetRange(P9."Payroll Period", "PRL-Employee P9 Info"."Payroll Period");
                if P9.Find('-') then begin
                    BasicPay := P9."Basic Pay";
                    GrossPay := P9."Gross Pay";
                    NetPay := P9."Net Pay";
                end;

                TotalDeductions := GrossPay - NetPay;
                //IF NetPay<=0 THEN
                // CurrReport.SKIP;
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;
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
                    Caption = 'Period';
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

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        //IF PeriodFilter='' THEN ERROR('You must specify the period filter');

        //SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
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
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Totals_CaptionLbl: Label 'Totals:';
        TotalDeductions: Decimal;
        Periods: Date;
        P9: Record "PRL-Employee P9 Info";
}

