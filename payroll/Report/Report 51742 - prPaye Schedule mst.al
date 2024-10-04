report 51742 "prPaye Schedule mst"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/prPaye Schedule mst.rdl';

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
            /* column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            } */
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(companyinfo; companyinfo.Name)
            {

            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "PRL-Salary Card"."Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PinNumber; PinNumber)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Taxable_Pay_Caption; Taxable_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                PinNumber := objEmp."PIN Number";

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '%1|%2', 6, 7); //Taxable Pay
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '%1|%2', 3, 6); //Paye Amount

                TaxablePay := 0;
                PayeAmount := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'TXBP') then begin
                            TaxablePay := PeriodTrans.Amount;
                        end;

                        //GrpOrder 7, SubGrpOrder 3 = Taxable Pay
                        if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 3) then begin
                            PayeAmount := PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0;

                if PayeAmount <= 0 then
                    CurrReport.Skip;
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
            end;

            trigger OnPreDataItem()
            begin
                "PRL-Salary Card".SetFilter("PRL-Salary Card"."Payroll Period", '=%1', SelectedPeriod);
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
                    ApplicationArea = all;
                    Caption = 'Period Filter';
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
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        objPeriod.SetFilter("Payroll Code", '<>%1', 'CASUAL');
        objPeriod.SetFilter("Payroll Code", '<>%1', 'CASUALS');
        if objPeriod.Find('-') then begin
            PeriodFilter := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
        end;
    end;

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        if PeriodFilter = 0D then Error('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        //objPeriod.RESET;
        //IF objPeriod.GET(SelectedPeriod) THEN PeriodName:=objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[150];
        PinNumber: Text[30];
        objPeriod: Record "PRL-Payroll Periods";
        objEmp: Record "HRM-Employee (D)";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        companyinfo: Record "Company Information";
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        P_A_Y_E_ScheduleCaptionLbl: Label 'P.A.Y.E Schedule';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        No_CaptionLbl: Label 'No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        PIN_Number_CaptionLbl: Label 'PIN Number:';
        Paye_Amount_CaptionLbl: Label 'Paye Amount:';
        Taxable_Pay_CaptionLbl: Label 'Taxable Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Totals_CaptionLbl: Label 'Totals:';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

