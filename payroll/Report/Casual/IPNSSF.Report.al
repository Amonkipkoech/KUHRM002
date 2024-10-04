report 70274 "IP-NSSF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IPNSSF.rdlc';

    dataset
    {
        dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER(2 | 2));
            RequestFilterFields = "No.";
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(CompanyInfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodName_Control1102756011; PeriodName)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Volume_Amount_; "Volume Amount")
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "HRM-Employee (D)"."No.")
            {
            }
            column(NssfAmount_2; NssfAmount / 2)
            {
            }
            column(NssfNo; NssfNo)
            {
            }
            column(NssfAmount_2_Control1102756008; NssfAmount / 2)
            {
            }
            column(TotNssfAmount_2; TotNssfAmount / 2)
            {
            }
            column(totTotalAmount; totTotalAmount)
            {
            }
            column(TotVolume_Amount_; "TotVolume Amount")
            {
            }
            column(TotNssfAmount_2_Control1102756015; TotNssfAmount / 2)
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
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
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_NAME_Caption; EMPLOYER_NAME_CaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(Vol_AmountCaption; Vol_AmountCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Total_Amounts_Caption; Total_Amounts_CaptionLbl)
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

            trigger OnAfterGetRecord()
            begin

                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "HRM-Employee (D)"."No.");
                IF objEmp.FIND('-') THEN;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                NssfNo := objEmp."NSSF No.";
                IDNumber := objEmp."ID Number";

                //Volume Amount****************************************************************************
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "HRM-Employee (D)"."No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETFILTER(PeriodTrans."Transaction Code", FORMAT('NSSF'));  ///Nssf Code
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                "Volume Amount" := 0;
                IF PeriodTrans.FIND('-') THEN BEGIN
                    "Volume Amount" := PeriodTrans.Amount;
                END;

                "TotVolume Amount" := "TotVolume Amount" + "Volume Amount";


                //Standard Amount**************************************************************************
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "HRM-Employee (D)"."No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETFILTER(PeriodTrans."Group Order", '=7');
                PeriodTrans.SETFILTER(PeriodTrans."Sub Group Order", '=1');
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NssfAmount := 0;
                IF PeriodTrans.FIND('-') THEN BEGIN
                    NssfAmount := PeriodTrans.Amount + PeriodTrans.Amount;
                END;

                //Total Amount=NssfAmount+Volume Amount**************************************************
                TotalAmount := NssfAmount + "Volume Amount";


                //Summation Total Amount=****************************************************************
                totTotalAmount := totTotalAmount + TotalAmount;

                IF NssfAmount <= 0 THEN
                    CurrReport.SKIP;
                TotNssfAmount := TotNssfAmount + NssfAmount;
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
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened" WHERE("Payroll Code" = FILTER('CASUAL' | 'CASUALS'));
                    ApplicationArea = All;
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
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        //objPeriod.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodFilter := objPeriod."Date Openned";
            PeriodName := objPeriod."Period Name" + ' (' + FORMAT(objPeriod."Current Instalment") + FORMAT(objPeriod."Period Instalment Prefix") + 'Payment';
        END;
    end;

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');

        SelectedPeriod := PeriodFilter;


        IF Companyinfo.GET() THEN
            Companyinfo.CALCFIELDS(Companyinfo.Picture);
    end;

    var
        NssfAmount: Decimal;
        TotNssfAmount: Decimal;
        NssfNo: Text[30];
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: Label 'NATIONAL SOCIAL SECURITY FUND';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755031Lbl: Label 'PERIOD:';
        EMPLOYER_NO_CaptionLbl: Label 'EMPLOYER NO:';
        EMPLOYER_NAME_CaptionLbl: Label 'EMPLOYER NAME:';
        Payroll_No_CaptionLbl: Label 'Payroll No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        NSSF_No_CaptionLbl: Label 'NSSF No:';
        ID_Number_CaptionLbl: Label 'ID Number:';
        Vol_AmountCaptionLbl: Label 'Vol Amount';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Total_Amounts_CaptionLbl: Label 'Total Amounts:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        PeriodTrans: Record 70252;
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        EmployeeName: Text[150];
        NhifNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record 70250;
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        objEmp: Record "HRM-Employee (D)";
        CompInfoSetup: Record 61119;
        EmployerNHIFNo: Code[20];
        CompPINNo: Code[20];
        Address: Text[90];
        Tel: Text[30];
        Dob: Date;
        Companyinfo: Record 61119;
        "Volume Amount": Decimal;
        "TotVolume Amount": Decimal;
        TotalAmount: Decimal;
        totTotalAmount: Decimal;
}

