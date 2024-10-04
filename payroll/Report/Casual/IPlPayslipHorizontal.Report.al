report 70277 "IPl- Payslip (Horizontal)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IPlPayslipHorizontal.rdlc';

    dataset
    {
        dataitem("PRL Employee Days Worked"; 70200)
        {
            DataItemTableView = SORTING("Employee Code", "Payroll Period", "Current Instalment")
                                ORDER(Ascending);
            RequestFilterFields = "Employee Code";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102755015; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756027; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756028; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
            {
            }
            column(PayslipMessage; objPeriod."Payslip Message")
            {
            }
            column(HR_Employee_No_; emp1."No.")
            {
            }
            column(Addr_1__1_; 'PF NO.:       ' + FORMAT(Addr[1] [1]))
            {
            }
            column(Dept1; 'DEPARTMENT:  ' + Addr[1] [2])
            {
            }
            column(per1; 'PERIOD:  ' + Addr[1] [3])
            {
            }
            column(bank1; strBankName1)
            {
            }
            column(bBranch1; strBankBranchName1)
            {
            }
            column(BAccount1; strBankAccount1)
            {
            }
            column(bank2; strBankName2)
            {
            }
            column(bBranch2; strBankBranchName2)
            {
            }
            column(BAccount2; strBankAccount2)
            {
            }
            column(Dept2; 'DEPARTMENT:  ' + Addr[2] [2])
            {
            }
            column(Per2; 'PERIOD:  ' + Addr[2] [3])
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(PayDate; dates1."Period Start")
            {
            }
            column(payPoint; 'TOM MBOYA UNIVERSITY COLLEGE')
            {
            }
            column(secCode; objEmp.Section)
            {
            }
            column(PayMode; 'BANK')
            {
            }
            column(BankDet; bankst."Bank Name" + ' - ' + bankst."Branch Name")
            {
            }
            column(strBank; strBank)
            {
            }
            column(strBranch; strBranch)
            {
            }
            column(strAccountNo; strAccountNo)
            {
            }
            column(empNo; objEmp."No.")
            {
            }
            column(FName; objEmp."First Name")
            {
            }
            column(MName; objEmp."Middle Name")
            {
            }
            column(LName; objEmp."Last Name")
            {
            }
            column(initials; objEmp.Initials)
            {
            }
            column(AccNumber; emp1."Bank Account Number")
            {
            }
            column(strNssfNo; strNssfNo)
            {
            }
            column(strNhifNo; strNhifNo)
            {
            }
            column(strPin; strPin)
            {
            }
            column(initials1; initials1)
            {
            }
            column(FName1; FName1)
            {
            }
            column(MName1; MName1)
            {
            }
            column(LName1; LName1)
            {
            }
            column(initials2; initials2)
            {
            }
            column(FName2; FName2)
            {
            }
            column(MName2; MName2)
            {
            }
            column(LName2; LName2)
            {
            }
            column(Bpay1; Bpay1)
            {
            }
            column(Bpay2; Bpay2)
            {
            }
            column(sections; emp1.Section)
            {
            }
            column(allowtext1_1; allowtext1[1])
            {
            }
            column(allowtext2_1; allowtext2[1])
            {
            }
            column(allow_amount1_1; allow_amount1[1])
            {
            }
            column(allow_amount2_1; allow_amount2[1])
            {
            }
            column(allowtext1_2; allowtext1[2])
            {
            }
            column(allowtext2_2; allowtext2[2])
            {
            }
            column(allow_amount1_2; allow_amount1[2])
            {
            }
            column(allow_amount2_2; allow_amount2[2])
            {
            }
            column(allowtext1_3; allowtext1[3])
            {
            }
            column(allowtext2_3; allowtext2[3])
            {
            }
            column(allow_amount1_3; allow_amount1[3])
            {
            }
            column(allow_amount2_3; allow_amount2[3])
            {
            }
            column(allowtext1_4; allowtext1[4])
            {
            }
            column(allowtext2_4; allowtext2[4])
            {
            }
            column(allow_amount1_4; allow_amount1[4])
            {
            }
            column(allow_amount2_4; allow_amount2[4])
            {
            }
            column(allowtext1_5; allowtext1[5])
            {
            }
            column(allowtext2_5; allowtext2[5])
            {
            }
            column(allow_amount1_5; allow_amount1[5])
            {
            }
            column(allow_amount2_5; allow_amount2[5])
            {
            }
            column(allowtext1_6; allowtext1[6])
            {
            }
            column(allowtext2_6; allowtext2[6])
            {
            }
            column(allow_amount1_6; allow_amount1[6])
            {
            }
            column(allow_amount2_6; allow_amount2[6])
            {
            }
            column(allowtext1_7; allowtext1[7])
            {
            }
            column(allowtext2_7; allowtext2[7])
            {
            }
            column(allow_amount1_7; allow_amount1[7])
            {
            }
            column(allow_amount2_7; allow_amount2[7])
            {
            }
            column(allowtext1_8; allowtext1[8])
            {
            }
            column(allowtext2_8; allowtext2[8])
            {
            }
            column(allow_amount1_8; allow_amount1[8])
            {
            }
            column(allow_amount2_8; allow_amount2[8])
            {
            }
            column(allowtext1_9; allowtext1[9])
            {
            }
            column(allowtext2_9; allowtext2[9])
            {
            }
            column(allow_amount1_9; allow_amount1[9])
            {
            }
            column(allow_amount2_9; allow_amount2[9])
            {
            }
            column(allowtext1_10; allowtext1[10])
            {
            }
            column(allowtext2_10; allowtext2[10])
            {
            }
            column(allow_amount1_10; allow_amount1[10])
            {
            }
            column(allow_amount2_10; allow_amount2[10])
            {
            }
            column(allowtext1_11; allowtext1[11])
            {
            }
            column(allowtext2_11; allowtext2[11])
            {
            }
            column(allow_amount1_11; allow_amount1[11])
            {
            }
            column(allow_amount2_11; allow_amount2[11])
            {
            }
            column(allowtext1_12; allowtext1[12])
            {
            }
            column(allowtext2_12; allowtext2[12])
            {
            }
            column(allow_amount1_12; allow_amount1[12])
            {
            }
            column(allow_amount2_12; allow_amount2[12])
            {
            }
            column(allowtext1_13; allowtext1[13])
            {
            }
            column(allowtext2_13; allowtext2[13])
            {
            }
            column(allow_amount1_13; allow_amount1[13])
            {
            }
            column(allow_amount2_13; allow_amount2[13])
            {
            }
            column(allowtext1_14; allowtext1[14])
            {
            }
            column(allowtext2_14; allowtext2[14])
            {
            }
            column(allow_amount1_14; allow_amount1[14])
            {
            }
            column(allow_amount2_14; allow_amount2[14])
            {
            }
            column(allowtext1_15; allowtext1[15])
            {
            }
            column(allowtext2_15; allowtext2[15])
            {
            }
            column(allow_amount1_15; allow_amount1[15])
            {
            }
            column(allow_amount2_15; allow_amount2[15])
            {
            }
            column(allowtext1_16; allowtext1[16])
            {
            }
            column(allowtext2_16; allowtext2[16])
            {
            }
            column(allow_amount1_16; allow_amount1[16])
            {
            }
            column(allow_amount2_16; allow_amount2[16])
            {
            }
            column(allowtext1_17; allowtext1[17])
            {
            }
            column(allowtext2_17; allowtext2[17])
            {
            }
            column(allow_amount1_17; allow_amount1[17])
            {
            }
            column(allow_amount2_17; allow_amount2[17])
            {
            }
            column(allowtext1_18; allowtext1[18])
            {
            }
            column(allowtext2_18; allowtext2[18])
            {
            }
            column(allow_amount1_18; allow_amount1[18])
            {
            }
            column(allow_amount2_18; allow_amount2[18])
            {
            }
            column(allowtext1_19; allowtext1[19])
            {
            }
            column(allowtext2_19; allowtext2[19])
            {
            }
            column(allow_amount1_19; allow_amount1[19])
            {
            }
            column(allow_amount2_19; allow_amount2[19])
            {
            }
            column(allowtext1_20; allowtext1[20])
            {
            }
            column(allowtext2_20; allowtext2[20])
            {
            }
            column(allow_amount1_20; allow_amount1[20])
            {
            }
            column(allow_amount2_20; allow_amount2[20])
            {
            }
            column(Dedtext1_1; Dedtext1[1])
            {
            }
            column(Ded_amount1_1; Ded_amount1[1])
            {
            }
            column(Ded_Amount_Bal1_1; Ded_Amount_Bal1[1])
            {
            }
            column(Dedtext2_1; Dedtext2[1])
            {
            }
            column(Ded_amount2_1; Ded_amount2[1])
            {
            }
            column(Ded_Amount_Bal2_1; Ded_Amount_Bal2[1])
            {
            }
            column(Dedtext1_2; Dedtext1[2])
            {
            }
            column(Ded_amount1_2; Ded_amount1[2])
            {
            }
            column(Ded_Amount_Bal1_2; Ded_Amount_Bal1[2])
            {
            }
            column(Dedtext2_2; Dedtext2[2])
            {
            }
            column(Ded_amount2_2; Ded_amount2[2])
            {
            }
            column(Ded_Amount_Bal2_2; Ded_Amount_Bal2[2])
            {
            }
            column(Dedtext1_3; Dedtext1[3])
            {
            }
            column(Ded_amount1_3; Ded_amount1[3])
            {
            }
            column(Ded_Amount_Bal1_3; Ded_Amount_Bal1[3])
            {
            }
            column(Dedtext2_3; Dedtext2[3])
            {
            }
            column(Ded_amount2_3; Ded_amount2[3])
            {
            }
            column(Ded_Amount_Bal2_3; Ded_Amount_Bal2[3])
            {
            }
            column(Dedtext1_4; Dedtext1[4])
            {
            }
            column(Ded_amount1_4; Ded_amount1[4])
            {
            }
            column(Ded_Amount_Bal1_4; Ded_Amount_Bal1[4])
            {
            }
            column(Dedtext2_4; Dedtext2[4])
            {
            }
            column(Ded_amount2_4; Ded_amount2[4])
            {
            }
            column(Ded_Amount_Bal2_4; Ded_Amount_Bal2[4])
            {
            }
            column(Dedtext1_5; Dedtext1[5])
            {
            }
            column(Ded_amount1_5; Ded_amount1[5])
            {
            }
            column(Ded_Amount_Bal1_5; Ded_Amount_Bal1[5])
            {
            }
            column(Dedtext2_5; Dedtext2[5])
            {
            }
            column(Ded_amount2_5; Ded_amount2[5])
            {
            }
            column(Ded_Amount_Bal2_5; Ded_Amount_Bal2[5])
            {
            }
            column(Dedtext1_6; Dedtext1[6])
            {
            }
            column(Ded_amount1_6; Ded_amount1[6])
            {
            }
            column(Ded_Amount_Bal1_6; Ded_Amount_Bal1[6])
            {
            }
            column(Dedtext2_6; Dedtext2[6])
            {
            }
            column(Ded_amount2_6; Ded_amount2[6])
            {
            }
            column(Ded_Amount_Bal2_6; Ded_Amount_Bal2[6])
            {
            }
            column(Dedtext1_7; Dedtext1[7])
            {
            }
            column(Ded_amount1_7; Ded_amount1[7])
            {
            }
            column(Ded_Amount_Bal1_7; Ded_Amount_Bal1[7])
            {
            }
            column(Dedtext2_7; Dedtext2[7])
            {
            }
            column(Ded_amount2_7; Ded_amount2[7])
            {
            }
            column(Ded_Amount_Bal2_7; Ded_Amount_Bal2[7])
            {
            }
            column(Dedtext1_8; Dedtext1[8])
            {
            }
            column(Ded_amount1_8; Ded_amount1[8])
            {
            }
            column(Ded_Amount_Bal1_8; Ded_Amount_Bal1[8])
            {
            }
            column(Dedtext2_8; Dedtext2[8])
            {
            }
            column(Ded_amount2_8; Ded_amount2[8])
            {
            }
            column(Ded_Amount_Bal2_8; Ded_Amount_Bal2[8])
            {
            }
            column(Dedtext1_9; Dedtext1[9])
            {
            }
            column(Ded_amount1_9; Ded_amount1[9])
            {
            }
            column(Ded_Amount_Bal1_9; Ded_Amount_Bal1[9])
            {
            }
            column(Dedtext2_9; Dedtext2[9])
            {
            }
            column(Ded_amount2_9; Ded_amount2[9])
            {
            }
            column(Ded_Amount_Bal2_9; Ded_Amount_Bal2[9])
            {
            }
            column(Dedtext1_10; Dedtext1[10])
            {
            }
            column(Ded_amount1_10; Ded_amount1[10])
            {
            }
            column(Ded_Amount_Bal1_10; Ded_Amount_Bal1[10])
            {
            }
            column(Dedtext2_10; Dedtext2[10])
            {
            }
            column(Ded_amount2_10; Ded_amount2[10])
            {
            }
            column(Ded_Amount_Bal2_10; Ded_Amount_Bal2[10])
            {
            }
            column(Dedtext1_11; Dedtext1[11])
            {
            }
            column(Ded_amount1_11; Ded_amount1[11])
            {
            }
            column(Ded_Amount_Bal1_11; Ded_Amount_Bal1[11])
            {
            }
            column(Dedtext2_11; Dedtext2[11])
            {
            }
            column(Ded_amount2_11; Ded_amount2[11])
            {
            }
            column(Ded_Amount_Bal2_11; Ded_Amount_Bal2[11])
            {
            }
            column(Dedtext1_12; Dedtext1[12])
            {
            }
            column(Ded_amount1_12; Ded_amount1[12])
            {
            }
            column(Ded_Amount_Bal1_12; Ded_Amount_Bal1[12])
            {
            }
            column(Dedtext2_12; Dedtext2[12])
            {
            }
            column(Ded_amount2_12; Ded_amount2[12])
            {
            }
            column(Ded_Amount_Bal2_12; Ded_Amount_Bal2[12])
            {
            }
            column(Dedtext1_13; Dedtext1[13])
            {
            }
            column(Ded_amount1_13; Ded_amount1[13])
            {
            }
            column(Ded_Amount_Bal1_13; Ded_Amount_Bal1[13])
            {
            }
            column(Dedtext2_13; Dedtext2[13])
            {
            }
            column(Ded_amount2_13; Ded_amount2[13])
            {
            }
            column(Ded_Amount_Bal2_13; Ded_Amount_Bal2[13])
            {
            }
            column(Dedtext1_14; Dedtext1[14])
            {
            }
            column(Ded_amount1_14; Ded_amount1[14])
            {
            }
            column(Ded_Amount_Bal1_14; Ded_Amount_Bal1[14])
            {
            }
            column(Dedtext2_14; Dedtext2[14])
            {
            }
            column(Ded_amount2_14; Ded_amount2[14])
            {
            }
            column(Ded_Amount_Bal2_14; Ded_Amount_Bal2[14])
            {
            }
            column(Dedtext1_15; Dedtext1[15])
            {
            }
            column(Ded_amount1_15; Ded_amount1[15])
            {
            }
            column(Ded_Amount_Bal1_15; Ded_Amount_Bal1[15])
            {
            }
            column(Dedtext2_15; Dedtext2[15])
            {
            }
            column(Ded_amount2_15; Ded_amount2[15])
            {
            }
            column(Ded_Amount_Bal2_15; Ded_Amount_Bal2[15])
            {
            }
            column(Dedtext1_16; Dedtext1[16])
            {
            }
            column(Ded_amount1_16; Ded_amount1[16])
            {
            }
            column(Ded_Amount_Bal1_16; Ded_Amount_Bal1[16])
            {
            }
            column(Dedtext2_16; Dedtext2[16])
            {
            }
            column(Ded_amount2_16; Ded_amount2[16])
            {
            }
            column(Ded_Amount_Bal2_16; Ded_Amount_Bal2[16])
            {
            }
            column(Dedtext1_17; Dedtext1[17])
            {
            }
            column(Ded_amount1_17; Ded_amount1[17])
            {
            }
            column(Ded_Amount_Bal1_17; Ded_Amount_Bal1[17])
            {
            }
            column(Dedtext2_17; Dedtext2[17])
            {
            }
            column(Ded_amount2_17; Ded_amount2[17])
            {
            }
            column(Ded_Amount_Bal2_17; Ded_Amount_Bal2[17])
            {
            }
            column(Dedtext1_18; Dedtext1[18])
            {
            }
            column(Ded_amount1_18; Ded_amount1[18])
            {
            }
            column(Ded_Amount_Bal1_18; Ded_Amount_Bal1[18])
            {
            }
            column(Dedtext2_18; Dedtext2[18])
            {
            }
            column(Ded_amount2_18; Ded_amount2[18])
            {
            }
            column(Ded_Amount_Bal2_18; Ded_Amount_Bal2[18])
            {
            }
            column(Dedtext1_19; Dedtext1[19])
            {
            }
            column(Ded_amount1_19; Ded_amount1[19])
            {
            }
            column(Ded_Amount_Bal1_19; Ded_Amount_Bal1[19])
            {
            }
            column(Dedtext2_19; Dedtext2[19])
            {
            }
            column(Ded_amount2_19; Ded_amount2[19])
            {
            }
            column(Ded_Amount_Bal2_19; Ded_Amount_Bal2[19])
            {
            }
            column(Dedtext1_20; Dedtext1[20])
            {
            }
            column(Ded_amount1_20; Ded_amount1[20])
            {
            }
            column(Ded_Amount_Bal1_20; Ded_Amount_Bal1[20])
            {
            }
            column(Dedtext2_20; Dedtext2[20])
            {
            }
            column(Ded_amount2_20; Ded_amount2[20])
            {
            }
            column(Ded_Amount_Bal2_20; Ded_Amount_Bal2[20])
            {
            }
            column(Dedtext1_21; Dedtext1[21])
            {
            }
            column(Ded_amount1_21; Ded_amount1[21])
            {
            }
            column(Ded_Amount_Bal1_21; Ded_Amount_Bal1[21])
            {
            }
            column(Dedtext2_21; Dedtext2[21])
            {
            }
            column(Ded_amount2_21; Ded_amount2[21])
            {
            }
            column(Ded_Amount_Bal2_21; Ded_Amount_Bal2[21])
            {
            }
            column(Dedtext1_22; Dedtext1[22])
            {
            }
            column(Ded_amount1_22; Ded_amount1[22])
            {
            }
            column(Ded_Amount_Bal1_22; Ded_Amount_Bal1[22])
            {
            }
            column(Dedtext2_22; Dedtext2[22])
            {
            }
            column(Ded_amount2_22; Ded_amount2[22])
            {
            }
            column(Ded_Amount_Bal2_22; Ded_Amount_Bal2[22])
            {
            }
            column(TotDedtext1; TotDedtext1)
            {
            }
            column(TotDed_amount1; TotDed_amount1)
            {
            }
            column(TotDedtext2; TotDedtext2)
            {
            }
            column(TotDed_amount2; TotDed_amount2)
            {
            }
            column(GPaytext1; GPaytext1)
            {
            }
            column(GPay_amount1; GPay_amount1)
            {
            }
            column(GPaytext2; GPaytext2)
            {
            }
            column(GPay_amount2; GPay_amount2)
            {
            }
            column(NPaytext1; NPaytext1)
            {
            }
            column(NPay_amount1; NPay_amount1)
            {
            }
            column(NPaytext2; NPaytext2)
            {
            }
            column(NPay_amount2; NPay_amount2)
            {
            }
            column(PSRLtext1; PSRLtext1)
            {
            }
            column(PSRL_amount1; PSRL_amount1)
            {
            }
            column(PSRLtext2; PSRLtext2)
            {
            }
            column(PSRL_amount2; PSRL_amount2)
            {
            }
            column(empNo1; empNo1)
            {
            }
            column(empNo2; empNo2)
            {
            }
            column(strDept1; strDept1)
            {
            }
            column(strDept2; strDept2)
            {
            }
            column(TotStat1; TotStat1)
            {
            }
            column(TotStat2; TotStat2)
            {
            }

            trigger OnAfterGetRecord()
            begin


                objPeriod.RESET;
                objPeriod.SETRANGE("Date Openned", SelectedPeriod);
                objPeriod.SETRANGE("Current Instalment", InstalmentNo);
                IF objPeriod.FIND('-') THEN BEGIN
                END;

                emp1.RESET;
                emp1.SETRANGE(emp1."No.", "PRL Employee Days Worked"."Employee Code");
                IF emp1.FIND('-') THEN BEGIN
                    bankst.RESET;
                    bankst.SETRANGE(bankst."Bank Code", emp1."Main Bank");
                    bankst.SETRANGE(bankst."Branch Code", emp1."Branch Bank");
                    IF bankst.FIND('-') THEN BEGIN

                    END;
                END;

                CLEAR(datesfil);


                datesfil := FORMAT("PRL Employee Days Worked"."Payroll Period") + '..' + FORMAT(CALCDATE('<+1M-1D>', "PRL Employee Days Worked"."Payroll Period"));
                dates1.RESET;
                dates1.SETRANGE(dates1."Period Type", dates1."Period Type"::Date);
                dates1.SETRANGE(dates1."Period No.", 5);
                //dates1.SETRANGE(dates1."Period Name",'FRIDAY');
                dates1.SETFILTER(dates1."Period Start", '%1..%2', "PRL Employee Days Worked"."Payroll Period", CALCDATE('<+1M-1D>', "PRL Employee Days Worked"."Payroll Period"));
                IF dates1.FIND('+') THEN BEGIN
                    //dates1.CALCFIELDS(dates1."Period Start");
                    // ERROR(FORMAT("prSalary Card"."Payroll Period")+'..'+FORMAT(CALCDATE('<+1M-1D>',"prSalary Card"."Payroll Period")));
                END;
                //IF ((ColumnNo=1) OR (ColumnNo=0)) THEN BEGIN ColumnNo:=ColumnNo+1;

                //END ELSE IF ColumnNo=2  THEN BEGIN ColumnNo:=1;END;

                //IF ColumnNo=1 THEN BEGIN
                // Clear Variables for the 1st Emp
                CLEAR(empNo1);
                CLEAR(initials1);
                CLEAR(FName1);
                CLEAR(MName1);
                CLEAR(LName1);
                CLEAR(strNames1);
                CLEAR(strDept1);
                CLEAR(StrPeriodName1);
                CLEAR(stPaymode1);
                CLEAR(strBankName1);
                CLEAR(strBankBranchName1);
                CLEAR(strBankAccount1);
                CLEAR(StrNssf1);
                CLEAR(StrNHIF1);
                CLEAR(StrPinNo1);
                CLEAR(Bpay1);
                CLEAR(allowtext1);
                CLEAR(allow_amount1);
                CLEAR(Stattext1);
                CLEAR(Stat_amount1);
                CLEAR(payetext1);
                CLEAR(paye_amount1);
                CLEAR(Dedtext1);
                CLEAR(Ded_amount1);
                CLEAR(Ded_Amount_Bal1);
                CLEAR(TotDedtext1);
                CLEAR(TotDed_amount1);
                CLEAR(GPaytext1);
                CLEAR(GPay_amount1);
                CLEAR(NPaytext1);
                CLEAR(NPay_amount1);
                CLEAR(PSRLtext1);
                CLEAR(PSRL_amount1);
                CLEAR(ORel_1Index);
                CLEAR(ORel_text1);
                CLEAR(ORel_amount1);
                CLEAR(all1Index);
                CLEAR(TotStat1);
                CLEAR(Ded1Index);
                //END ELSE IF ColumnNo=2 THEN BEGIN
                // Clear Variables for the 2nd Emp
                CLEAR(Ded2Index);
                CLEAR(empNo2);
                CLEAR(all2Index);
                CLEAR(initials2);
                CLEAR(FName2);
                CLEAR(MName2);
                CLEAR(LName2);
                CLEAR(strNames2);
                CLEAR(strDept2);
                CLEAR(StrPeriodName2);
                CLEAR(stPaymode2);
                CLEAR(strBankName2);
                CLEAR(strBankBranchName2);
                CLEAR(strBankAccount2);
                CLEAR(StrNssf2);
                CLEAR(StrNHIF2);
                CLEAR(StrPinNo2);
                CLEAR(Bpay2);
                CLEAR(allowtext2);
                CLEAR(allow_amount2);
                CLEAR(Stattext2);
                CLEAR(Stat_amount2);
                CLEAR(payetext2);
                CLEAR(paye_amount2);
                CLEAR(Dedtext2);
                CLEAR(Ded_amount2);
                CLEAR(Ded_Amount_Bal2);
                CLEAR(TotDedtext2);
                CLEAR(TotDed_amount2);
                CLEAR(GPaytext2);
                CLEAR(GPay_amount2);
                CLEAR(NPaytext2);
                CLEAR(NPay_amount2);
                CLEAR(PSRLtext2);
                CLEAR(PSRL_amount2);
                CLEAR(ORel_2Index);
                CLEAR(ORel_text2);
                CLEAR(ORel_amount2);
                CLEAR(TotStat2);
                //END;

                strNssfNo := '. ';
                strNhifNo := '. ';
                strBank := '. ';
                strBranch := '. ';
                strAccountNo := '. ';
                strPin := '. ';
                /*CLEAR();
                CLEAR();
                CLEAR();
                CLEAR();
                CLEAR();
                CLEAR();
                CLEAR();
                CLEAR(); */

                RecordNo := RecordNo + 1;

                //Get the staff details (header)
                objEmp.SETRANGE(objEmp."No.", "PRL Employee Days Worked"."Employee Code");
                IF objEmp.FIND('-') THEN BEGIN
                    IF objEmp."Department Code" <> '' THEN BEGIN
                        Dimm.RESET;
                        Dimm.SETRANGE(Dimm."Dimension Code", 'DEPARTMENT');
                        Dimm.SETRANGE(Dimm.Code, objEmp."Department Code");
                        IF Dimm.FIND('-') THEN BEGIN
                            dept := Dimm.Name;
                        END;
                    END;
                    strEmpName := '[' + objEmp."No." + ']  ' + objEmp.Initials + '. ' + objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    // IF ColumnNo=1 THEN BEGIN
                    initials1 := objEmp.Initials;
                    empNo1 := objEmp."No.";
                    FName1 := objEmp."First Name";
                    MName1 := objEmp."Middle Name";
                    LName1 := objEmp."Last Name";
                    // END ELSE IF ColumnNo=2 THEN BEGIN
                    empNo2 := objEmp."No.";
                    initials2 := objEmp.Initials;
                    FName2 := objEmp."First Name";
                    MName2 := objEmp."Middle Name";
                    LName2 := objEmp."Last Name";
                    // END;

                    strPin := objEmp."PAYE Number";
                    dtDOE := objEmp."Date Of Join";
                    STATUS := FORMAT(objEmp.Status);
                    "Served Notice Period" := objEmp."Served Notice Period";
                    // dept:=objEmp."Department Code";
                    IF objEmp."Date Of Leaving" = 0D THEN
                        dtOfLeaving := DMY2DATE(31, 12, 9999)
                    ELSE
                        dtOfLeaving := objEmp."Date Of Leaving";
                    ////////////////////

                    ////////////////////

                    //Get the staff banks in the payslip - Dennis ***************************************************
                    strNssfNo := objEmp."NSSF No.";
                    strNhifNo := objEmp."NHIF No.";
                    strPin := objEmp."PAYE Number";
                    strBankno := objEmp."Main Bank";
                    strBranchno := objEmp."Branch Bank";
                    bankStruct.SETRANGE(bankStruct."Bank Code", strBankno);
                    bankStruct.SETRANGE(bankStruct."Branch Code", strBranchno);
                    IF bankStruct.FIND('-') THEN BEGIN
                        strAccountNo := objEmp."Bank Account Number";
                        strBank := bankStruct."Bank Name" + '-' + bankStruct."Branch Name";
                        strBranch := bankStruct."Branch Name";
                    END;
                    //*************************************************************************************************

                END;


                /*If the Employee's Pay is suspended, OR  the guy is active DO NOT execute the following code
                *****************************************************************************************************/
                //IF ("Suspend Pay"=FALSE) THEN
                //BEGIN
                //CLEAR(objOcx);
                strEmpCode := "PRL Employee Days Worked"."Employee Code";
                //objOcx.fnProcesspayroll(strEmpCode,dtDOE,"Basic Pay","Pays PAYE","Pays NSSF","Pays NHIF",SelectedPeriod,STATUS,
                //dtOfLeaving,"Served Notice Period", dept);
                //END;
                /******************************************************************************************************/

                //Clear headers
                /*Addr[ColumnNo][1] :='';
                Addr[ColumnNo][2] :='';
                Addr[ColumnNo][3] :='';
                Addr[ColumnNo][4] :='';
                Addr[ColumnNo][5] :='';
                Addr[ColumnNo][6] :='';
                Addr[ColumnNo][7] :='';
                Addr[ColumnNo][8] :='';
                Addr[ColumnNo][9] :='';
                Addr[ColumnNo][10] :=''; */



                //Clear previous Transaction entries 53
                FOR intRow := 1 TO 53 DO BEGIN
                    /* Trans[ColumnNo,intRow]:='';
                     TransAmt[ColumnNo,intRow]:='';
                     TransBal[ColumnNo,intRow]:='';
                     Trans2[ColumnNo,intRow]:='';
                     TransAmt2[ColumnNo,intRow]:='';
                     TransBal2[ColumnNo,intRow]:='';  */

                END;

                //Loop through the transactions
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", objEmp."No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE(PeriodTrans."Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                //IF ColumnNo=1 THEN BEGIN
                strNames1 := FORMAT(strEmpName);
                strDept1 := emp1.Section; //Depart
                StrPeriodName1 := PeriodName; //Period
                //END ELSE IF ColumnNo=2 THEN BEGIN
                strNames2 := FORMAT(strEmpName);
                //strDept2 := emp2.Section; //Depart
                StrPeriodName2 := PeriodName; //Period
                                              //END;

                /*Fill-in the other staff information
                *******************************************************************************/

                /*Addr[ColumnNo,5]:='N.S.S.F No:   '+strNssfNo;
                Addr[ColumnNo,6]:='N.H.I.F No:   '+strNhifNo;
                Addr[ColumnNo,7]:='Bank:       '+strBank;
                Addr[ColumnNo,8]:='Branch:     '+strBranch;
                Addr[ColumnNo,9]:='Account No:   '+strAccountNo;
                Addr[ColumnNo,10]:='PIN:                '+strPin;*/

                //IF ColumnNo=1 THEN BEGIN
                stPaymode1 := 'BANK';
                strBankName1 := strBank;
                strBankBranchName1 := strBranch;
                strBankAccount1 := strAccountNo;
                StrNssf1 := strNssfNo;
                StrNHIF1 := strNhifNo;
                StrPinNo1 := strPin;
                //END ELSE IF ColumnNo=1 THEN BEGIN
                stPaymode2 := 'BANK';
                strBankName2 := strBank;
                strBankBranchName2 := strBranch;
                strBankAccount2 := strAccountNo;
                StrNssf2 := strNssfNo;
                StrNHIF2 := strNhifNo;
                StrPinNo2 := strPin;
                //END;

                Index := 1;
                strGrpText := '';
                IF PeriodTrans.FIND('-') THEN
                    REPEAT

                        IF strGrpText <> PeriodTrans."Group Text" THEN BEGIN

                            // Pick Basic Salary
                            IF ((PeriodTrans."Group Order" = 1) AND (PeriodTrans."Sub Group Order" = 1)) THEN BEGIN//1
                                IF PeriodTrans.Amount <> 0 THEN BEGIN
                                    //IF ColumnNo = 1 THEN BEGIN
                                    all1Index := all1Index + 1;
                                    allowtext1[all1Index] := PeriodTrans."Transaction Name";
                                    allow_amount1[all1Index] := PeriodTrans.Amount;
                                    // END ELSE IF ColumnNo = 2 THEN BEGIN
                                    all2Index := all2Index + 1;
                                    allowtext2[all2Index] := PeriodTrans."Transaction Name";
                                    allow_amount2[all2Index] := PeriodTrans.Amount;
                                    // END;
                                END;
                            END;//1

                            // Pick Allowances
                            IF ((PeriodTrans."Group Order" = 3) AND (PeriodTrans."Sub Group Order" = 0)) THEN BEGIN//2
                                                                                                                   //  IF ColumnNo = 1 THEN BEGIN
                                all1Index := all1Index + 1;
                                allowtext1[all1Index] := PeriodTrans."Transaction Name";
                                allow_amount1[all1Index] := PeriodTrans.Amount;
                                //  END ELSE IF ColumnNo = 2 THEN BEGIN
                                all2Index := all2Index + 1;
                                allowtext2[all2Index] := PeriodTrans."Transaction Name";
                                allow_amount2[all2Index] := PeriodTrans.Amount;
                                //  END;
                            END;//2

                            // Pick Statutories
                            IF ((PeriodTrans."Group Order" = 7)) THEN BEGIN//3    AND  (PeriodTrans."Sub Group Order"<>3)
                                                                           //  IF ColumnNo = 1 THEN BEGIN
                                TotStat1 := TotStat1 + PeriodTrans.Amount;
                                Ded1Index := Ded1Index + 1;
                                Dedtext1[Ded1Index] := PeriodTrans."Transaction Name";
                                Ded_amount1[Ded1Index] := PeriodTrans.Amount;
                                Ded_Amount_Bal1[Ded1Index] := PeriodTrans.Balance;
                                // END ELSE IF ColumnNo = 2 THEN BEGIN
                                TotStat2 := TotStat2 + PeriodTrans.Amount;
                                Ded2Index := Ded2Index + 1;
                                Dedtext2[Ded2Index] := PeriodTrans."Transaction Name";
                                Ded_amount2[Ded2Index] := PeriodTrans.Amount;
                                Ded_Amount_Bal2[Ded2Index] := PeriodTrans.Balance;
                                //   END;
                            END;//3

                            // Pick PAYE
                            /* IF ((PeriodTrans."Group Order"=6) AND  (PeriodTrans."Sub Group Order"=7)) THEN BEGIN//3
                              //  IF ColumnNo = 1 THEN BEGIN
                                  Ded1Index:=Ded1Index+1;
                                  Dedtext1[Ded1Index]:=PeriodTrans."Transaction Name";
                                  Ded_amount1[Ded1Index]:=PeriodTrans.Amount;
                                  Ded_Amount_Bal1[Ded1Index]:=PeriodTrans.Balance;
                             //   END ELSE IF ColumnNo = 2 THEN BEGIN
                                  Ded2Index:=Ded2Index+1;
                                  Dedtext2[Ded2Index]:=PeriodTrans."Transaction Name";
                                  Ded_amount2[Ded2Index]:=PeriodTrans.Amount;
                                  Ded_Amount_Bal2[Ded2Index]:=PeriodTrans.Balance;
                              //   END;
                             END;*///3

                            // Pick Deductions
                            IF ((PeriodTrans."Group Order" = 8) AND ((PeriodTrans."Sub Group Order" = 0) OR (PeriodTrans."Sub Group Order" = 1))) THEN BEGIN//4
                                                                                                                                                            //   IF ColumnNo = 1 THEN BEGIN
                                Ded1Index := Ded1Index + 1;
                                Dedtext1[Ded1Index] := PeriodTrans."Transaction Name";
                                Ded_amount1[Ded1Index] := PeriodTrans.Amount;
                                Ded_Amount_Bal1[Ded1Index] := PeriodTrans.Balance;
                                //   END ELSE IF ColumnNo = 2 THEN BEGIN
                                Ded2Index := Ded2Index + 1;
                                Dedtext2[Ded2Index] := PeriodTrans."Transaction Name";
                                Ded_amount2[Ded2Index] := PeriodTrans.Amount;
                                Ded_Amount_Bal2[Ded2Index] := PeriodTrans.Balance;
                                //   END;
                            END;//4

                            // Pick Total Deductions
                            IF ((PeriodTrans."Group Order" = 8) AND (PeriodTrans."Sub Group Order" = 9)) THEN BEGIN//5
                                                                                                                   //  IF ColumnNo = 1 THEN BEGIN
                                TotDedtext1 := PeriodTrans."Transaction Name";
                                TotDed_amount1 := PeriodTrans.Amount;
                                // END ELSE IF ColumnNo = 2 THEN BEGIN
                                TotDedtext2 := PeriodTrans."Transaction Name";
                                TotDed_amount2 := PeriodTrans.Amount;
                                //   END;
                            END;//5

                            // Pick Gross Pay
                            IF ((PeriodTrans."Group Order" = 4) AND (PeriodTrans."Sub Group Order" = 0)) THEN BEGIN//6
                                                                                                                   //  IF ColumnNo = 1 THEN BEGIN
                                GPaytext1 := PeriodTrans."Transaction Name";
                                GPay_amount1 := PeriodTrans.Amount;
                                //  END ELSE IF ColumnNo = 2 THEN BEGIN
                                GPaytext2 := PeriodTrans."Transaction Name";
                                GPay_amount2 := PeriodTrans.Amount;
                                //   END;
                            END;//6

                            // Pick Net Pay
                            IF ((PeriodTrans."Group Order" = 9) AND (PeriodTrans."Sub Group Order" = 0)) THEN BEGIN//7
                                                                                                                   //  IF ColumnNo = 1 THEN BEGIN
                                NPaytext1 := PeriodTrans."Transaction Name";
                                NPay_amount1 := PeriodTrans.Amount;
                                // END ELSE IF ColumnNo = 2 THEN BEGIN
                                NPaytext2 := PeriodTrans."Transaction Name";
                                NPay_amount2 := PeriodTrans.Amount;
                                //   END;
                            END;//7

                            // Pick personal Relief
                            IF ((PeriodTrans."Group Order" = 6) AND (PeriodTrans."Sub Group Order" = 9)) THEN BEGIN//8
                                                                                                                   //  IF ColumnNo = 1 THEN BEGIN
                                PSRLtext1 := PeriodTrans."Transaction Name";
                                PSRL_amount1 := PeriodTrans.Amount;
                                //  END ELSE IF ColumnNo = 2 THEN BEGIN
                                PSRLtext2 := PeriodTrans."Transaction Name";
                                PSRL_amount2 := PeriodTrans.Amount;
                                //   END;
                            END;//8

                            // Pick Other Relief
                            IF ((PeriodTrans."Group Order" = 6) AND ((PeriodTrans."Sub Group Order" = 2)
                            OR (PeriodTrans."Sub Group Order" = 3) OR (PeriodTrans."Sub Group Order" = 4)
                            OR (PeriodTrans."Sub Group Order" = 5) OR (PeriodTrans."Sub Group Order" = 8)
                            OR (PeriodTrans."Sub Group Order" = 10) OR (PeriodTrans."Sub Group Order" = 11))
                            ) THEN BEGIN//9
                                        //   IF ColumnNo = 1 THEN BEGIN
                                ORel_1Index := ORel_1Index + 1;
                                ORel_text1[ORel_1Index] := PeriodTrans."Transaction Name";
                                ORel_amount1[ORel_1Index] := PeriodTrans.Amount;
                                //   END ELSE IF ColumnNo = 2 THEN BEGIN
                                ORel_2Index := ORel_2Index + 1;
                                ORel_text2[ORel_2Index] := PeriodTrans."Transaction Name";
                                ORel_amount2[ORel_2Index] := PeriodTrans.Amount;
                                //   END;
                            END;//9

                        END;
                    UNTIL PeriodTrans.NEXT = 0;
                // IF ColumnNo> 1 THEN CurrReport.SKIP;

                /*
                IF (RecordNo = NoOfRecords) AND (ColumnNo<3) THEN BEGIN
                  FOR i := ColumnNo + 1 TO NoOfColumns DO
                    BEGIN
                      CLEAR(Addr[i]);
                      CLEAR(Trans[i]);
                      CLEAR(TransAmt[i]);
                      CLEAR(TransBal[i]);
                    END;
                
                      ColumnNo := 0;
                
                END ELSE
                
                BEGIN
                  IF ColumnNo = NoOfColumns THEN
                    ColumnNo := 0;
                END;*/

            end;

            trigger OnPreDataItem()
            begin
                SelectedPeriod := PeriodFilter;

                NoOfRecords := COUNT;
                NoOfColumns := 2;

                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "PRL Employee Days Worked"."Employee Code");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", InstalmentNo);
                IF NOT PeriodTrans.FIND('-') THEN
                    CurrReport.SKIP;


                strNssfNo := '.';
                strNhifNo := '.';
                strBank := '.';
                strBranch := '.';
                strAccountNo := '.';


                "PRL Employee Days Worked".SETFILTER("PRL Employee Days Worked"."Payroll Period", '=%1', PeriodFilter);

                "PRL Employee Days Worked".SETFILTER("PRL Employee Days Worked"."Current Instalment", '=%1', InstalmentNo);
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
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        //objPeriod.SETRANGE("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            InstalmentNo := objPeriod."Current Instalment";
            PeriodFilter := objPeriod."Date Openned";
            PeriodName := objPeriod."Period Name" + ' (' + (FORMAT(objPeriod."Current Instalment")) + (FORMAT(objPeriod."Period Instalment Prefix")) + ' Instalment)';
        END;
    end;

    trigger OnPreReport()
    begin



        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');
        //"PRL-Salary Card".SETFILTER("PRL Employee Days Worked"."Payroll Period",'=%1',PeriodFilter);
    end;

    var
        bankst: Record 61077;
        datesfil: Text;
        dates1: Record 2000000007;
        empNo1: Code[150];
        empNo2: Code[150];
        initials1: Code[150];
        FName1: Code[100];
        MName1: Code[100];
        LName1: Code[100];
        initials2: Code[150];
        FName2: Code[100];
        MName2: Code[100];
        LName2: Code[100];
        allowtext: Code[100];
        allow_amount: Decimal;
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
        objPeriod: Record 70250;
        PeriodFilter: Date;
        CompanyInfo: Record 79;
        SelectedPeriod: Date;
        PeriodName: Code[50];
        NoOfRecords: Integer;
        NoOfColumns: Integer;
        strNssfNo: Code[150];
        strNhifNo: Code[150];
        strBank: Code[150];
        strBranch: Code[150];
        strAccountNo: Code[150];
        emp1: Record "HRM-Employee (D)";
        RecordNo: Integer;
        strPin: Code[50];
        objEmp: Record "HRM-Employee (D)";
        Dimm: Record 349;
        dept: Code[40];
        dtDOE: Date;
        strEmpName: Code[250];
        STATUS: Code[50];
        "Served Notice Period": Boolean;
        dtOfLeaving: Date;
        strBankno: Code[50];
        strBranchno: Code[50];
        PeriodTrans: Record 70252;
        bankStruct: Record 61077;
        objOcx: Codeunit 70200;
        strEmpCode: Code[50];
        Addr: array[2, 10] of Code[150];
        intRow: Integer;
        Trans: array[2, 60] of Code[150];
        TransAmt: array[2, 60] of Code[150];
        TransBal: array[2, 60] of Code[150];
        Trans2: array[2, 60] of Code[150];
        TransAmt2: array[2, 60] of Code[150];
        TransBal2: array[2, 60] of Code[150];
        strNames2: Code[150];
        strDept2: Code[150];
        StrPeriodName2: Code[150];
        strNames1: Code[150];
        strDept1: Code[150];
        StrPeriodName1: Code[150];
        stPaymode1: Code[50];
        strBankName1: Code[50];
        strBankBranchName1: Code[50];
        strBankAccount1: Code[50];
        StrNssf1: Code[50];
        StrNHIF1: Code[50];
        StrPinNo1: Code[50];
        stPaymode2: Code[50];
        strBankName2: Code[50];
        strBankBranchName2: Code[50];
        strBankAccount2: Code[50];
        StrNssf2: Code[50];
        StrNHIF2: Code[50];
        StrPinNo2: Code[50];
        Index: Integer;
        strGrpText: Code[150];
        Bpay1: Decimal;
        Bpay2: Decimal;
        all1Index: Integer;
        all2Index: Integer;
        allowtext1: array[20] of Code[150];
        allowtext2: array[20] of Code[150];
        allow_amount1: array[20] of Decimal;
        allow_amount2: array[20] of Decimal;
        Stat1Index: Integer;
        Stattext1: array[20] of Code[150];
        Stat_amount1: array[20] of Decimal;
        Stat2Index: Integer;
        Stattext2: array[20] of Code[150];
        Stat_amount2: array[20] of Decimal;
        payetext1: Code[150];
        paye_amount1: Decimal;
        payetext2: Code[150];
        paye_amount2: Decimal;
        Ded1Index: Integer;
        Ded2Index: Integer;
        Dedtext1: array[22] of Code[150];
        Ded_amount1: array[22] of Decimal;
        Ded_Amount_Bal1: array[22] of Decimal;
        Dedtext2: array[22] of Code[150];
        Ded_amount2: array[22] of Decimal;
        Ded_Amount_Bal2: array[22] of Decimal;
        TotDedtext1: Code[150];
        TotDed_amount1: Decimal;
        TotDedtext2: Code[150];
        TotDed_amount2: Decimal;
        GPaytext1: Code[150];
        GPay_amount1: Decimal;
        GPaytext2: Code[150];
        GPay_amount2: Decimal;
        NPaytext1: Code[150];
        NPay_amount1: Decimal;
        NPaytext2: Code[150];
        NPay_amount2: Decimal;
        PSRLtext1: Code[150];
        PSRL_amount1: Decimal;
        PSRLtext2: Code[150];
        PSRL_amount2: Decimal;
        ORel_1Index: Integer;
        ORel_text1: array[20] of Code[150];
        ORel_amount1: array[20] of Decimal;
        ORel_2Index: Integer;
        ORel_text2: array[20] of Code[150];
        ORel_amount2: array[20] of Decimal;
        TotStat1: Decimal;
        TotStat2: Decimal;
        InstalmentNo: Integer;
}

