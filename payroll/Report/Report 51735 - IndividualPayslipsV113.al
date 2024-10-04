report 51735 "IndividualPayslipsV113"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/IndividualPayslipsV113.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", Membership, "Reference No") ORDER(Ascending);
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
                emp1.Reset;
                emp1.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                if emp1.Find('-') then;

                strNssfNo := '. ';
                strNhifNo := '. ';
                strBank := '. ';
                strBranch := '. ';
                strAccountNo := '. ';
                strPin := '. ';
                strAge := '.';
                Clear(strID);
                Clear(strJobG);
                Clear(strReg);
                Clear(strPF);

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    if objEmp."Department Code" <> '' then begin
                        Dimm.Reset;
                        Dimm.SetRange(Dimm."Dimension Code", 'DEPARTMENT');
                        Dimm.SetRange(Dimm.Code, objEmp."Department Code");
                        if Dimm.Find('-') then begin
                            if Dimm.Name <> '' then
                                dept := 'Dept.:   ' + Dimm.Name;
                        end;
                    end;
                    objEmp.CalcFields(objEmp."Department Name");
                    //dept:=objEmp."Department NameS";
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    strPF := objEmp."No.";
                    strReg := objEmp.Region;
                    strJobG := objEmp."Grade Level";
                    if objEmp."ID Number" <> '' then
                        strID := 'ID: ' + objEmp."ID Number";
                    if objEmp."PAYE Number" <> '' then
                        strPin := objEmp."PAYE Number";
                    if objEmp."Date Of Join" <> 0D then
                        dtDOE := objEmp."Date Of Join";
                    STATUS := Format(objEmp.Status);
                    "Served Notice Period" := objEmp."Served Notice Period";
                    if objEmp."Date Of Leaving" = 0D then
                        dtOfLeaving := DMY2Date(31, 12, 9999)
                    else
                        dtOfLeaving := objEmp."Date Of Leaving";
                    if objEmp."NSSF No." <> '' then
                        strNssfNo := 'N.S.S.F: ' + objEmp."NSSF No.";
                    if objEmp."NHIF No." <> '' then
                        strNhifNo := '  N.H.I.F: ' + objEmp."NHIF No.";
                    if objEmp."PIN Number" <> '' then
                        strPin := 'PIN: ' + objEmp."PIN Number";
                    if ((objEmp."Date Of Birth" <> 0D) and (objPeriod."Date Opened" <> 0D)) then
                        strAge := HrDate.DetermineAge_Years(objEmp."Date Of Birth", objPeriod."Date Opened");


                    //Get the staff banks in the payslip - Dennis ***************************************************
                    strBankno := objEmp."Main Bank";
                    strBranchno := objEmp."Branch Bank";
                    bankStruct.SetRange(bankStruct."Bank Code", strBankno);
                    bankStruct.SetRange(bankStruct."Branch Code", strBranchno);
                    if bankStruct.Find('-') then begin
                        strAccountNo := objEmp."Bank Account Number";
                        strBank := bankStruct."Bank Name";
                        strBranch := bankStruct."Branch Name";
                    end;
                    //*************************************************************************************************

                end;

                HRMEmployeeC.Reset;
                HRMEmployeeC.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                if HRMEmployeeC.Find('-') then begin
                    HRMEmployeeC.CalcFields("Leave Balance");
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period") = '' then Error('You must specify the period filter');
                Clear(PeriodFilter);
                if Evaluate(PeriodFilter, ("PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period"))) then;
                objPeriod.Reset;
                objPeriod.SetRange(objPeriod."Date Opened", PeriodFilter);
                if objPeriod.Find('-') then;
                SelectedPeriod := PeriodFilter;
                objPeriod.Reset;
                if objPeriod.Get(PeriodFilter) then PeriodName := objPeriod."Period Name";
                Clear(PayslipMessage);
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


        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then;
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
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

