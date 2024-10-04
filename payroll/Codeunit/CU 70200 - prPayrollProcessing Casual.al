codeunit 70200 "prPayrollProcessing Casual"
{

    trigger OnRun()
    begin
    end;

    var
        Text020: Label 'Because of circular references, the program cannot calculate a formula.';
        Text012: Label 'You have entered an illegal value or a nonexistent row number.';
        Text013: Label 'You have entered an illegal value or a nonexistent column number.';
        Text017: Label 'The error occurred when the program tried to calculate:\';
        Text018: Label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: Label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: Label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        VitalSetup: Record 61104;
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        curDisabledLimit: Decimal;
        PostingGroup: Record 61114;
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "HRM-Employee (D)";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
        PayrollType: Code[20];
        HREmp2: Record "HRM-Employee (D)";
        curNssf_Base_Amount: Decimal;
        intNSSF_BasedOn: Option Gross,Basic;
        curNSSF_Tier: Text;
        PRPeriod: Record 70252;
        TotalSTATUTORIES: Decimal;
        BenifitAmount: Decimal;
        PRTransCode_2: Record 61082;
        PREmpTrans_2: Record 70251;
        PRPeriodTrans: Record 70252;
        MonthlyExpectedWorkHrs: Decimal;
        HoursWorked: Decimal;
        ExpectedWorkHrs: Decimal;
        TaxCharged_1: Decimal;
        SpecialTranAmount: Decimal;
        PrlPeriods: Record 70250;
        PRLEmployeeDaysWorked: Record 70200;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FINDFIRST;
        curReliefPersonal := VitalSetup."Tax Relief";
        curReliefInsurance := VitalSetup."Insurance Relief";
        curReliefMorgage := VitalSetup."Mortgage Relief"; //Same as HOSP
        curMaximumRelief := VitalSetup."Max Relief";
        //curNssfEmployee := "NSSF Employee";
        curNssf_Employer_Factor := VitalSetup."NSSF Employer Factor";
        intNHIF_BasedOn := VitalSetup."NHIF Based on";
        curMaxPensionContrib := VitalSetup."Max Pension Contribution";
        curRateTaxExPension := VitalSetup."Tax On Excess Pension";
        curOOIMaxMonthlyContrb := VitalSetup."OOI Deduction";
        curOOIDecemberDedc := VitalSetup."OOI December";
        curLoanMarketRate := VitalSetup."Loan Market Rate";
        curLoanCorpRate := VitalSetup."Loan Corporate Rate";
        curDisabledLimit := VitalSetup."Disabled Tax Limit";
        MonthlyExpectedWorkHrs := VitalSetup."Monthly Expected Work Hrs";
    end;


    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20]; blnInsuranceCertificate: Boolean; CurrInstalment: Integer)
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record 70252;
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record 61088;
        prEmployeeTransactions: Record 70251;
        prTransactionCodes: Record 61082;
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record 61090;
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record 70253;
        JournalPostingType: Option " ","G/L Account",Customer,Vendor;
        JournalAcc: Code[20];
        Customer: Record 18;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
    begin
        //Initialize
        CheckStatus(SelectedPeriod, CurrInstalment);
        blnPaysPaye := TRUE;
        blnPaysNssf := TRUE;
        CLEAR(blnInsuranceCertificate);
        IF curBasicPay = 0 THEN EXIT;
        PrlPeriods.RESET;
        IF strEmpCode = '0259773' THEN
            PrlPeriods.RESET;
        PrlPeriods.SETRANGE("Date Openned", SelectedPeriod);
        PrlPeriods.SETRANGE("Current Instalment", CurrInstalment);
        IF PrlPeriods.FIND('-') THEN BEGIN
        END;

        IF dtDOE = 0D THEN dtDOE := CALCDATE('1M', TODAY);
        fnInitialize;
        fnGetJournalDet(strEmpCode);

        //PayrollType
        PayrollType := PayrollCode;

        //check if the period selected=current period. If not, do NOT run this function
        IF SelectedPeriod <> dtOpenPeriod THEN EXIT;
        intMonth := DATE2DMY(SelectedPeriod, 2);
        intYear := DATE2DMY(SelectedPeriod, 3);

        IF curBasicPay = 0 THEN BEGIN
            //Biometrics
            PRLEmployeeDaysWorked.RESET;
            PRLEmployeeDaysWorked.SETRANGE("Employee Code", strEmpCode);
            PRLEmployeeDaysWorked.SETRANGE("Payroll Period", SelectedPeriod);
            PRLEmployeeDaysWorked.SETRANGE("Current Instalment", CurrInstalment);
            IF PRLEmployeeDaysWorked.FIND('-') THEN BEGIN

                //Calculate Basic Pay based on hrs worked for specific employees
                HREmp2.RESET;
                HREmp2.SETRANGE(HREmp2."No.", strEmpCode);
                // HREmp2.SETRANGE(HREmp2."Date Filter",CALCDATE('-cm',SelectedPeriod),CALCDATE('cm',SelectedPeriod));
                IF HREmp2.FIND('-') THEN BEGIN
                END;
                // HREmp2.CALCFIELDS(HREmp2."Total Hours Worked") ;
                //    IF (HREmp2."Based On Hours worked"=HREmp2."Based On Hours worked"::BasedOnWorkedHrs) THEN
                //    BEGIN
                //      ExpectedWorkHrs:=MonthlyExpectedWorkHrs;
                //      HoursWorked:=HREmp2."Total Days Worked";
                //MESSAGE(FORMAT(HoursWorked))  ;
                IF PRLEmployeeDaysWorked."Daily Rate" <> 0 THEN
                    curBasicPay := PRLEmployeeDaysWorked."Daily Rate" * PRLEmployeeDaysWorked."Days Worked"
                ELSE
                    curBasicPay := HREmp2."Daily Rate" * PRLEmployeeDaysWorked."Days Worked";
                //fnCalculatedBasicPay(strEmpCode, intMonth, intYear, curBasicPay,HoursWorked,ExpectedWorkHrs) ;
            END;
        END;// Compute Basic Pay from Attendance

        //Calculate Basic Pay based on hrs worked for specific employees
        //Biometrics

        curTransAmount := curBasicPay;
        strTransDescription := 'Daily Wage';
        TGroup := 'DAILY WAGE';
        TGroupOrder := 1;
        TSubGroupOrder := 1;
        fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
        TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
        salariesAcc, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none, CurrInstalment);
        /*
        //Salary Arrears
        prSalaryArrears.RESET;
        prSalaryArrears.SETRANGE(prSalaryArrears."Employee Code",strEmpCode);
        prSalaryArrears.SETRANGE(prSalaryArrears."Period Month",intMonth);
        prSalaryArrears.SETRANGE(prSalaryArrears."Period Year",intYear);
        IF prSalaryArrears.FIND('-') THEN BEGIN
        REPEAT
             curSalaryArrears := prSalaryArrears."Salary Arrears";
             curPayeArrears := prSalaryArrears."PAYE Arrears";

             //Insert [Salary Arrears] into period trans [ARREARS]
             curTransAmount := curSalaryArrears;
             strTransDescription := 'Salary Arrears';
             TGroup := 'ARREARS'; TGroupOrder := 1; TSubGroupOrder := 2;
             fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
               strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,salariesAcc,
               JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none);

             //Insert [PAYE Arrears] into period trans [PYAR]
             curTransAmount:= curPayeArrears;
             strTransDescription := 'P.A.Y.E Arrears';
             TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 4;
             fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                strTransDescription, curTransAmount, 0, intMonth, intYear,Membership,ReferenceNo,SelectedPeriod,Dept,
                TaxAccount,JournalPostAs::Debit,JournalPostingType::"G/L Account",'',CoopParameters::none)

        UNTIL prSalaryArrears.NEXT=0;
        END;
        */
        //Get Earnings
        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETRANGE("Employee Code", strEmpCode);
        prEmployeeTransactions.SETRANGE("Period Month", intMonth);
        prEmployeeTransactions.SETRANGE("Period Year", intYear);
        prEmployeeTransactions.SETRANGE("Current Instalment", PrlPeriods."Current Instalment");
        IF prEmployeeTransactions.FIND('-') THEN BEGIN
            curTotAllowances := 0;
            IsCashBenefit := 0;
            REPEAT
                prTransactionCodes.RESET;
                prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                IF prTransactionCodes.FIND('-') THEN BEGIN
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';
                    IF prTransactionCodes."Is Formula" THEN BEGIN
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula, CurrInstalment);
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount

                    END ELSE BEGIN
                        curTransAmount := prEmployeeTransactions.Amount;
                    END;

                    IF prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None THEN //[0=None, 1=Increasing, 2=Reducing]
                        curTransBalance := 0;
                    IF prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing THEN
                        curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                    IF prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing THEN
                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;


                    //Add Non Taxable Here
                    IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" =
                    prTransactionCodes."Special Transactions"::Ignore) THEN
                        curNonTaxable := curNonTaxable + curTransAmount;

                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                    IF (NOT prTransactionCodes.Taxable) AND (prTransactionCodes."Special Transactions" <>
                    prTransactionCodes."Special Transactions"::Ignore) THEN
                        curTransAmount := 0;

                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                    curTransAmount := curTransAmount;
                    curTransBalance := curTransBalance;
                    strTransDescription := prTransactionCodes."Transaction Name";
                    TGroup := 'EARNINGS';
                    TGroupOrder := 3;
                    TSubGroupOrder := 0;

                    //Get the posting Details
                    JournalPostingType := JournalPostingType::" ";
                    JournalAcc := '';
                    IF prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " THEN BEGIN
                        IF prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer THEN BEGIN
                            HrEmployee.GET(strEmpCode);

                            Customer.RESET;
                            Customer.SETRANGE(Customer."No.", HrEmployee."No.");
                            IF Customer.FIND('-') THEN BEGIN
                                JournalAcc := Customer."No.";
                                JournalPostingType := JournalPostingType::Customer;
                            END;
                        END;
                    END ELSE BEGIN
                        JournalAcc := prTransactionCodes."GL Account";
                        JournalPostingType := JournalPostingType::"G/L Account";
                    END;

                    //Get is Cash Benefits
                    IF prTransactionCodes."Is Cash" THEN
                        IsCashBenefit := IsCashBenefit + curTransAmount;
                    //End posting Details

                    fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                    strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                    prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                    prTransactionCodes."coop parameters", CurrInstalment);

                END;
            UNTIL prEmployeeTransactions.NEXT = 0;
        END;

        //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
        curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
        curTransAmount := curGrossPay;
        strTransDescription := 'Gross Pay';     //CHANGE GROSS PAY TO BLANK -HOSEA
        TGroup := 'Gross Pay';
        TGroupOrder := 4;
        TSubGroupOrder := 0;  //COMMENTED TO REMOVE GROUP HEADING-HOSEA
        fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
         intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none, CurrInstalment);


        //Get the N.S.S.F amount for the month GBT
        curNssf_Base_Amount := 0;
        IF intNSSF_BasedOn = intNSSF_BasedOn::Gross THEN //>NSSF calculation can be based on:
            curNssf_Base_Amount := curGrossPay;
        IF intNSSF_BasedOn = intNSSF_BasedOn::Basic THEN
            curNssf_Base_Amount := curBasicPay;
        // // IF strEmpCode= '0259773' THEN
        // // blnPaysNssf:=TRUE;
        //Get the NSSF amount
        IF blnPaysNssf THEN BEGIN
            curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
            curNSSF_Tier := fnGetEmployeeNSSF_Tier(curNssf_Base_Amount); //Added to Display NSSF TIER
            curTransAmount := curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NSSF, CurrInstalment);

            //Update Employer deductions
            IF blnPaysNssf THEN
                curNSSF := 200;//fnGetEmployerNSSF(curNssf_Base_Amount);
            curTransAmount := curNSSF;
            fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
             'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, CurrInstalment);


            //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
            curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
            curTransAmount := curDefinedContrib;
            strTransDescription := 'NSSF';  //change Defined contributions to NSSF-hosea
            TGroup := 'TAXATION';
            TGroupOrder := 6;
            TSubGroupOrder := 1;   //CHANGE tax calculations TO APYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
            fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
             strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ",
             JournalPostingType::" ", '', CoopParameters::none, CurrInstalment);

        END;


        IF blnPaysPaye THEN BEGIN
            //Get the Gross taxable amount
            //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
            curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

            //>If GrossTaxable = 0 Then TheDefinedToPost = 0
            IF curGrossTaxable = 0 THEN curDefinedContrib := 0;

            //Personal Relief
            // if get relief is ticked
            IF (blnGetsPAYERelief) THEN BEGIN
                curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
            END
            ELSE
                curReliefPersonal := 0;

            //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //>Pension Contribution [self] relief
            curPensionStaff := 0;//(0.03*curBasicPay); //fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                                 //SpecialTransType::"Defined Contribution",FALSE) ;//Self contrib Pension is 1 on [Special Transaction]
            IF curPensionStaff > 0 THEN BEGIN
                IF curPensionStaff > curMaxPensionContrib THEN
                    curTransAmount := curMaxPensionContrib
                ELSE
                    curTransAmount := curPensionStaff;
                strTransDescription := 'Pension Relief';
                TGroup := 'TAXATION';
                TGroupOrder := 6;
                TSubGroupOrder := 1; //CHANGE TAX CALCULATIONS TO PAYE INFORMATION -HOSEA
                fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                CoopParameters::none, CurrInstalment)
            END;




            //if he PAYS paye only*******************I
            IF blnPaysPaye THEN blnGetsPAYERelief := TRUE;
            IF blnPaysPaye AND blnGetsPAYERelief THEN BEGIN
                //Get Insurance Relief
                curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Life Insurance", FALSE, CurrInstalment); //Insurance is 3 on [Special Transaction]

                //********************************************************************************************************************************************************
                //Added DW - for employees who have brought the Insurance certificate, they are entitled to Insurance relief, Otherwise NO
                //Place a check mark on the Salary Card to YES
                IF (curInsuranceReliefAmount > 0) AND (blnInsuranceCertificate) THEN BEGIN
                    //Added Hosea - To Cap Insurance Relief to Setup amount
                    IF curInsuranceReliefAmount > curMaximumRelief THEN curInsuranceReliefAmount := curMaximumRelief;
                    //Added Hosea - To Cap Insurance Relief to Setup amount
                    curTransAmount := ROUND(curInsuranceReliefAmount, 1, '<'); //Added DW to round off to nearest shilling
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 8;   //CHANGE tax calculations TO PAYE INFORMATION -HOSEA // change TGroupOrder :=6 to 7
                    fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none, CurrInstalment);
                END;
                //********************************************************************************************************************************************************

                //>OOI
                curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Owner Occupier Interest", FALSE, CurrInstalment); //Morgage is LAST on [Special Transaction]
                IF curOOI > 0 THEN BEGIN
                    IF curOOI <= curOOIMaxMonthlyContrb THEN
                        curTransAmount := curOOI
                    ELSE
                        curTransAmount := curOOIMaxMonthlyContrb;

                    strTransDescription := 'Owner Occupier Interest';
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 2;   //CHANGE tax calculations TO PAYE INFORMATION -HOSEA  // change TGroupOrder :=6 to 7
                    fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none, CurrInstalment);
                END;

                //HOSP
                curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Home Ownership Savings Plan", FALSE, CurrInstalment); //Home Ownership Savings Plan
                IF curHOSP > 0 THEN BEGIN
                    IF curHOSP <= curReliefMorgage THEN
                        curTransAmount := curHOSP
                    ELSE
                        curTransAmount := curReliefMorgage;

                    strTransDescription := 'Home Ownership Savings Plan';
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 2;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA// change TGroupOrder :=6 to 7
                    fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none, CurrInstalment);
                END;


                //Mortage Relief
                curReliefMorgage := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
               SpecialTransType::Morgage, FALSE, CurrInstalment);
                IF curReliefMorgage > 0 THEN BEGIN
                    curTransAmount := curReliefMorgage;
                    strTransDescription := 'Mortgage Relief';
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 3;
                    fnUpdatePeriodTrans(strEmpCode, 'MORG-RL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none, CurrInstalment)

                END;






                //Enter NonTaxable Amount
                IF curNonTaxable > 0 THEN BEGIN
                    strTransDescription := 'Other Non-Taxable Benefits';
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 5;   //CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
                    fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none, CurrInstalment);
                END;

            END;

            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            //Get the Taxable amount for calculation of PAYE
            //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)

            //Added Dann for KEPHIS
            BenifitAmount := 0;
            PRTransCode_2.RESET;
            //PRTransCode_2.SETRANGE(PRTransCode_2."Transaction Type", PRTransCode_2."Transaction Type"::"2);
            IF PRTransCode_2.FIND('-') THEN BEGIN
                PREmpTrans_2.RESET;
                PREmpTrans_2.SETRANGE(PREmpTrans_2."Transaction Code", PRTransCode_2."Transaction Code");
                PREmpTrans_2.SETRANGE(PREmpTrans_2."Employee Code", strEmpCode);
                PREmpTrans_2.SETRANGE(PREmpTrans_2."Payroll Period", SelectedPeriod);
                IF PREmpTrans_2.FIND('-') THEN BEGIN
                    IF PRTransCode_2.Taxable THEN BenifitAmount := PREmpTrans_2.Amount;
                    //Insert in to PR Period Trans
                    strTransDescription := PRTransCode_2."Transaction Name";
                    curTransAmount := PREmpTrans_2.Amount;
                    TGroup := 'TAXATION';
                    TGroupOrder := 6;
                    TSubGroupOrder := 1;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA
                    fnUpdatePeriodTrans(strEmpCode, PRTransCode_2."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                    strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                    '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none, CurrInstalment);

                END;
            END;


            IF (curPensionStaff + curDefinedContrib) > curMaxPensionContrib THEN
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable) + BenifitAmount
            ELSE
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable) + BenifitAmount;
            curTransAmount := curTaxablePay;
            IF fnGetEmployeePaye(curTaxablePay) > 0 THEN BEGIN
                strTransDescription := 'Chargeable Pay';
                TGroup := 'TAXATION';
                TGroupOrder := 6;
                TSubGroupOrder := 6;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
                fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                 CoopParameters::none, CurrInstalment);
            END;

            //Get the Tax charged for the month
            // Special tax for disabled employees
            //Check if employee is disabled


            HREmp2.RESET;
            IF HREmp2.GET(strEmpCode) THEN BEGIN
                IF HREmp2.Disabled = HREmp2.Disabled::Yes THEN BEGIN
                    IF curTaxablePay >= curDisabledLimit THEN BEGIN

                        //If taxable pay is greater than limit
                        curTaxCharged := fnGetEmployeePaye(curTaxablePay - curDisabledLimit);
                        curTransAmount := curTaxCharged;
                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAXATION';
                        TGroupOrder := 6;
                        TSubGroupOrder := 7; //CHANGE tax calculations TO PAYE INFORMATION-HOSEA  // change TGroupOrder :=6 to 7
                        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                        CoopParameters::none, CurrInstalment);
                    END ELSE BEGIN
                        //If taxable pay is lower than limit
                        curTaxCharged := fnGetEmployeePaye(curTaxablePay);
                        // curTaxCharged := 0;
                        curTransAmount := curTaxCharged;
                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAXATION';
                        TGroupOrder := 6;
                        TSubGroupOrder := 7;//CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
                        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                        CoopParameters::none, CurrInstalment);
                        // END
                    END;
                END

                ELSE BEGIN

                    //Added for deployed
                    IF HREmp2."Employee Category" = 'DEPLOYED' THEN BEGIN
                        //MESSAGE('i am deployed');
                        curTaxCharged := curTaxablePay * 0.3;   //transfer this to setup
                        curTransAmount := curTaxCharged;

                        //Added
                        TaxCharged_1 := curTransAmount;
                        //Added

                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAXATION';
                        TGroupOrder := 6;
                        TSubGroupOrder := 7;   //CHANGE tax calculations TO PAYE INFORMATION-HOSEA  // change TGroupOrder :=6 to 7
                        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                        '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none, CurrInstalment);

                    END ELSE BEGIN
                        //Not deployed
                        //  MESSAGE('i am NOT deployed');
                        curTaxCharged := fnGetEmployeePaye(curTaxablePay);
                        curTransAmount := curTaxCharged;
                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAXATION';
                        TGroupOrder := 6;
                        TSubGroupOrder := 7;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA// change TGroupOrder :=6 to 7
                        fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                        CoopParameters::none, CurrInstalment);
                        //Not deployed
                    END;
                END;
            END;



            //Get the Net PAYE amount to post for the month
            IF (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief THEN BEGIN
                IF curTaxCharged > 0 THEN
                    curPAYE := curTaxCharged - curMaximumRelief;
            END ELSE BEGIN
                //******************************************************************************************************************************************
                //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
                //Place a check mark on the Salary Card to YES
                IF (blnInsuranceCertificate) THEN BEGIN
                    curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount) - curReliefMorgage;
                END ELSE BEGIN
                    curPAYE := curTaxCharged - (curReliefPersonal);
                END;

            END;
            IF curPAYE < 0 THEN curPAYE := 0;


            IF NOT blnPaysPaye THEN curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
            curTransAmount := curPAYE;
            IF curPAYE < 0 THEN curTransAmount := 0;
            strTransDescription := 'P.A.Y.E';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 3;
            fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, JournalPostAs::Credit,
             JournalPostingType::"G/L Account", '', CoopParameters::none, CurrInstalment);

            IF ((curReliefPersonal > 0) AND (curPAYE > 0)) THEN BEGIN
                // curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := curReliefPersonal;
                strTransDescription := 'Personal Relief';
                TGroup := 'TAXATION';
                TGroupOrder := 6;
                TSubGroupOrder := 9;//change tax calculations to PAYE INFORMATION -HOSEA // change TGroupOrder :=6 to 7
                fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                 CoopParameters::none, CurrInstalment);
            END;
            //Store the unused relief for the current month
            //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
            IF curPAYE < 0 THEN BEGIN
                // // prUnusedRelief.RESET;
                // // prUnusedRelief.SETRANGE(prUnusedRelief."Employee Code",strEmpCode);
                // // prUnusedRelief.SETRANGE(prUnusedRelief."Period Month",intMonth);
                // // prUnusedRelief.SETRANGE(prUnusedRelief."Period Year",intYear);
                // // IF prUnusedRelief.FIND('-') THEN
                // //    prUnusedRelief.DELETE;
                // //
                // // prUnusedRelief.RESET;
                // // WITH prUnusedRelief DO BEGIN
                // //     INIT;
                // //     "Employee Code" := strEmpCode;
                // //     "Unused Relief" := curPAYE;
                // //     "Period Month" := intMonth;
                // //     "Period Year" := intYear;
                // //     INSERT;
                // //
                // //     curPAYE:=0;
                // // END;
            END;
        END;

        //Deductions: get all deductions for the month
        //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
        //>Balance = (Openning Bal + Deduction)...//Increasing balance
        //>Balance = (Openning Bal - Deduction)...//Reducing balance
        //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance

        // //Get the N.H.I.F amount for the month GBT
        curNhif_Base_Amount := 0;

        IF intNHIF_BasedOn = intNHIF_BasedOn::Gross THEN //>NHIF calculation can be based on
            curNhif_Base_Amount := curGrossPay;
        IF intNHIF_BasedOn = intNHIF_BasedOn::Basic THEN
            curNhif_Base_Amount := curBasicPay;
        IF intNHIF_BasedOn = intNHIF_BasedOn::"Taxable Pay" THEN
            curNhif_Base_Amount := curTaxablePay;

        //commented by hosea to give right NHIF Amount on Payslip
        //curNhif_Base_Amount :=0;
        // curNhif_Base_Amount := curBasicPay;


        IF curGrossPay > 0 THEN BEGIN
            IF blnPaysNhif THEN BEGIN
                curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                strTransDescription := 'N.H.I.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none, CurrInstalment);
            END;
        END;

        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);

        IF prEmployeeTransactions.FIND('-') THEN BEGIN
            curTotalDeductions := 0;
            REPEAT
                prTransactionCodes.RESET;
                prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Deduction);
                IF prTransactionCodes.FIND('-') THEN BEGIN
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';

                    IF prTransactionCodes."Is Formula" THEN BEGIN
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula, CurrInstalment);
                        curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                    END ELSE BEGIN
                        curTransAmount := prEmployeeTransactions.Amount;
                    END;

                    //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                    IF (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Life Insurance")
                      AND (prTransactionCodes."Deduct Premium" = FALSE) THEN BEGIN
                        curTransAmount := 0;
                    END;

                    //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                    IF (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::Morgage)
                     AND (prTransactionCodes."Deduct Mortgage" = FALSE) THEN BEGIN
                        curTransAmount := 0;
                    END;
                    // Pension
                    IF (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Defined Contribution") THEN
                        IF prTransactionCodes.Pension = TRUE THEN
                         //AND (prTransactionCodes."Deduct Mortgage"=FALSE) THEN
                         BEGIN
                            curTransAmount := (0.03 * curBasicPay);//-curNSSF;
                            fnUpdateEmployerDeductions(strEmpCode, prTransactionCodes."Transaction Code",
                    'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                     prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, CurrInstalment);
                        END;

                    //Get the posting Details
                    JournalPostingType := JournalPostingType::" ";
                    JournalAcc := '';
                    IF prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " THEN BEGIN
                        IF prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer THEN BEGIN
                            Customer.RESET;
                            HrEmployee.GET(strEmpCode);
                            Customer.RESET;
                            //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                            //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                            IF prTransactionCodes.CustomerPostingGroup <> '' THEN
                                Customer.SETRANGE(Customer."Customer Posting Group", prTransactionCodes.CustomerPostingGroup);

                            Customer.SETRANGE(Customer."No.", HrEmployee."No.");
                            IF Customer.FIND('-') THEN BEGIN
                                JournalAcc := Customer."No.";
                                JournalPostingType := JournalPostingType::Customer;
                            END;
                        END;
                    END ELSE BEGIN
                        JournalAcc := prTransactionCodes."GL Account";
                        JournalPostingType := JournalPostingType::"G/L Account";
                    END;

                    //End posting Details


                    //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                    IF (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") AND
                       (prTransactionCodes."Repayment Method" = prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN
                        curTransAmount := 0;
                        curLoanInt := 0;
                        curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                        prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
                           prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, FALSE);
                        //Post the Interest
                        IF (curLoanInt <> 0) THEN BEGIN
                            curTransAmount := curLoanInt;
                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransBalance := 0;
                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 1;  //change other deductions to deductions-hosea //change group from 8 to 6 and subgroup from 1 to 12-hosea
                            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                              JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                              CoopParameters::"loan Interest", CurrInstalment)
                        END;
                        //Get the Principal Amt
                        curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
                        //Modify PREmployeeTransaction Table
                        prEmployeeTransactions.Amount := curTransAmount;
                        prEmployeeTransactions.MODIFY;
                    END;
                    //Loan Calculation Amortized

                    CASE prTransactionCodes."Balance Type" OF //[0=None, 1=Increasing, 2=Reducing]
                        prTransactionCodes."Balance Type"::None:
                            curTransBalance := 0;
                        prTransactionCodes."Balance Type"::Increasing:
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        prTransactionCodes."Balance Type"::Reducing:
                            BEGIN
                                //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                IF prEmployeeTransactions.Balance < prEmployeeTransactions.Amount THEN BEGIN
                                    curTransAmount := prEmployeeTransactions.Balance;
                                    curTransBalance := 0;
                                END ELSE BEGIN
                                    curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                END;
                                IF curTransBalance < 0 THEN BEGIN
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                END;
                            END
                    END;

                    curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                    curTransAmount := curTransAmount;
                    curTransBalance := curTransBalance;
                    strTransDescription := prTransactionCodes."Transaction Name";
                    TGroup := 'DEDUCTIONS';
                    TGroupOrder := 8;
                    TSubGroupOrder := 13; //change other deductions to deductions-hosea // change TGroupOrder :=8 to 6
                    fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                     strTransDescription, curTransAmount, curTransBalance, intMonth,
                     intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                     JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                     prTransactionCodes."coop parameters", CurrInstalment);

                    //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                    IF (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") AND
                       (prTransactionCodes."Repayment Method" <> prTransactionCodes."Repayment Method"::Amortized) THEN BEGIN

                        curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                       prTransactionCodes."Interest Rate",
                        prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                        prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);
                        IF curLoanInt > 0 THEN BEGIN
                            curTransAmount := curLoanInt;
                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransBalance := 0;
                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 14;   //change other deductions to deductions-hosea // change TGroupOrder :=8 to 6
                            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                              JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                              CoopParameters::"loan Interest", CurrInstalment)
                        END;
                    END;
                    //End Loan transaction calculation
                    //Fringe Benefits and Low interest Benefits
                    IF prTransactionCodes."Fringe Benefit" = TRUE THEN BEGIN
                        IF prTransactionCodes."Interest Rate" < curLoanMarketRate THEN BEGIN
                            fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                             * prEmployeeTransactions.Balance;
                        END;
                    END ELSE BEGIN
                        fnCalcFringeBenefit := 0;
                    END;
                    IF fnCalcFringeBenefit > 0 THEN BEGIN
                        fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                         'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, CurrInstalment)

                    END;
                    //End Fringe Benefits

                    //Create Employer Deduction
                    IF (prTransactionCodes."Employer Deduction") OR (prTransactionCodes."Include Employer Deduction") THEN BEGIN
                        IF prTransactionCodes."Is Formula for employer" <> '' THEN BEGIN
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer", CurrInstalment);
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                        END ELSE BEGIN
                            curTransAmount := prEmployeeTransactions."Employer Amount";
                        END;
                        IF curTransAmount > 0 THEN
                            fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                             'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, CurrInstalment);

                        //Added to for employee plus employer contributions NCA
                        //Update Balance on PR Period Transaction Table with Pension Contributed from Employer
                        PRPeriodTrans.RESET;
                        PRPeriodTrans.SETRANGE(PRPeriodTrans."Employee Code", strEmpCode);
                        PRPeriodTrans.SETRANGE(PRPeriodTrans."Transaction Code", prEmployeeTransactions."Transaction Code");
                        PRPeriodTrans.SETRANGE(PRPeriodTrans."Payroll Period", SelectedPeriod);
                        IF PRPeriodTrans.FIND('-') THEN BEGIN
                            IF PRPeriodTrans.Balance <> 0 THEN PRPeriodTrans.Balance += curTransAmount;
                            PRPeriodTrans.MODIFY;
                        END;
                        //Added to for employee plus employer contributions NCA




                    END;
                    //Employer deductions

                END;

            UNTIL prEmployeeTransactions.NEXT = 0;
            //GET TOTAL DEDUCTIONS

            //Added for NCA - To add Statutories to Total Deductions
            TotalSTATUTORIES := 0;
            PRPeriod.RESET;
            PRPeriod.SETRANGE(PRPeriod."Payroll Period", SelectedPeriod);
            PRPeriod.SETRANGE(PRPeriod."Employee Code", strEmpCode);
            PRPeriod.SETRANGE("Current Instalment", PrlPeriods."Current Instalment");
            PRPeriod.SETFILTER(PRPeriod."Group Text", '=%1', 'STATUTORIES|DEDUCTIONS'); //cHANGE STATUTORY DEDUCTIONS TO STATUTORIES-HOSEA
            IF PRPeriod.FIND('-') THEN BEGIN
                REPEAT
                    TotalSTATUTORIES += PRPeriod.Amount;
                UNTIL PRPeriod.NEXT = 0;
            END;
            //Added for NCA - To add Statutories to Total Deductions
            curTransBalance := 0;
            strTransCode := 'TOT-DED';
            strTransDescription := 'TOTAL DEDUCTIONS';
            TGroup := 'DEDUCTION SUMMARY';
            TGroupOrder := 8;
            TSubGroupOrder := 15;//change other deductions to deductions-hosea // change TGroupOrder :=6 to 8
            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
              strTransDescription, (TotalSTATUTORIES), curTransBalance, intMonth, intYear,
              // (curTotalDeductions+TotalSTATUTORIES-curTotalDeductions), curTransBalance, intMonth, intYear, //ADD -curTotalDeductions -HOSEA
              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
              '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none, CurrInstalment)

            //END GET TOTAL DEDUCTIONS
        END;

        //Net Pay: calculate the Net pay for the month in the following manner:
        //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
        //...Tot Deductions also include (SumLoan + SumInterest)
        curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit);

        //>Nett = Nett - curExcessPension
        //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
        curNetPay := curNetPay; //- curExcessPension

        //>Nett = Nett - cSumEmployerDeductions
        //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
        curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

        curNetRnd_Effect := curNetPay - ROUND(curNetPay);
        curTransAmount := curNetPay;
        strTransDescription := 'Net Pay';
        TGroup := 'NET PAY';
        TGroupOrder := 9;
        TSubGroupOrder := 0;

        fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
        PayablesAcc, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none, CurrInstalment);

        //Rounding Effect: if the Net pay is rounded, take the rounding effect &
        //save it as an earning for the staff for the next month
        //>Insert the Netpay rounding effect into the tblRoundingEffect table


        //Negative pay: if the NetPay<0 then log the entry
        //>Display an on screen report
        //>Through a pop-up to the user
        //>Send an email to the user or manager
        //END

        //END;
        //END; !!!!!!!!!

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary);
    end;


    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record 2000000007;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := DATE2DMY(TodayDate, 1);
        Expr1 := FORMAT(-Day) + 'D+1D';
        FirstDay := CALCDATE(Expr1, TodayDate);
        LastDate := CALCDATE('1M-1D', FirstDay);

        SysDate.RESET;
        SysDate.SETRANGE(SysDate."Period Type", SysDate."Period Type"::Date);
        SysDate.SETRANGE(SysDate."Period Start", FirstDay, LastDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        IF SysDate.FIND('-') THEN
            DaysInMonth := SysDate.COUNT;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension; currentInstalment: Integer)
    var
        prPeriodTransactions: Record 70252;
        prSalCard: Record "HRM-Employee (D)";
    begin
        IF (((TCode = 'PAYE') OR (TCode = 'P.A.Y.E')) AND (EmpCode = '22414741')) THEN
            curAmount := curAmount;
        IF curAmount = 0 THEN EXIT;
        prPeriodTransactions.INIT;
        prPeriodTransactions."Employee Code" := EmpCode;
        prPeriodTransactions."Transaction Code" := TCode;
        prPeriodTransactions."Current Instalment" := currentInstalment;
        prPeriodTransactions."Group Text" := TGroup;
        prPeriodTransactions."Transaction Name" := Description;
        prPeriodTransactions.Amount := ROUND(curAmount);
        prPeriodTransactions.Balance := curBalance;
        prPeriodTransactions."Original Amount" := prPeriodTransactions.Balance;
        prPeriodTransactions."Group Order" := GroupOrder;
        prPeriodTransactions."Sub Group Order" := SubGroupOrder;
        prPeriodTransactions.Membership := mMembership;
        prPeriodTransactions."Reference No" := ReferenceNo;
        prPeriodTransactions."Period Month" := Month;
        prPeriodTransactions."Period Year" := Year;
        prPeriodTransactions."Payroll Period" := dtOpenPeriod;
        prPeriodTransactions."Department Code" := Department;
        prPeriodTransactions."Journal Account Type" := JournalACType;
        prPeriodTransactions."Post As" := PostAs;
        prPeriodTransactions."Journal Account Code" := JournalAC;
        prPeriodTransactions."Loan Number" := LoanNo;
        prPeriodTransactions."coop parameters" := CoopParam;
        prPeriodTransactions."Payroll Code" := PayrollType;
        //Paymode
        IF prSalCard.GET(EmpCode) THEN
            prPeriodTransactions."Payment Mode" := prSalCard."Payment Mode";
        prPeriodTransactions.INSERT;
        //Update the prEmployee Transactions  with the Amount
        fnUpdateEmployeeTrans(prPeriodTransactions."Employee Code", prPeriodTransactions."Transaction Code", prPeriodTransactions.Amount, prPeriodTransactions."Period Month", prPeriodTransactions."Period Year", prPeriodTransactions."Payroll Period");
    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Allowance Recovery"; blnCompDedc: Boolean; currInstalment: Integer) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record 70251;
        prTransactionCodes: Record 61082;
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.RESET;
        prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions", intSpecTransID);
        IF prTransactionCodes.FIND('-') THEN BEGIN
            REPEAT
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended, FALSE);
                prEmployeeTransactions.SETRANGE("Current Instalment", currInstalment);
                IF prEmployeeTransactions.FIND('-') THEN BEGIN

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    CASE intSpecTransID OF
                        intSpecTransID::"Defined Contribution":
                            IF prTransactionCodes."Is Formula" THEN BEGIN
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula, currInstalment);
                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            END ELSE
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::"Allowance Recovery":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        intSpecTransID::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        intSpecTransID::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        intSpecTransID::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::Gratuity:
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount * 0.3;

                        intSpecTransID::"Insurance Relief":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::Morgage:
                            BEGIN
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                IF SpecialTransAmount > curReliefMorgage THEN BEGIN
                                    SpecialTransAmount := curReliefMorgage
                                END;

                            END;

                    END;
                END;
            UNTIL prTransactionCodes.NEXT = 0;
        END;
        //SpecialTranAmount:=SpecialTransAmount;
    end;


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record 61076;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.RESET;
        IF prPAYE.FINDFIRST THEN BEGIN
            IF curTaxablePay < prPAYE."PAYE Tier" THEN EXIT;
            REPEAT
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                IF curTaxablePay = 0 THEN EXIT;
                IF KeepCount = prPAYE.COUNT THEN   //this is the last record or loop
                    curTaxablePay := curTempAmount
                ELSE
                    IF curTempAmount >= prPAYE."PAYE Tier" THEN
                        curTempAmount := prPAYE."PAYE Tier"
                    ELSE
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;

            UNTIL prPAYE.NEXT = 0;
        END;
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record 61075;
    begin
        prNHIF.RESET;
        prNHIF.SETCURRENTKEY(prNHIF."Tier Code");
        IF prNHIF.FINDFIRST THEN BEGIN
            REPEAT
                IF ((curBaseAmount >= prNHIF."Lower Limit") AND (curBaseAmount <= prNHIF."Upper Limit")) THEN
                    NHIF := prNHIF.Amount;
            UNTIL prNHIF.NEXT = 0;
        END;
    end;


    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]; CurrInstalment: Integer) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record 85;
        ColumnLayout: Record 334;
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit 8;
    begin
        TransCode := '';
        FOR i := 1 TO STRLEN(strFormula) DO BEGIN
            Char := COPYSTR(strFormula, i, 1);
            IF Char = '[' THEN StartCopy := TRUE;

            IF StartCopy THEN TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            IF NOT StartCopy THEN
                FinalFormula := FinalFormula + Char;
            IF Char = ']' THEN BEGIN
                StartCopy := FALSE;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DELCHR(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear, CurrInstalment);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + FORMAT(TransCodeAmount);
                //End Get Transcode
            END;
        END;
        Formula := FinalFormula;
    end;


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer; CurrentInstal: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record 70252;
        prPeriodTransactions: Record 70251;
    begin
        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code", strTransCode);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
        prEmployeeTransactions.SETRANGE("Current Instalment", CurrentInstal);
        IF prEmployeeTransactions.FINDFIRST THEN BEGIN

            TransAmount := prEmployeeTransactions.Amount;
            // IF prEmployeeTransactions."No of Units"<>0 THEN
            // TransAmount:=prEmployeeTransactions."No of Units";

        END;
        IF TransAmount = 0 THEN BEGIN
            prPeriodTransactions.RESET;
            prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code", strEmpCode);
            prPeriodTransactions.SETRANGE(prPeriodTransactions."Transaction Code", strTransCode);
            prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Month", intMonth);
            prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Year", intYear);
            prPeriodTransactions.SETRANGE("Current Instalment", CurrentInstal);
            IF prPeriodTransactions.FINDFIRST THEN
                TransAmount := prPeriodTransactions.Amount;
        END;
    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record 85;
        ColumnLayout: Record 334;
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit 8;
    begin
        //Results := AccSchedMgt.EvaluateExpression(TRUE, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]; CurrentInstallment: Integer) Closed: Boolean
    var
        dtOldPeriod: Date;
        intNewMonth: Integer;
        dtNewPeriod: Date;
        intOldMonth: Integer;
        intNewYear: Integer;
        intOldYear: Integer;
        prEmployeeTransactions: Record 70251;
        prPeriodTransactions: Record 70252;
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record 61082;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record 70251;
        prPayrollPeriods: Record 70250;
        prNewPayrollPeriods: Record 70250;
        CreateTrans: Boolean;
        ControlInfo: Record 61119;
        prsalCard3: Record 70200;
        prsalCard: Record 70200;
        NextCurrInstalment: Integer;
    begin
        ControlInfo.GET();
        CLEAR(NextCurrInstalment);

        PrlPeriods.RESET;
        PrlPeriods.SETRANGE("Date Openned", dtOpenPeriod);
        PrlPeriods.SETRANGE("Current Instalment", CurrentInstallment);
        IF PrlPeriods.FIND('-') THEN BEGIN
            IF (PrlPeriods."No. of Instalments" < CurrentInstallment) THEN
                NextCurrInstalment := CurrentInstallment + 1
            ELSE
                NextCurrInstalment := 1;
        END;

        IF NextCurrInstalment = 1 THEN BEGIN
            dtNewPeriod := CALCDATE('1M', dtOpenPeriod);
        END ELSE
            IF NextCurrInstalment > 1 THEN BEGIN
                dtNewPeriod := dtOpenPeriod;
            END;
        intNewMonth := DATE2DMY(dtNewPeriod, 2);
        intNewYear := DATE2DMY(dtNewPeriod, 3);
        intOldMonth := DATE2DMY(dtOpenPeriod, 2);
        intOldYear := DATE2DMY(dtOpenPeriod, 3);

        intMonth := DATE2DMY(dtOpenPeriod, 2);
        intYear := DATE2DMY(dtOpenPeriod, 3);

        prEmployeeTransactions.RESET;
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
        prEmployeeTransactions.SETRANGE("Current Instalment", CurrentInstallment);

        //Multiple Payroll
        IF ControlInfo."Multiple Payroll" THEN BEGIN
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Payroll Code", PayrollCode);
        END;

        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",'KPSS091');


        IF prEmployeeTransactions.FIND('-') THEN BEGIN
            REPEAT
                prTransactionCodes.RESET;
                prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                IF prTransactionCodes.FIND('-') THEN BEGIN
                    CASE prTransactionCodes."Balance Type" OF
                        prTransactionCodes."Balance Type"::None:
                            BEGIN
                                curTransAmount := prEmployeeTransactions.Amount;
                                curTransBalance := 0;
                            END;
                        prTransactionCodes."Balance Type"::Increasing:
                            BEGIN
                                curTransAmount := prEmployeeTransactions.Amount;
                                curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                            END;
                        prTransactionCodes."Balance Type"::Reducing:
                            BEGIN
                                curTransAmount := prEmployeeTransactions.Amount;
                                IF prEmployeeTransactions.Balance < prEmployeeTransactions.Amount THEN BEGIN
                                    curTransAmount := prEmployeeTransactions.Balance;
                                    curTransBalance := 0;
                                END ELSE BEGIN
                                    curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                END;
                                IF curTransBalance < 0 THEN BEGIN
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                END;
                            END;
                    END;
                END;

                //For those transactions with Start and End Date Specified
                IF (prEmployeeTransactions."Start Date" <> 0D) AND (prEmployeeTransactions."End Date" <> 0D) THEN BEGIN
                    IF prEmployeeTransactions."End Date" < dtNewPeriod THEN BEGIN
                        curTransAmount := 0;
                        curTransBalance := 0;
                    END;
                END;
                //End Transactions with Start and End Date

                IF (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) AND
                   (prEmployeeTransactions."Stop for Next Period" = FALSE) THEN //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                 BEGIN
                    IF (curTransAmount <> 0) THEN  //Update the employee transaction table
                     BEGIN
                        IF ((prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing) AND (curTransBalance <> 0)) OR
                         (prTransactionCodes."Balance Type" <> prTransactionCodes."Balance Type"::Reducing) THEN
                            prEmployeeTransactions.Balance := curTransBalance;
                        prEmployeeTransactions.MODIFY;

                        //Insert record for the next period
                        IF (prEmployeeTransactions."Transaction Code" <> 'D066') THEN
                            IF (prEmployeeTransactions."Transaction Code" <> 'P021') THEN BEGIN
                                prEmployeeTrans.INIT;
                                prEmployeeTrans."Employee Code" := prEmployeeTransactions."Employee Code";
                                prEmployeeTrans."Current Instalment" := NextCurrInstalment;
                                prEmployeeTrans."Transaction Code" := prEmployeeTransactions."Transaction Code";
                                prEmployeeTrans."Transaction Name" := prEmployeeTransactions."Transaction Name";
                                prEmployeeTrans.Amount := curTransAmount;
                                prEmployeeTrans.Balance := curTransBalance;
                                prEmployeeTrans."Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
                                prEmployeeTrans."Original Amount" := prEmployeeTransactions."Original Amount";
                                prEmployeeTrans.Membership := prEmployeeTransactions.Membership;
                                prEmployeeTrans."Reference No" := prEmployeeTransactions."Reference No";
                                prEmployeeTrans."Loan Number" := prEmployeeTransactions."Loan Number";
                                prEmployeeTrans."Period Month" := intNewMonth;
                                prEmployeeTrans."Period Year" := intNewYear;
                                prEmployeeTrans."Payroll Period" := dtNewPeriod;
                                prEmployeeTrans."Payroll Code" := PayrollCode;
                                prEmployeeTrans."Recurance Index" := prEmployeeTransactions."Recurance Index" - 1;
                                // Insert only if the counter for the frequnency is not 0
                                IF (prEmployeeTransactions."Recurance Index" - 1) > 0 THEN
                                    prEmployeeTrans.INSERT;
                            END;
                    END;
                END
            UNTIL prEmployeeTransactions.NEXT = 0;
        END;
        prsalCard.RESET;
        prsalCard.SETRANGE(prsalCard."Payroll Period", dtOpenPeriod);
        IF prsalCard.FIND('-') THEN BEGIN
            REPEAT
            BEGIN

                // HrEmployee.RESET;
                //  HrEmployee.SETRANGE("No.",prsalCard."Employee Code");
                //  IF

                prsalCard3.RESET;
                IF NOT (prsalCard3.GET(prsalCard."Employee Code", dtNewPeriod, NextCurrInstalment)) THEN BEGIN // Insert the Basic salary details for the current Month
                    prsalCard3.INIT;
                    prsalCard3."Employee Code" := prsalCard."Employee Code";
                    prsalCard3."Current Instalment" := NextCurrInstalment;
                    prsalCard3."Days Worked" := 0;
                    prsalCard3."Period Month" := intNewMonth;
                    prsalCard3."Period Year" := intNewYear;
                    prsalCard3."Payroll Period" := dtNewPeriod;
                    prsalCard3."Daily Rate" := prsalCard."Daily Rate";
                    prsalCard3.INSERT;
                END;

            END;
            UNTIL prsalCard.NEXT = 0;
        END;


        //END;

        //Update the Period as Closed
        prPayrollPeriods.RESET;
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SETRANGE(prPayrollPeriods."Current Instalment", CurrentInstallment);
        prPayrollPeriods.SETRANGE(prPayrollPeriods.Closed, FALSE);
        //IF ControlInfo."Multiple Payroll" THEN
        // prPayrollPeriods.SETRANGE(prPayrollPeriods."Payroll Code",PayrollCode);

        IF prPayrollPeriods.FIND('-') THEN BEGIN
            prPayrollPeriods.Closed := TRUE;
            prPayrollPeriods."Closed By" := USERID;
            prPayrollPeriods."Date Closed" := TODAY;
            prPayrollPeriods.MODIFY;
        END;

        //Enter a New Period
        prNewPayrollPeriods.INIT;
        prNewPayrollPeriods."Period Month" := intNewMonth;
        prNewPayrollPeriods."Period Year" := intNewYear;
        prNewPayrollPeriods."Period Name" := FORMAT(dtNewPeriod, 0, '<Month Text>') + ' - ' + FORMAT(intNewYear);
        prNewPayrollPeriods."Date Openned" := dtNewPeriod;
        prNewPayrollPeriods."No. of Instalments" := prPayrollPeriods."No. of Instalments";
        prNewPayrollPeriods."No of Days" := prPayrollPeriods."No of Days";
        prNewPayrollPeriods."Payslip Message" := prPayrollPeriods."Payslip Message";
        prNewPayrollPeriods."Current Instalment" := NextCurrInstalment;
        prNewPayrollPeriods.Closed := FALSE;
        //"Payroll Code":=PayrollCode;
        prNewPayrollPeriods.INSERT;
        //Effect the transactions for the P9
        //fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod,PayrollCode);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        //fnGetNegativePay(intMonth, intYear,dtOpenPeriod);
    end;


    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record 70252;
        prEmployeeTransactions: Record 70251;
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CALCDATE('1M', dtOpenPeriod);
        intNewMonth := DATE2DMY(dtNewPeriod, 2);
        intNewYear := DATE2DMY(dtNewPeriod, 3);

        prPeriodTransactions.RESET;
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SETRANGE(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SETFILTER(prPeriodTransactions.Amount, '<0');

        IF prPeriodTransactions.FIND('-') THEN BEGIN
            REPEAT
                prEmployeeTransactions.INIT;
                prEmployeeTransactions."Employee Code" := prPeriodTransactions."Employee Code";
                prEmployeeTransactions."Transaction Code" := 'NEGP';
                prEmployeeTransactions."Transaction Name" := 'Negative Pay';
                prEmployeeTransactions.Amount := prPeriodTransactions.Amount;
                prEmployeeTransactions.Balance := 0;
                prEmployeeTransactions."Original Amount" := 0;
                prEmployeeTransactions."Period Month" := intNewMonth;
                prEmployeeTransactions."Period Year" := intNewYear;
                prEmployeeTransactions."Payroll Period" := dtNewPeriod;
                prEmployeeTransactions.INSERT;
            UNTIL prPeriodTransactions.NEXT = 0;
        END;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record 70252;
        prEmployee: Record "HRM-Employee (D)";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.RESET;
        prEmployee.SETRANGE(prEmployee.Status, prEmployee.Status::Active);
        IF prEmployee.FIND('-') THEN BEGIN
            REPEAT

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.RESET;
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code", prEmployee."No.");
                IF prPeriodTransactions.FIND('-') THEN BEGIN
                    REPEAT
                        CASE prPeriodTransactions."Group Order" OF
                            1: //Basic pay & Arrears
                                BEGIN
                                    IF prPeriodTransactions."Sub Group Order" = 1 THEN P9BasicPay := prPeriodTransactions.Amount; //Basic Pay
                                    IF prPeriodTransactions."Sub Group Order" = 2 THEN P9BasicPay := P9BasicPay + prPeriodTransactions.Amount; //Basic Pay Arrears
                                END;
                            3:  //Allowances
                                BEGIN
                                    P9Allowances := P9Allowances + prPeriodTransactions.Amount
                                END;
                            4: //Gross Pay
                                BEGIN
                                    P9GrossPay := prPeriodTransactions.Amount
                                END;
                            6: //Taxation
                                BEGIN
                                    IF prPeriodTransactions."Sub Group Order" = 1 THEN P9DefinedContribution := prPeriodTransactions.Amount; //Defined Contribution
                                    IF prPeriodTransactions."Sub Group Order" = 9 THEN P9TaxRelief := prPeriodTransactions.Amount; //Tax Relief
                                    IF prPeriodTransactions."Sub Group Order" = 8 THEN P9InsuranceRelief := prPeriodTransactions.Amount; //Insurance Relief
                                    IF prPeriodTransactions."Sub Group Order" = 6 THEN P9TaxablePay := prPeriodTransactions.Amount; //Taxable Pay
                                    IF prPeriodTransactions."Sub Group Order" = 7 THEN P9TaxCharged := prPeriodTransactions.Amount; //Tax Charged
                                END;
                            7: //Statutories
                                BEGIN
                                    IF prPeriodTransactions."Sub Group Order" = 1 THEN P9NSSF := prPeriodTransactions.Amount; //Nssf
                                    IF prPeriodTransactions."Sub Group Order" = 2 THEN P9NHIF := prPeriodTransactions.Amount; //Nhif
                                    IF prPeriodTransactions."Sub Group Order" = 3 THEN P9Paye := prPeriodTransactions.Amount; //paye
                                    IF prPeriodTransactions."Sub Group Order" = 4 THEN P9Paye := P9Paye + prPeriodTransactions.Amount; //Paye Arrears
                                END;
                            8://Deductions
                                BEGIN
                                    P9Deductions := P9Deductions + prPeriodTransactions.Amount;
                                END;
                            9: //NetPay
                                BEGIN
                                    P9NetPay := prPeriodTransactions.Amount;
                                END;
                        END;
                    UNTIL prPeriodTransactions.NEXT = 0;
                END;
                //Update the P9 Details

                IF P9NetPay <> 0 THEN
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            UNTIL prEmployee.NEXT = 0;
        END;
    end;


    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record 61093;
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := DATE2DMY(dtCurrPeriod, 2);
        intYear := DATE2DMY(dtCurrPeriod, 3);

        prEmployeeP9Info.RESET;
        prEmployeeP9Info.SETRANGE(prEmployeeP9Info."Payroll Period", dtCurrPeriod);
        prEmployeeP9Info.SETRANGE(prEmployeeP9Info."Employee Code", P9EmployeeCode);
        prEmployeeP9Info.SETRANGE(prEmployeeP9Info."Period Month", intMonth);
        prEmployeeP9Info.SETRANGE(prEmployeeP9Info."Period Year", intYear);
        prEmployeeP9Info.SETRANGE(prEmployeeP9Info."Payroll Code", prPayrollCode);
        IF prEmployeeP9Info.FIND('-') THEN prEmployeeP9Info.DELETE;
        prEmployeeP9Info.INIT;
        prEmployeeP9Info."Employee Code" := P9EmployeeCode;
        prEmployeeP9Info."Basic Pay" := P9BasicPay;
        prEmployeeP9Info.Allowances := P9Allowances;
        prEmployeeP9Info.Benefits := P9Benefits;
        prEmployeeP9Info."Value Of Quarters" := P9ValueOfQuarters;
        prEmployeeP9Info."Defined Contribution" := P9DefinedContribution;
        prEmployeeP9Info."Owner Occupier Interest" := P9OwnerOccupierInterest;
        prEmployeeP9Info."Gross Pay" := P9GrossPay;
        prEmployeeP9Info."Taxable Pay" := P9TaxablePay;
        prEmployeeP9Info."Tax Charged" := P9TaxCharged;
        prEmployeeP9Info."Insurance Relief" := P9InsuranceRelief;
        prEmployeeP9Info."Tax Relief" := P9TaxRelief;
        prEmployeeP9Info.PAYE := P9Paye;
        prEmployeeP9Info.NSSF := P9NSSF;
        prEmployeeP9Info.NHIF := P9NHIF;
        prEmployeeP9Info.Deductions := P9Deductions;
        prEmployeeP9Info."Net Pay" := P9NetPay;
        prEmployeeP9Info."Period Month" := intMonth;
        prEmployeeP9Info."Period Year" := intYear;
        prEmployeeP9Info."Payroll Period" := dtCurrPeriod;
        prEmployeeP9Info."Payroll Code" := prPayrollCode;
        prEmployeeP9Info.INSERT;
    end;


    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record 2000000007;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := DATE2DMY(TodayDate, 1);
        Expr1 := FORMAT(-Day) + 'D+1D';
        FirstDay := CALCDATE(Expr1, TodayDate);
        LastDate := CALCDATE('1M-1D', FirstDay);

        SysDate.RESET;
        SysDate.SETRANGE(SysDate."Period Type", SysDate."Period Type"::Date);
        IF NOT IsTermination THEN
            SysDate.SETRANGE(SysDate."Period Start", dtDate, LastDate)
        ELSE
            SysDate.SETRANGE(SysDate."Period Start", FirstDay, dtDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        IF SysDate.FIND('-') THEN
            DaysWorked := SysDate.COUNT;
    end;


    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record 61093;
        P9BasicPay: Decimal;
        P9taxablePay: Decimal;
        P9PAYE: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPAYE: Decimal;
        PAYEVariance: Decimal;
        PAYEArrears: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
    begin
        fnInitialize;

        FirstMonth := TRUE;
        IF EndDate > StartDate THEN BEGIN
            WHILE StartDate < EndDate DO BEGIN
                //fnGetEmpP9Info
                startmonth := DATE2DMY(StartDate, 2);
                startYear := DATE2DMY(StartDate, 3);

                "prEmployee P9 Info".RESET;
                "prEmployee P9 Info".SETRANGE("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SETRANGE("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SETRANGE("prEmployee P9 Info"."Period Year", startYear);
                IF "prEmployee P9 Info".FIND('-') THEN BEGIN
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    IF P9BasicPay > 0 THEN   //Staff payment history is available
                     BEGIN
                        IF FirstMonth THEN BEGIN                 //This is the first month in the arrears loop
                            IF DATE2DMY(StartDate, 1) <> 1 THEN //if the date doesn't start on 1st, we have to prorate the salary
                             BEGIN
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                IF (DATE2DMY(dtDOE, 2) = DATE2DMY(StartDate, 2)) AND (DATE2DMY(dtDOE, 3) = DATE2DMY(StartDate, 3)) THEN BEGIN
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, FALSE);
                                    ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                END;

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                /*   IF dtTermination<>0D THEN BEGIN
                                   IF (DATE2DMY(dtTermination,2)=DATE2DMY(StartDate,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(StartDate,3))THEN BEGIN
                                       CountDaysofMonth:=fnDaysInMonth(dtTermination);
                                       DaysWorked:=fnDaysWorked(dtTermination,TRUE);
                                       ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay,DaysWorked,CountDaysofMonth)
                                   END;
                                 END;*/

                                SalaryArrears := (CBasic - ProratedBasic)
                            END
                            ELSE BEGIN
                                SalaryArrears := (CBasic - P9BasicPay);
                            END;
                        END;
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        IF SupposedTaxablePay > P9taxablePay THEN BEGIN
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        END;
                        FirstMonth := FALSE;               //reset the FirstMonth Boolean to False
                    END;
                END;
                StartDate := CALCDATE('+1M', StartDate);
            END;
            IF SalaryArrears <> 0 THEN BEGIN
                PeriodYear := DATE2DMY(dtOpenPeriod, 3);
                PeriodMonth := DATE2DMY(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            END

        END
        ELSE
            ERROR('The start date must be earlier than the end date');

    end;


    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        FirstMonth: Boolean;
        ProratedBasic: Decimal;
        SalaryVariance: Decimal;
        PayeVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPaye: Decimal;
        CurrentBasic: Decimal;
        StartDate: Date;
        "prSalary Arrears": Record 61088;
    begin
        "prSalary Arrears".RESET;
        "prSalary Arrears".SETRANGE("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SETRANGE("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SETRANGE("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SETRANGE("prSalary Arrears"."Period Year", intYear);
        IF "prSalary Arrears".FIND('-') = FALSE THEN BEGIN
            "prSalary Arrears".INIT;
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".INSERT;
        END
    end;


    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := DATE2DMY(CurrPeriod, 2);
        intYear := DATE2DMY(CurrPeriod, 3);

        curLoanInt := 0;



        IF InterestRate > 0 THEN BEGIN
            IF RecoveryMethod = RecoveryMethod::"Straight line" THEN //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            IF RecoveryMethod = RecoveryMethod::Reducing THEN //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            IF RecoveryMethod = RecoveryMethod::Amortized THEN //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;
        END ELSE
            curLoanInt := 0;

        //Return the Amount
        LnInterest := ROUND(curLoanInt);
    end;


    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; currentInstalments: Integer)
    var
        prEmployerDeductions: Record 70253;
    begin

        IF curAmount = 0 THEN EXIT;
        IF NOT prEmployerDeductions.GET(EmpCode, TCode, Month, Year, dtOpenPeriod, currentInstalments) THEN BEGIN

            prEmployerDeductions.INIT;
            prEmployerDeductions."Employee Code" := EmpCode;
            prEmployerDeductions."Current Instalment" := currentInstalments;
            prEmployerDeductions."Transaction Code" := TCode;
            prEmployerDeductions.Amount := curAmount;
            prEmployerDeductions."Period Month" := Month;
            prEmployerDeductions."Period Year" := Year;
            prEmployerDeductions."Payroll Period" := dtOpenPeriod;
            prEmployerDeductions.INSERT;
        END ELSE BEGIN

            //"Employee Code" := EmpCode;
            //"Transaction Code" := TCode;
            prEmployerDeductions.Amount := curAmount;
            //"Period Month" := Month;
            //"Period Year" := Year;
            //"Payroll Period" := dtOpenPeriod;
            prEmployerDeductions.MODIFY;
        END;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        // pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        // curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
        prEmployeeTrans: Record 70251;
    begin
        /* prEmployeeTrans.RESET;
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Employee Code",EmpCode);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Month",Month);
         prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Year",Year);
         IF prEmployeeTrans.FIND('-') THEN BEGIN
           prEmployeeTrans.Amount:=Amount;
           prEmployeeTrans.MODIFY;
         END; */

    end;


    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "HRM-Employee (D)";
    begin
        //Get Payroll Posting Accounts
        IF SalaryCard.GET(strEmpCode) THEN BEGIN
            IF PostingGroup.GET(SalaryCard."Posting Group") THEN BEGIN
                //Comment This for the Time Being

                PostingGroup.TESTFIELD("Salary Account");
                PostingGroup.TESTFIELD("Income Tax Account");
                PostingGroup.TESTFIELD("Net Salary Payable");
                PostingGroup.TESTFIELD("NSSF Employer Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."NSSF Employer Account";
                NSSFEMPyee := PostingGroup."NSSF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
            END ELSE BEGIN
                ERROR('Please specify Posting Group in Employee No.  ' + strEmpCode);
            END;
        END;
        //End Get Payroll Posting Accounts
    end;


    procedure fnGetSpecialTransAmount2(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean; currentInstalments: Integer)
    var
        prEmployeeTransactions: Record 70251;
        prTransactionCodes: Record 61082;
        strExtractedFrml: Text[250];
    begin
        SpecialTranAmount := 0;
        prTransactionCodes.RESET;
        prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions", intSpecTransID);
        IF prTransactionCodes.FIND('-') THEN BEGIN
            REPEAT
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SETRANGE("Current Instalment", currentInstalments);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended, FALSE);
                IF prEmployeeTransactions.FIND('-') THEN BEGIN

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    CASE intSpecTransID OF
                        intSpecTransID::"Defined Contribution":
                            IF prTransactionCodes."Is Formula" THEN BEGIN
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula, currentInstalments);
                                SpecialTranAmount := SpecialTranAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            END ELSE
                                SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::"Life Insurance":
                            SpecialTranAmount := SpecialTranAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        intSpecTransID::"Owner Occupier Interest":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;


                        intSpecTransID::"Home Ownership Savings Plan":
                            SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::Morgage:
                            BEGIN
                                SpecialTranAmount := SpecialTranAmount + curReliefMorgage;

                                IF SpecialTranAmount > curReliefMorgage THEN BEGIN
                                    SpecialTranAmount := curReliefMorgage
                                END;

                            END;

                    END;
                END;
            UNTIL prTransactionCodes.NEXT = 0;
        END;
    end;


    procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date; currInstalment: Integer) PaysPens: Boolean
    var
        pnTranCode: Record 61082;
        pnEmpTrans: Record 70251;
    begin
        PaysPens := FALSE;
        pnEmpTrans.RESET;
        pnEmpTrans.SETRANGE(pnEmpTrans."Employee Code", pnEmpCode);
        pnEmpTrans.SETRANGE(pnEmpTrans."Payroll Period", pnPayperiod);
        pnEmpTrans.SETRANGE("Current Instalment", currInstalment);
        IF pnEmpTrans.FIND('-') THEN BEGIN
            REPEAT
                IF pnTranCode.GET(pnEmpTrans."Transaction Code") THEN
                    IF pnTranCode."coop parameters" = pnTranCode."coop parameters"::Pension THEN
                        PaysPens := TRUE;
            UNTIL pnEmpTrans.NEXT = 0;
        END;
    end;


    procedure fnGetPensionAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief"; blnCompDedc: Boolean; currInstalment: Integer) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record 70251;
        prTransactionCodes: Record 61082;
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.RESET;
        prTransactionCodes.SETRANGE(prTransactionCodes."Special Transactions", intSpecTransID);
        prTransactionCodes.SETRANGE(prTransactionCodes.Pension, TRUE);
        IF prTransactionCodes.FIND('-') THEN BEGIN
            REPEAT
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended, FALSE);
                prEmployeeTransactions.SETRANGE("Current Instalment", currInstalment);
                IF prEmployeeTransactions.FIND('-') THEN BEGIN

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    CASE intSpecTransID OF
                        intSpecTransID::"Defined Contribution":
                            IF (prTransactionCodes.Pension) THEN BEGIN
                                IF prTransactionCodes."Is Formula" THEN BEGIN
                                    strExtractedFrml := '';
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula, currInstalment);
                                    SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                                END ELSE
                                    SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;
                            END;
                    END;
                END;
            UNTIL prTransactionCodes.NEXT = 0;
        END;
        SpecialTranAmount := SpecialTransAmount;
    end;


    procedure disabled_emp(var empNo: Code[20]; var Gross: Decimal) Dis_A: Boolean
    var
        hrEmp: Record "HRM-Employee (D)";
    begin
        IF hrEmp.GET(empNo) THEN
            Dis_A := hrEmp."Physical Disability";
        IF Dis_A = TRUE THEN BEGIN
            IF (Gross <= 150000) THEN
                Dis_A := FALSE;
        END;
    end;


    procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record 70150;
    begin

        prNSSF.RESET;
        prNSSF.SETCURRENTKEY(prNSSF.Tier);
        IF prNSSF.FINDFIRST THEN BEGIN
            REPEAT
                IF ((curBaseAmount >= prNSSF."Lower Limit") AND (curBaseAmount <= prNSSF."Upper Limit")) THEN
                    NSSF := prNSSF."Tier 1 Employee Deduction";//prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
            UNTIL prNSSF.NEXT = 0;
        END;
    end;


    procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
    var
        prNSSF: Record 70150;
    begin

        prNSSF.RESET;
        prNSSF.SETCURRENTKEY(prNSSF.Tier);
        IF prNSSF.FINDFIRST THEN BEGIN
            REPEAT
                IF ((curBaseAmount >= prNSSF."Lower Limit") AND (curBaseAmount <= prNSSF."Upper Limit")) THEN
                    NSSF := prNSSF."Tier 1 Employee Deduction";//prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";
            UNTIL prNSSF.NEXT = 0;
        END;
    end;


    procedure fnGetEmployeeNSSF_Tier(curBaseAmount: Decimal) NSSF: Text
    var
        prNSSF: Record 70150;
    begin

        prNSSF.RESET;
        prNSSF.SETCURRENTKEY(prNSSF.Tier);
        IF prNSSF.FINDFIRST THEN BEGIN
            REPEAT
                IF ((curBaseAmount >= prNSSF."Lower Limit") AND (curBaseAmount <= prNSSF."Upper Limit")) THEN
                    NSSF := 'Tier ' + FORMAT(prNSSF.Tier);
            UNTIL prNSSF.NEXT = 0;
        END;
    end;


    procedure fnCalculatedBasicPay(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; HoursWorked: Decimal; ExpectedWorkHours: Decimal) CalculatedBasicAmt: Decimal
    begin
        CalculatedBasicAmt := ROUND((HoursWorked / ExpectedWorkHours) * BasicSalary);
    end;

    procedure CheckStatus(SelectedPeriod: Date; CurrentInstalment: Integer)
    var
        PRLPayrollPeriods: Record 70250;
    begin
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE("Date Openned", SelectedPeriod);
        PRLPayrollPeriods.SETRANGE("Current Instalment", CurrentInstalment);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            //IF PRLPayrollPeriods.Status <> PRLPayrollPeriods.Status::" " THEN ERROR('Already send for Approval!');
        END ELSE
            ERROR('Period Missing');
    end;
}

