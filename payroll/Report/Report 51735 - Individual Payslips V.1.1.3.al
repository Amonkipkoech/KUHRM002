report 51198 "Individual Payslips V.1.1.3"
{
    Caption = 'Individual Payslip';
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/Individual Payslips V.1.1.3.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    Description = 'Payslip';


    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", Membership, "Reference No")
                                ORDER(Ascending);
            RequestFilterFields = "Employee Code", "Payroll Period", "Department Code", "Payroll Code";
            column(FullNames; emp1."First Name" + ' ' + emp1."Middle Name" + ' ' + emp1."Last Name")
            {
            }
            column(Pin; emp1."PIN Number")
            {
            }
            column(NSSF; emp1."NSSF No.")
            {
            }
            column(NHIF; emp1."NHIF No.")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address + ',' + CompanyInfo."Address 2" + ',' + CompanyInfo.City)
            {
            }
            column(Phones; CompanyInfo."Phone No." + ' ' + CompanyInfo."Phone No. 2")
            {
            }
            column(mails; CompanyInfo."E-Mail" + '/' + CompanyInfo."Home Page")
            {
            }
            column(PayslipMessage; PayslipMessage)
            {
            }
            column(HR_Employee_No_; emp1."No.")
            {
            }
            column(EmpNo; "PRL-Period Transactions"."Employee Code")
            {
            }
            column(TreansCode; "PRL-Period Transactions"."Transaction Code")
            {
            }
            column(PeriodMonth; "PRL-Period Transactions"."Period Month")
            {
            }
            column(Periodyear; "PRL-Period Transactions"."Period Year")
            {
            }
            column(MemberShip; "PRL-Period Transactions".Membership)
            {
            }
            column(RefNo; "PRL-Period Transactions"."Reference No")
            {
            }
            column(GText; "PRL-Period Transactions"."Group Text")
            {
            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(Amnt; "PRL-Period Transactions".Amount)
            {
            }
            column(Bal; "PRL-Period Transactions".Balance)
            {
            }
            column(GroupOrder; "PRL-Period Transactions"."Group Order")
            {
            }
            column(SubGroup; "PRL-Period Transactions"."Sub Group Order")
            {
            }
            column(PayPeriod; "PRL-Period Transactions"."Payroll Period")
            {
            }
            column(Dept; "PRL-Period Transactions"."Department Code")
            {
            }
            column(PayrollCode; "PRL-Period Transactions"."Payroll Code")
            {
            }
            column(TotStat; "PRL-Period Transactions"."Total Statutories")
            {
            }
            column(strBank; 'Paid to: ' + strBank)
            {
            }
            column(strBranch; 'Branch: ' + strBranch)
            {
            }
            column(strAccountNo; 'A/C No.: ' + strAccountNo)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(DeptAndLeaveBal; dept)
            {
            }
            column(IDnNHIF; strID + strNhifNo)
            {
            }
            column(JobGroup; 'Job Grp: ' + strJobG)
            {
            }
            column(EmpPin; strPin)
            {
            }
            column(strNssfNo; strNssfNo)
            {
            }
            column(strReg; 'Region: ' + strReg)
            {
            }
            column(AgeYears; 'Age: ' + strAge + ' Years')
            {
            }
            column(strPF; strPF)
            {
            }

            trigger OnAfterGetRecord()
            begin
                emp1.RESET;
                emp1.SETRANGE("No.", "PRL-Period Transactions"."Employee Code");
                IF emp1.FIND('-') THEN;

                strNssfNo := '. ';
                strNhifNo := '. ';
                strBank := '. ';
                strBranch := '. ';
                strAccountNo := '. ';
                strPin := '. ';
                strAge := '.';
                CLEAR(strID);
                CLEAR(strJobG);
                CLEAR(strReg);
                CLEAR(strPF);

                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN BEGIN
                    IF objEmp."Department Code" <> '' THEN BEGIN
                        Dimm.RESET;
                        Dimm.SETRANGE(Dimm."Dimension Code", 'DEPARTMENT');
                        Dimm.SETRANGE(Dimm.Code, objEmp."Department Code");
                        IF Dimm.FIND('-') THEN BEGIN
                            IF Dimm.Name <> '' THEN
                                dept := 'Dept.:   ' + Dimm.Name;
                        END;
                    END;
                    //objEmp.CALCFIELDS(objEmp."Department NameS");
                    //dept:=objEmp."Department NameS";
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    strPF := objEmp."No.";
                    strReg := objEmp.Region;
                    strJobG := objEmp."Grade Level";
                    IF objEmp."ID Number" <> '' THEN
                        strID := 'ID: ' + objEmp."ID Number";
                    IF objEmp."PAYE Number" <> '' THEN
                        strPin := objEmp."PAYE Number";
                    IF objEmp."Date Of Join" <> 0D THEN
                        dtDOE := objEmp."Date Of Join";
                    STATUS := FORMAT(objEmp.Status);
                    "Served Notice Period" := objEmp."Served Notice Period";
                    IF objEmp."Date Of Leaving" = 0D THEN
                        dtOfLeaving := DMY2DATE(31, 12, 9999)
                    ELSE
                        dtOfLeaving := objEmp."Date Of Leaving";
                    IF objEmp."NSSF No." <> '' THEN
                        strNssfNo := 'N.S.S.F: ' + objEmp."NSSF No.";
                    IF objEmp."NHIF No." <> '' THEN
                        strNhifNo := '  N.H.I.F: ' + objEmp."NHIF No.";
                    IF objEmp."PIN Number" <> '' THEN
                        strPin := 'PIN: ' + objEmp."PIN Number";
                    IF ((objEmp."Date Of Birth" <> 0D) AND (objPeriod."Date Opened" <> 0D)) THEN
                        strAge := HrDate.DetermineAge_Years(objEmp."Date Of Birth", objPeriod."Date Opened");


                    //Get the staff banks in the payslip - Dennis ***************************************************
                    strBankno := objEmp."Main Bank";
                    strBranchno := objEmp."Branch Bank";
                    bankStruct.SETRANGE(bankStruct."Bank Code", strBankno);
                    bankStruct.SETRANGE(bankStruct."Branch Code", strBranchno);
                    IF bankStruct.FIND('-') THEN BEGIN
                        strAccountNo := objEmp."Bank Account Number";
                        strBank := bankStruct."Bank Name";
                        strBranch := bankStruct."Branch Name";
                    END;
                    //*************************************************************************************************

                END;

                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "PRL-Period Transactions"."Employee Code");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                    HRMEmployeeC.CALCFIELDS("Leave Balance");
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF "PRL-Period Transactions".GETFILTER("PRL-Period Transactions"."Payroll Period") = '' THEN ERROR('You must specify the period filter');
                CLEAR(PeriodFilter);
                IF EVALUATE(PeriodFilter, ("PRL-Period Transactions".GETFILTER("PRL-Period Transactions"."Payroll Period"))) THEN;
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod."Date Opened", PeriodFilter);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod := PeriodFilter;
                objPeriod.RESET;
                IF objPeriod.GET(PeriodFilter) THEN PeriodName := objPeriod."Period Name";
                CLEAR(PayslipMessage);
                PayslipMessage := objPeriod."Payslip Message";
                strNssfNo := '.';
                strNhifNo := '.';
                strBank := '.';
                strBranch := '.';
                strAccountNo := '.';
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

    trigger OnInitReport()
    begin


        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        compn := CompanyInfo.Name;
    end;

    var
        PeriodFilter: Date;
        compn: Code[150];
        groupFilter: Code[20];
        strAge: Text[100];
        emp1: Record "HRM-Employee (D)";
        Addr: array[2, 12] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        intInfo: Integer;
        i: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        intRow: Integer;
        Index: Integer;
        objEmp: Record "HRM-Employee (D)";
        strEmpName: Text[250];
        strPin: Text[30];
        Trans: array[2, 80] of Text[250];
        TransAmt: array[2, 80] of Text[250];
        TransBal: array[2, 80] of Text[250];
        strGrpText: Text[100];
        strNssfNo: Text[30];
        strNhifNo: Text[30];
        strBank: Text[100];
        strBranch: Text[100];
        strAccountNo: Text[100];
        strMessage: Text[100];
        strID: Text[100];
        strPF: Text[100];
        strJobG: Text[100];
        strReg: Text[100];
        PeriodName: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Payroll Periods";
        dtDOE: Date;
        strEmpCode: Text[30];
        STATUS: Text[30];
        ControlInfo: Record "HRM-Control-Information";
        dtOfLeaving: Date;
        "Served Notice Period": Boolean;
        dept: Text[100];
        bankStruct: Record "PRL-Bank Structure";
        emploadva: Record "PRL-Period Transactions";
        strBankno: Text[30];
        strBranchno: Text[30];
        CompanyInfo: Record "Company Information";
        objOcx: Codeunit prPayrollProcessing;
        Dimm: Record "Dimension Value";
        HrDate: Codeunit "HR Dates";
        PayslipMessage: Text[100];
        HRMEmployeeC: Record "HRM-Employee (D)";
}

