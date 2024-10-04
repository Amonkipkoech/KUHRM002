report 70253 "Casual-NHIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/Casual/CasualNHIF.rdl';

    dataset
    {
        dataitem(DataItem6207; "HRM-Employee (D)")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
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
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Address; Address)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(PeriodName_Control1102756007; PeriodName)
            {
            }
            column(NhifAmount; NhifAmount)
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(NhifNo; NhifNo)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "No.")
            {
            }
            column(Dob; Dob)
            {
            }
            column(TotNhifAmount; TotNhifAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
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
            column(Page_Nov_Caption; Page_No_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755032; PERIOD_Caption_Control1102755032Lbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(EMPLOYER_Caption; EMPLOYER_CaptionLbl)
            {
            }
            column(EMPOLOYER_NO_Caption; EMPOLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NO_Caption; EMPLOYER_PIN_NO_CaptionLbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Date_Of_BirthCaption; Date_Of_BirthCaptionLbl)
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
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                "HRM-Employee (D)": Record "HRM-Employee (D)";
            begin
                CLEAR(NhifAmount);
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "HRM-Employee (D)"."No.");
                IF objEmp.FIND('-') THEN;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                NhifNo := objEmp."NHIF No.";
                IDNumber := objEmp."ID Number";
                Dob := objEmp."Date Of Birth";

                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "HRM-Employee (D)"."No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETRANGE(PeriodTrans."Group Order", 7);
                PeriodTrans.SETRANGE(PeriodTrans."Sub Group Order", 2);
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NhifAmount := 0;

                IF PeriodTrans.FIND('-') THEN BEGIN
                    IF PeriodTrans.Amount = 0 THEN CurrReport.SKIP;
                    NhifAmount := PeriodTrans.Amount;
                    TotNhifAmount := TotNhifAmount + PeriodTrans.Amount;
                END;
            end;


            trigger OnPreDataItem()
            begin
                IF CompInfoSetup.GET() THEN
                    EmployerNHIFNo := CompInfoSetup."N.H.I.F No";
                CompPINNo := CompInfoSetup."Company P.I.N";
                Address := CompInfoSetup.Address;
                Tel := CompInfoSetup."Phone No.";
                CLEAR(TotNhifAmount);

                //"PRL-Salary Card".SETFILTER("PRL-Salary Card"."Payroll Period",'%1',SelectedPeriod);
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
        CLEAR(NhifAmount);
        //CLEAR(TotNhifAmount);
    end;

    var
        PeriodTrans: Record "PRL-Casual Period Transactions";
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        EmployeeName: Text[150];
        NhifNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record "PRL-Casual Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        objEmp: Record "HRM-Employee (D)";
        CompInfoSetup: Record "HRM-Control-Information";
        EmployerNHIFNo: Code[20];
        CompPINNo: Code[20];
        Address: Text[90];
        Tel: Text[30];
        Dob: Date;
        Companyinfo: Record "HRM-Control-Information";
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755032Lbl: Label 'PERIOD:';
        ADDRESS_CaptionLbl: Label 'ADDRESS:';
        EMPLOYER_CaptionLbl: Label 'EMPLOYER:';
        EMPOLOYER_NO_CaptionLbl: Label 'EMPOLOYER NO:';
        EMPLOYER_PIN_NO_CaptionLbl: Label 'EMPLOYER PIN NO:';
        TEL_NO_CaptionLbl: Label 'TEL NO:';
        AmountCaptionLbl: Label 'Amount';
        ID_Number_CaptionLbl: Label 'ID Number:';
        NHIF_No_CaptionLbl: Label 'NHIF No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        No_CaptionLbl: Label 'No:';
        Date_Of_BirthCaptionLbl: Label 'Date Of Birth';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Total_NHIF_CaptionLbl: Label 'Total NHIF:';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
}

