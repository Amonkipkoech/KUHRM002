report 70257 "Casuals Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/Casual/CasualsSummaryReport.rdl';

    dataset
    {
        dataitem(DataItem6207; 70200)
        {
            DataItemTableView = SORTING("Employee Code", "Payroll Period", "Current Instalment")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Employee Code";
            column(COMPANYNA; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(HR_Employee_No_; emp1."No.")
            {
            }
            column(empNo; objEmp."No.")
            {
            }
            column(DWorked; "Days Worked")
            {
            }
            column(PMonth; "Period Month")
            {
            }
            column(PYear; "Period Year")
            {
            }
            column(DRate; "Daily Rate")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(AcNo; objEmp."Bank Account Number")
            {
            }
            dataitem(DataItem1000000006; 70252)
            {
                DataItemLink = "Employee Code" = FIELD("Employee Code"),
                               "Payroll Period" = FIELD("Payroll Period"),
                               "Current Instalment" = FIELD("Current Instalment");
                column(TransCode; "Transaction Code")
                {
                }
                column(TransName; "Transaction Name")
                {
                }
                column(TransAmount; Amount)
                {
                }
                column(GrpOrder; "Group Order")
                {
                }
                column(SubGOrder; "Sub Group Order")
                {
                }
                column(DeptName; Dimm.Name)
                {
                }
                column(DeptCode; Dimm.Code)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin


                objPeriod.RESET;
                objPeriod.SETRANGE("Date Openned", SelectedPeriod);
                objPeriod.SETRANGE("Current Instalment", InstalmentNo);
                IF objPeriod.FIND('-') THEN BEGIN
                END;

                emp1.RESET;
                emp1.SETRANGE(emp1."No.", "Employee Code");
                IF emp1.FIND('-') THEN BEGIN
                END;
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN BEGIN
                    IF objEmp."Department Code" <> '' THEN BEGIN
                        Dimm.RESET;
                        Dimm.SETRANGE(Dimm."Dimension Code", 'COST CENTERS');
                        Dimm.SETRANGE(Dimm.Code, objEmp."Department Code");
                        IF Dimm.FIND('-') THEN BEGIN
                            dept := Dimm.Name;
                        END;
                    END;
                    //strEmpName:='['+objEmp."No."+'] '+objEmp."Last Name"+' '+objEmp."First Name"+' '+objEmp."Middle Name";
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";


                    //Get the staff banks in the payslip -
                    //***************************************************
                    strBankno := objEmp."Main Bank";
                    strBranchno := objEmp."Branch Bank";
                    bankStruct.SETRANGE(bankStruct."Bank Code", strBankno);
                    bankStruct.SETRANGE(bankStruct."Branch Code", strBranchno);
                    IF bankStruct.FIND('-') THEN BEGIN
                        //strAccountNo:=objEmp."Bank Account Number";
                        //  strBank:=bankStruct."Bank Name";
                        // strBranch:=bankStruct."Branch Name";
                    END;
                    //*************************************************************************************************

                END;



                strEmpCode := objEmp."No.";
            end;

            trigger OnPreDataItem()
            begin
                SelectedPeriod := PeriodFilter;


                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", InstalmentNo);
                IF NOT PeriodTrans.FIND('-') THEN BEGIN
                END;
                //CurrReport.SKIP;




                SETFILTER("Payroll Period", '=%1', PeriodFilter);

                SETFILTER("Current Instalment", '=%1', InstalmentNo);
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
                    TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
                    ApplicationArea = All;
                }
                field(InstalmentNo; InstalmentNo)
                {
                    Caption = 'Instalment';
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
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        //objPeriod.SETRANGE("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            InstalmentNo := objPeriod."Current Instalment";
            PeriodFilter := objPeriod."Date Openned";
            PeriodName := objPeriod."Period Name" + ' (' + (FORMAT(objPeriod."Current Instalment")) + (FORMAT(objPeriod."Period Instalment Prefix")) + ' Instalment)';
        END;

        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    trigger OnPreReport()
    begin




        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');
    end;

    var
        emp1: Record 61188;
        Addr: array[2, 10] of Text[250];
        intInfo: Integer;
        PeriodTrans: Record 70252;
        objEmp: Record "HRM-Employee (D)";
        strEmpName: Text[250];
        strGrpText: Text[100];
        PeriodName: Text[50];
        PeriodFilter: Date;
        SelectedPeriod: Date;
        objPeriod: Record 70250;
        dtDOE: Date;
        strEmpCode: Text[50];
        ControlInfo: Record 61119;
        dept: Text[100];
        bankStruct: Record 61077;
        emploadva: Record 70252;
        strBankno: Text[50];
        strBranchno: Text[50];
        CompanyInfo: Record 79;
        objOcx: Codeunit 70200;
        Dimm: Record 349;
        Employee_CaptionLbl: Label 'Employee:';
        EmptyStringCaptionLbl: Label '..................................................';
        Department_CaptionLbl: Label 'Department:';
        Period_CaptionLbl: Label 'Period:';
        P_I_N_No_CaptionLbl: Label '.............EMPLOYEE DETAIL..........';
        Employee_Caption_Control1102755158Lbl: Label 'Employee:';
        Department_Caption_Control1102755159Lbl: Label 'Department:';
        Period_Caption_Control1102755163Lbl: Label 'Period:';
        P_I_N_No_Caption_Control1102755165Lbl: Label 'P.I.N No:';
        EmptyStringCaption_Control1102755166Lbl: Label '..................................................';
        BALANCECaptionLbl: Label 'BALANCE';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        AMOUNTCaption_Control1102755320Lbl: Label 'AMOUNT';
        BALANCECaption_Control1102755321Lbl: Label 'BALANCE';
        InstalmentNo: Integer;
        AccNo: Code[20];
}

