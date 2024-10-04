// codeunit 50119 prPayrollProcessing
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         Text020: Label 'Because of circular references, the program cannot calculate a formula.';
//         Text012: Label 'You have entered an illegal value or a nonexistent row number.';
//         Text013: Label 'You have entered an illegal value or a nonexistent column number.';
//         Text017: Label 'The error occurred when the program tried to calculate:\';
//         Text018: Label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
//         Text019: Label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
//         Text023: Label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
//         PRLSalaryCard: Record "PRL-Salary Card";
//         VitalSetup: Record "PRL-Vital Setup Info";
//         curReliefPersonal: Decimal;
//         curReliefInsurance: Decimal;
//         curReliefMorgage: Decimal;
//         curMaximumRelief: Decimal;
//         curNssfEmployee: Decimal;
//         curNssf_Employer_Factor: Decimal;
//         intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
//         curMaxPensionContrib: Decimal;
//         curRateTaxExPension: Decimal;
//         curOOIMaxMonthlyContrb: Decimal;
//         curOOIDecemberDedc: Decimal;
//         curLoanMarketRate: Decimal;
//         curLoanCorpRate: Decimal;
//         curDisabledLimit: Decimal;
//         PostingGroup: Record "PRL-Employee Posting Group";
//         TaxAccount: Code[20];
//         salariesAcc: Code[20];
//         PayablesAcc: Code[20];
//         NSSFEMPyer: Code[20];
//         PensionEMPyer: Code[20];
//         NSSFEMPyee: Code[20];
//         NHIFEMPyer: Code[20];
//         NHIFEMPyee: Code[20];
//         HrEmployee: Record "HRM-Employee (D)";
//         CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
//         PayrollType: Code[20];
//         HREmp2: Record "HRM-Employee (D)";
//         curNssf_Base_Amount: Decimal;
//         intNSSF_BasedOn: Option Gross,Basic;
//         curNSSF_Tier: Text;
//         PRPeriod: Record "PRL-Period Transactions";
//         TotalSTATUTORIES: Decimal;
//         BenifitAmount: Decimal;
//         PRTransCode_2: Record "PRL-Transaction Codes";
//         PREmpTrans_2: Record "PRL-Employee Transactions";
//         PRPeriodTrans: Record "PRL-Period Transactions";
//         MonthlyExpectedWorkHrs: Decimal;
//         HoursWorked: Decimal;
//         ExpectedWorkHrs: Decimal;
//         TaxCharged_1: Decimal;
//         SpecialTranAmount: Decimal;
//         HRMCustomerCreditSales: Record "HRM Customer Credit Sales";

//         NhifInsuApplies: Boolean;
//         NHIFInsurancePercentage: Decimal;
//         NHIFInsuranceCap: Decimal;
//         curNHIFInsuranceReliefAmount: Decimal;


//         fNHIFReliefAmount: Decimal;

//         LoanAmount: Decimal;

//     procedure fnInitialize()
//     begin
//         //Initialize Global Setup Items
//         VitalSetup.FindFirst;

//         curReliefPersonal := VitalSetup."Tax Relief";
//         curReliefInsurance := VitalSetup."Insurance Relief";
//         curReliefMorgage := VitalSetup."Mortgage Relief"; //Same as HOSP
//         curMaximumRelief := VitalSetup."Max Relief";
//         curNssfEmployee := VitalSetup."NSSF Employee Factor";
//         curNssf_Employer_Factor := VitalSetup."NSSF Employer Factor";
//         intNHIF_BasedOn := VitalSetup."NHIF Based on";
//         curMaxPensionContrib := VitalSetup."Max Pension Contribution";
//         curRateTaxExPension := VitalSetup."Tax On Excess Pension";
//         curOOIMaxMonthlyContrb := VitalSetup."OOI Deduction";
//         curOOIDecemberDedc := VitalSetup."OOI December";
//         curLoanMarketRate := VitalSetup."Loan Market Rate";
//         curLoanCorpRate := VitalSetup."Loan Corporate Rate";
//         curDisabledLimit := VitalSetup."Disabled Tax Limit";
//         MonthlyExpectedWorkHrs := VitalSetup."Monthly Expected Work Hrs";

//         NhifInsuApplies := VitalSetup."Apply NHIF Insurance Relief";
//         NHIFInsuranceCap := VitalSetup."NHIF Insurance Relief Limit";
//         NHIFInsurancePercentage := VitalSetup."NHIF Insurance Relief %";

//     end;

//     procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20]; blnInsuranceCertificate: Boolean)
//     var
//         strTableName: Text[50];
//         curTransAmount: Decimal;
//         curTransBalance: Decimal;
//         strTransDescription: Text[50];
//         TGroup: Text[30];
//         TGroupOrder: Integer;
//         TSubGroupOrder: Integer;
//         curSalaryArrears: Decimal;
//         curPayeArrears: Decimal;
//         curGrossPay: Decimal;
//         curTotAllowances: Decimal;
//         curExcessPension: Decimal;
//         curNSSF: Decimal;
//         curDefinedContrib: Decimal;
//         curPensionStaff: Decimal;
//         curNonTaxable: Decimal;
//         curGrossTaxable: Decimal;
//         curBenefits: Decimal;
//         curValueOfQuarters: Decimal;
//         curUnusedRelief: Decimal;
//         curInsuranceReliefAmount: Decimal;
//         currInsuranceReliefAmount: Decimal;
//         curMorgageReliefAmount: Decimal;
//         curTaxablePay: Decimal;
//         curTaxCharged: Decimal;
//         curPAYE: Decimal;
//         prPeriodTransactions: Record "PRL-Period Transactions";
//         intYear: Integer;
//         intMonth: Integer;
//         LeapYear: Boolean;
//         CountDaysofMonth: Integer;
//         DaysWorked: Integer;
//         prSalaryArrears: Record "PRL-Salary Arrears";
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prTransactionCodes: Record "PRL-Transaction Codes";
//         strExtractedFrml: Text[250];
//         SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
//         TransactionType: Option Income,Deduction;
//         curPensionCompany: Decimal;
//         curTaxOnExcessPension: Decimal;
//         prUnusedRelief: Record "PRL-Unused Relief";
//         curNhif_Base_Amount: Decimal;
//         curNHIF: Decimal;
//         curTotalDeductions: Decimal;
//         curNetRnd_Effect: Decimal;
//         curNetPay: Decimal;
//         curTotCompanyDed: Decimal;
//         curOOI: Decimal;
//         curHOSP: Decimal;
//         curLoanInt: Decimal;
//         strTransCode: Text[250];
//         fnCalcFringeBenefit: Decimal;
//         prEmployerDeductions: Record "PRL-Employer Deductions";
//         JournalPostingType: Option " ","G/L Account",Customer,Vendor;
//         JournalAcc: Code[20];
//         Customer: Record Customer;
//         JournalPostAs: Option " ",Debit,Credit;
//         IsCashBenefit: Decimal;
//         PRLSalaryCard: Record "PRL-Salary Card";
//         SumItems: Option " ","Basic","Basic & House";
//         NSSFAmount: Decimal;
//     begin
//         //Initialize
//         if dtDOE = 0D then dtDOE := CalcDate('1M', Today);
//         fnInitialize;
//         fnGetJournalDet(strEmpCode);

//         //PayrollType
//         PayrollType := PayrollCode;

//         //check if the period selected=current period. If not, do NOT run this function
//         if SelectedPeriod <> dtOpenPeriod then exit;
//         intMonth := Date2DMY(SelectedPeriod, 2);
//         intYear := Date2DMY(SelectedPeriod, 3);

//         //IF curBasicPay >0 THEN
//         //Biometrics

//         // Update Lost Hours, 1st and 2nd Overtimes
//         // IF strEmpCode <> '' THEN
//         //    // ComputeLost1stand2ndOvertimes(intMonth, intYear, strEmpCode);

//         // //Calculate Basic Pay based on hrs worked for specific employees
//         // HREmp2.Reset;
//         // HREmp2.SetRange(HREmp2."No.", strEmpCode);
//         // HREmp2.SetRange(HREmp2."Date Filter", CalcDate('-cm', SelectedPeriod), CalcDate('cm', SelectedPeriod));
//         // if HREmp2.Find('-') then begin
//         //     // HREmp2.CALCFIELDS(HREmp2."Total Hours Worked") ;
//         //     if (HREmp2."Based On Hours worked" = HREmp2."Based On Hours worked"::BasedOnWorkedHrs) then begin
//         //         ExpectedWorkHrs := MonthlyExpectedWorkHrs;
//         //         HoursWorked := HREmp2."Total Days Worked";
//         //         //MESSAGE(FORMAT(HoursWorked))  ;
//         //         //  curBasicPay:=fnCalculatedBasicPay(strEmpCode, intMonth, intYear, curBasicPay,HoursWorked,ExpectedWorkHrs) ;
//         //     end;
//         // end;
//         //Calculate Basic Pay based on hrs worked for specific employees
//         //Biometrics

//         begin
//             //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
//             IF (DATE2DMY(dtDOE, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtDOE, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                 CountDaysofMonth := fnDaysInMonth(dtDOE);
//                 DaysWorked := fnDaysWorked(dtDOE, FALSE);
//                 curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
//             END;

//             //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//             /*  IF dtTermination <> 0D THEN BEGIN
//                  IF (DATE2DMY(dtTermination, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtTermination, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                      CountDaysofMonth := fnDaysInMonth(dtTermination);
//                      DaysWorked := fnDaysWorked(dtTermination, TRUE);
//                      curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
//                  END;
//              END; */

//             curTransAmount := curBasicPay;
//             //Added for NCA - If contract type is Casual Description should be Daily Wage
//             HREmp2.Reset;
//             if HREmp2.Get(strEmpCode) then begin
//                 if HREmp2."Contract Type" = HREmp2."Contract Type"::Permanent then begin
//                     strTransDescription := 'Basic Pay';
//                     TGroup := 'EARNINGS';  //uncommented and chaged to EARNINGS-HOSEA
//                 end;

//                 if HREmp2."Contract Type" = HREmp2."Contract Type"::Contract then begin
//                     strTransDescription := 'Basic Pay';
//                     TGroup := 'BASIC SALARY';
//                 end;

//                 if HREmp2."Contract Type" = HREmp2."Contract Type"::"Temporary" then begin
//                     strTransDescription := 'Daily Wage';
//                     TGroup := 'DAILY WAGE';
//                 end;
//                 /*
//                 IF HREmp2."Contract Type" = HREmp2."Contract Type"::Secondment THEN
//                 BEGIN
//                    strTransDescription := 'Basic Pay';
//                    TGroup := 'BASIC SALARY';
//                 END;

//                 IF HREmp2."Contract Type" = HREmp2."Contract Type"::"Temporary" THEN
//                 BEGIN
//                    strTransDescription := 'Basic Pay';
//                    TGroup := 'BASIC SALARY';
//                 END;

//                 IF HREmp2."Contract Type" = HREmp2."Contract Type"::"Graduate trainee" THEN
//                 BEGIN
//                    strTransDescription := 'Basic Pay';
//                    TGroup := 'BASIC SALARY';
//                 END;
//                 IF HREmp2."Contract Type" = HREmp2."Contract Type"::Intern THEN
//                 BEGIN
//                    strTransDescription := 'Stipend';
//                    TGroup := 'STIPEND';
//                 END;

//                 IF HREmp2."Contract Type" = HREmp2."Contract Type":: THEN
//                 BEGIN
//                    strTransDescription := 'Basic Pay';
//                    TGroup := 'BASIC SALARY';
//                 END;
//                 */
//             end;
//             //Added for NCA - If contract type is Casual Description should be Daily Wage
//             strTransDescription := 'Basic Salary';
//             TGroup := 'EARNINGS';
//             TGroupOrder := 1;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
//             TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
//             salariesAcc, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

//             //Salary Arrears
//             prSalaryArrears.Reset;
//             prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
//             prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
//             prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
//             if prSalaryArrears.Find('-') then begin
//                 repeat
//                     curSalaryArrears := prSalaryArrears."Salary Arrears";
//                     curPayeArrears := prSalaryArrears."PAYE Arrears";

//                     //Insert [Salary Arrears] into period trans [ARREARS]
//                     curTransAmount := curSalaryArrears;
//                     strTransDescription := 'Salary Arrears';
//                     TGroup := 'ARREARS';
//                     TGroupOrder := 1;
//                     TSubGroupOrder := 2;
//                     fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                       strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
//                       JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

//                     //Insert [PAYE Arrears] into period trans [PYAR]
//                     curTransAmount := curPayeArrears;
//                     strTransDescription := 'P.A.Y.E Arrears';
//                     TGroup := 'STATUTORIES';
//                     TGroupOrder := 7;
//                     TSubGroupOrder := 4;
//                     fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
//                        strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
//                        TaxAccount, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none)

//                 until prSalaryArrears.Next = 0;
//             end;

//             //todo alt 1 //Get Earnings that is calculated from days
//             // prEmployeeTransactions.Reset;
//             // prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//             // prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//             // prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//             // prEmployeeTransactions.SetFilter(prEmployeeTransactions."No of Units", '>%1', 0);
//             // if prEmployeeTransactions.Find('-') then begin
//             //     curTotAllowances := 0;
//             //     IsCashBenefit := 0;
//             //     repeat
//             //         prTransactionCodes.Reset;
//             //         prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//             //         prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
//             //         prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
//             //         prTransactionCodes.SetRange(prTransactionCodes."Calculate from Days", true);
//             //         if prTransactionCodes.Find('-') then begin
//             //             curTransAmount := 0;
//             //             curTransBalance := 0;
//             //             strTransDescription := '';
//             //             strExtractedFrml := '';
//             //             if prTransactionCodes."Is Formula" then begin
//             //                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//             //                 curTransAmount := Round(fnFormulaResult(strExtractedFrml)) * (prEmployeeTransactions."No of Units"); //Get the calculated amount

//             //             end else begin
//             //                 curTransAmount := prEmployeeTransactions.Amount;
//             //             end;

//             //             if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None then //[0=None, 1=Increasing, 2=Reducing]
//             //                 curTransBalance := 0;
//             //             if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing then
//             //                 curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
//             //             if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing then
//             //                 curTransBalance := prEmployeeTransactions.Balance - curTransAmount;


//             //Prorate Allowances Here
//             //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
//             /*  IF (DATE2DMY(dtDOE, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtDOE, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                  CountDaysofMonth := fnDaysInMonth(dtDOE);
//                  DaysWorked := fnDaysWorked(dtDOE, FALSE);
//                  curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//              END; */

//             //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//             /*  IF dtTermination <> 0D THEN BEGIN
//                  IF (DATE2DMY(dtTermination, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtTermination, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                      CountDaysofMonth := fnDaysInMonth(dtTermination);
//                      DaysWorked := fnDaysWorked(dtTermination, TRUE);
//                      curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//                  END;
//              END; */
//             // Prorate Allowances Here

//             //             //Add Non Taxable Here
//             //             if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
//             //             prTransactionCodes."Special Transactions"::Ignore) then
//             //                 curNonTaxable := curNonTaxable + curTransAmount;

//             //             //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
//             //             if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
//             //             prTransactionCodes."Special Transactions"::Ignore) then
//             //                 curTransAmount := 0;

//             //             curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
//             //             curTransAmount := curTransAmount;
//             //             curTransBalance := curTransBalance;
//             //             strTransDescription := prTransactionCodes."Transaction Name";
//             //             TGroup := 'EARNINGS';
//             //             TGroupOrder := 3;
//             //             TSubGroupOrder := 0;

//             //             //Get the posting Details
//             //             JournalPostingType := JournalPostingType::" ";
//             //             JournalAcc := '';
//             //             if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
//             //                 if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
//             //                     HrEmployee.Get(strEmpCode);

//             //                     Customer.Reset;
//             //                     Customer.SetRange(Customer."No.", HrEmployee."No.");
//             //                     if Customer.Find('-') then begin
//             //                         JournalAcc := Customer."No.";
//             //                         JournalPostingType := JournalPostingType::Customer;
//             //                     end;
//             //                 end;
//             //             end else begin
//             //                 JournalAcc := prTransactionCodes."GL Account";
//             //                 JournalPostingType := JournalPostingType::"G/L Account";
//             //             end;

//             //             //Get is Cash Benefits
//             //             if prTransactionCodes."Is Cash" then
//             //                 IsCashBenefit := IsCashBenefit + curTransAmount;
//             //             //End posting Details

//             //             fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//             //             strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
//             //             prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
//             //             prTransactionCodes."coop parameters");

//             //         end;
//             //     until prEmployeeTransactions.Next = 0;
//             // end;

//             //Get Earnings
//             prEmployeeTransactions.Reset;
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//             prEmployeeTransactions.SetFilter(prEmployeeTransactions."No of Units", '=%1', 0);
//             if prEmployeeTransactions.Find('-') then begin
//                 curTotAllowances := 0;
//                 IsCashBenefit := 0;
//                 repeat
//                     prTransactionCodes.Reset;
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
//                     prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
//                     if prTransactionCodes.Find('-') then begin
//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                         strTransDescription := '';
//                         strExtractedFrml := '';
//                         if prTransactionCodes."Is Formula" then begin
//                             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                             curTransAmount := Round(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//                             IF prTransactionCodes."Is a Rate" THEN BEGIN
//                                 // Check if Formula Takes Basic and Any other Allowances

//                                 // curTransAmount := curTransAmount * prEmployeeTransactions."Rate Factor";
//                                 // IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic Pay" THEN
//                                 //     curTransAmount := ROUND(curTransAmount * GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::Basic))
//                                 // ELSE
//                                 //     IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic & House Allowance" THEN
//                                 //         curTransAmount := ROUND(curTransAmount * GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::"Basic & House"));
//                                 // prEmployeeTransactions.Amount := curTransAmount;
//                                 // prEmployeeTransactions.MODIFY;

//                                 //  curTransAmount := curTransAmount * prEmployeeTransactions."Rate Factor";
//                                 IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic Pay" THEN
//                                     curTransAmount := ROUND((GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::Basic)) * (12 / 365) * prEmployeeTransactions."Rate Factor")
//                                 ELSE
//                                     IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic & House Allowance" THEN
//                                         curTransAmount := ROUND(GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::"Basic & House") * (12 / 365) * prEmployeeTransactions."Rate Factor");
//                                 prEmployeeTransactions.Amount := curTransAmount;

//                                 prEmployeeTransactions.MODIFY;
//                             END;
//                             curTransAmount := ROUND(curTransAmount);
//                         end
//                         else begin
//                             curTransAmount := prEmployeeTransactions.Amount;
//                         end;

//                         if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None then //[0=None, 1=Increasing, 2=Reducing]
//                             curTransBalance := 0;
//                         if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing then
//                             curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
//                         if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing then
//                             curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
//                         //Prorate Allowances Here
//                         //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
//                         IF (DATE2DMY(dtDOE, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtDOE, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                             CountDaysofMonth := fnDaysInMonth(dtDOE);
//                             DaysWorked := fnDaysWorked(dtDOE, FALSE);
//                             curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//                         END;

//                         //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//                         /* IF dtTermination <> 0D THEN BEGIN
//                             IF (DATE2DMY(dtTermination, 2) = DATE2DMY(dtOpenPeriod, 2)) AND (DATE2DMY(dtTermination, 3) = DATE2DMY(dtOpenPeriod, 3)) THEN BEGIN
//                                 CountDaysofMonth := fnDaysInMonth(dtTermination);
//                                 DaysWorked := fnDaysWorked(dtTermination, TRUE);
//                                 curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
//                             END;
//                         END; */
//                         // Prorate Allowances Here

//                         //Add Non Taxable Here
//                         if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
//                         prTransactionCodes."Special Transactions"::Ignore) then
//                             curNonTaxable := curNonTaxable + curTransAmount;

//                         //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
//                         if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
//                         prTransactionCodes."Special Transactions"::Ignore) then
//                             curTransAmount := 0;

//                         curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
//                         curTransAmount := curTransAmount;
//                         curTransBalance := curTransBalance;
//                         strTransDescription := prTransactionCodes."Transaction Name";
//                         TGroup := 'EARNINGS';
//                         TGroupOrder := 3;
//                         TSubGroupOrder := 0;

//                         //Get the posting Details
//                         JournalPostingType := JournalPostingType::" ";
//                         JournalAcc := '';
//                         if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
//                                 HrEmployee.Get(strEmpCode);

//                                 Customer.Reset;
//                                 Customer.SetRange(Customer."No.", HrEmployee."No.");
//                                 if Customer.Find('-') then begin
//                                     JournalAcc := Customer."No.";
//                                     JournalPostingType := JournalPostingType::Customer;
//                                 end;
//                             end;
//                         end else begin
//                             JournalAcc := prTransactionCodes."GL Account";
//                             JournalPostingType := JournalPostingType::"G/L Account";
//                         end;

//                         //Get is Cash Benefits
//                         if prTransactionCodes."Is Cash" then
//                             IsCashBenefit := IsCashBenefit + curTransAmount;
//                         //End posting Details

//                         fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                         strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
//                         prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
//                         prTransactionCodes."coop parameters");

//                     end;
//                 until prEmployeeTransactions.Next = 0;
//             end;


//             //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
//             curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
//             curTransAmount := curGrossPay;
//             strTransDescription := 'Gross Pay';     //CHANGE GROSS PAY TO BLANK -HOSEA
//             TGroup := 'Gross Pay';
//             TGroupOrder := 4;
//             TSubGroupOrder := 0;  //COMMENTED TO REMOVE GROUP HEADING-HOSEA
//             fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
//              intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none);

//             //Get the NSSF amount
//             IF blnPaysNssf THEN
//                 curNSSF := curNssfEmployee;

//             curTransAmount := curNSSF;
//             strTransDescription := 'N.S.S.F';
//             TGroup := 'STATUTORIES';
//             TGroupOrder := 7;
//             TSubGroupOrder := 1;
//             fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
//             strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
//             JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NSSF);

//             NSSFAmount := curTransAmount;
//             //NEW NSSF CODE HERE
//             //Get the N.S.S.F amount for the month GBT
//             // curNssf_Base_Amount := 0;
//             // if intNSSF_BasedOn = intNSSF_BasedOn::Gross then //>NSSF calculation can be based on:
//             //  curNssf_Base_Amount := curGrossPay;
//             //if intNSSF_BasedOn = intNSSF_BasedOn::Basic then
//             //  curNssf_Base_Amount := curBasicPay;

//             //Get the NSSF amount
//             // if blnPaysNssf then
//             //     curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
//             //  curNSSF_Tier := fnGetEmployeeNSSF_Tier(curNssf_Base_Amount); //Added to Display NSSF TIER
//             //  curTransAmount := curNSSF;
//             // strTransDescription := 'N.S.S.F';
//             // TGroup := 'STATUTORIES';
//             //  TGroupOrder := 7;
//             //  TSubGroupOrder := 1;
//             // fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
//             //  strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
//             //  JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NSSF);

//             //Update Employer deductions
//             if blnPaysNssf then
//                 curNSSF := fnGetEmployerNSSF(curNssf_Base_Amount);
//             curTransAmount := curNSSF;
//             fnUpdateEmployerDeductions(strEmpCode, 'NSSF',
//              'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
//               prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);


//             //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
//             curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
//             curTransAmount := curDefinedContrib;
//             strTransDescription := 'NSSF';  //change Defined contributions to NSSF-hosea
//             TGroup := 'TAXATION';
//             TGroupOrder := 6;
//             TSubGroupOrder := 1;   //CHANGE tax calculations TO APYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
//             fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
//              strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ",
//              JournalPostingType::" ", '', CoopParameters::none);


//             //Get the Gross taxable amount
//             //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
//             curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

//             //>If GrossTaxable = 0 Then TheDefinedToPost = 0
//             if curGrossTaxable = 0 then curDefinedContrib := 0;

//             //Personal Relief
//             // if get relief is ticked  - DENNO ADDED
//             if (blnGetsPAYERelief) then begin
//                 curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
//                 curTransAmount := curReliefPersonal;
//                 strTransDescription := 'Personal Relief';
//                 TGroup := 'TAXATION';
//                 TGroupOrder := 6;
//                 TSubGroupOrder := 9;//change tax calculations to PAYE INFORMATION -HOSEA // change TGroupOrder :=6 to 7
//                 fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                  CoopParameters::none);
//             end
//             else
//                 curReliefPersonal := 0;

//             //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//             //>Pension Contribution [self] relief
//             PRLSalaryCard.Reset;
//             PRLSalaryCard.SetRange("Employee Code", strEmpCode);
//             PRLSalaryCard.SetRange("Payroll Period", SelectedPeriod);
//             if PRLSalaryCard.Find('-') then
//                 if PRLSalaryCard."Pays Pension" then
//                     curPensionStaff := (0.03 * curBasicPay);// fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                                                             //SpecialTransType::"Defined Contribution",FALSE) ;//Self contrib Pension is 1 on [Special Transaction]
//             if curPensionStaff > 0 then begin
//                 if curPensionStaff > curMaxPensionContrib then
//                     curTransAmount := curMaxPensionContrib
//                 else
//                     curTransAmount := curPensionStaff;
//                 strTransDescription := 'Pension Relief';
//                 TGroup := 'TAXATION';
//                 TGroupOrder := 6;
//                 TSubGroupOrder := 1; //CHANGE TAX CALCULATIONS TO PAYE INFORMATION -HOSEA
//                 fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                 CoopParameters::none)
//             end;



//             //if he PAYS paye only*******************I
//             // if blnPaysPaye and blnGetsPAYERelief then begin
//             if blnPaysPaye then begin
//                 //Get Insurance Relief
                
//                 currInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 SpecialTransType::"Life Insurance", false); //Insurance is 3 on [Special Transaction]
//                 curInsuranceReliefAmount := currInsuranceReliefAmount;
                
//                 //********************************************************************************************************************************************************
//                 //Added DW - for employees who have brought the Insurance certificate, they are entitled to Insurance relief, Otherwise NO
//                 //Place a check mark on the Salary Card to YES
//                 if (curInsuranceReliefAmount > 0) then begin
//                     //if (curInsuranceReliefAmount > 0) and (blnInsuranceCertificate) then begin
//                     //Added Hosea - To Cap Insurance Relief to Setup amount
//                     if curInsuranceReliefAmount > curMaximumRelief then curInsuranceReliefAmount := curMaximumRelief;

//                     //Added Hosea - To Cap Insurance Relief to Setup amount
//                     curTransAmount := Round(curInsuranceReliefAmount, 1, '<'); //Added DW to round off to nearest shilling
//                     strTransDescription := 'Insurance Relief';
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 8;   //CHANGE tax calculations TO PAYE INFORMATION -HOSEA // change TGroupOrder :=6 to 7
//                     fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none);
//                 end;
//                 //********************************************************************************************************************************************************







//                 /*
//                 //if he PAYS paye only*******************I
//                 IF blnPaysPaye AND blnGetsPAYERelief THEN
//                 BEGIN
//                   //Get Insurance Relief
//                   curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                   SpecialTransType::"Life Insurance",FALSE); //Insurance is 3 on [Special Transaction]
//                   IF curInsuranceReliefAmount > 0 THEN BEGIN
//                       curTransAmount := curInsuranceReliefAmount;
//                       strTransDescription := 'Insurance Relief';
//                       TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 8;
//                       fnUpdatePeriodTrans (strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                       curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
//                       CoopParameters::none);
//                   END;
//                 */
//                 //BEGIN   !!!!!!!!! To enable without paye populate other deductions






//                 //>OOI
//                 curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 SpecialTransType::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
//                 if curOOI > 0 then begin
//                     if curOOI <= curOOIMaxMonthlyContrb then
//                         curTransAmount := curOOI
//                     else
//                         curTransAmount := curOOIMaxMonthlyContrb;

//                     strTransDescription := 'Owner Occupier Interest';
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 2;   //CHANGE tax calculations TO PAYE INFORMATION -HOSEA  // change TGroupOrder :=6 to 7
//                     fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                     CoopParameters::none);
//                 end;

//                 //HOSP
//                 curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                 SpecialTransType::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
//                 if curHOSP > 0 then begin
//                     if curHOSP <= curReliefMorgage then
//                         curTransAmount := curHOSP
//                     else
//                         curTransAmount := curReliefMorgage;

//                     strTransDescription := 'Home Ownership Savings Plan';
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 2;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA// change TGroupOrder :=6 to 7
//                     fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                     CoopParameters::none);
//                 end;


//                 //Dann
//                 //Mortage Relief
//                 curReliefMorgage := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
//                SpecialTransType::Morgage, false);
//                 if curReliefMorgage > 0 then begin
//                     curTransAmount := curReliefMorgage;
//                     strTransDescription := 'Mortgage Relief';
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 3;
//                     fnUpdatePeriodTrans(strEmpCode, 'MORG-RL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none)

//                 end;






//                 //Enter NonTaxable Amount
//                 if curNonTaxable > 0 then begin
//                     strTransDescription := 'Other Non-Taxable Benefits';
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 5;   //CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
//                     fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                     curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                     CoopParameters::none);
//                 end;

//             end;

//             //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//             /*
//              //>Company pension, Excess pension, Tax on excess pension
//              curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
//              TRUE); //Self contrib Pension is 1 on [Special Transaction]
//              IF curPensionCompany > 0 THEN BEGIN
//                  curTransAmount := curPensionCompany;
//                  strTransDescription := 'Pension (Company)';
//                  //Update the Employer deductions table

//                  curExcessPension:= curPensionCompany - curMaxPensionContrib;
//                  IF curExcessPension > 0 THEN BEGIN
//                      curTransAmount := curExcessPension;
//                      strTransDescription := 'Excess Pension';
//                      TGroup := 'DEDUCTIONS'; TGroupOrder := 6; TSubGroupOrder := 5; //CHANGE STATUTORY DEDUCTIONS TO STATUTORIES-HOSEA //STATUTORIES TO DEDUCTIONS// change TGroupOrder :=7 to 6
//                      fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
//                       intMonth,intYear,'','',SelectedPeriod);

//                      curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
//                      curTransAmount := curTaxOnExcessPension;
//                      strTransDescription := 'Tax on ExPension';
//                      TGroup := 'DEDUCTIONS'; TGroupOrder := 6; TSubGroupOrder := 6;   //CHANGE STATUTORY DEDUCTIONS TO STATUTORIES-HOSEA //STATUTORIES TO DEDUCTIONS // change TGroupOrder :=7 to 6
//                      fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
//                       intMonth,intYear,'','',SelectedPeriod);
//                  END;
//              END;
//              */

//             //Get the Taxable amount for calculation of PAYE
//             //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)

//             //Added Dann for KEPHIS
//             BenifitAmount := 0;
//             PRTransCode_2.Reset;
//             PRTransCode_2.SetRange(PRTransCode_2."Transaction Type", PRTransCode_2."Transaction Type"::Deduction);
//             if PRTransCode_2.Find('-') then begin
//                 PREmpTrans_2.Reset;
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Transaction Code", PRTransCode_2."Transaction Code");
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Employee Code", strEmpCode);
//                 PREmpTrans_2.SetRange(PREmpTrans_2."Payroll Period", SelectedPeriod);
//                 if PREmpTrans_2.Find('-') then begin
//                     if PRTransCode_2.Taxable then BenifitAmount := PREmpTrans_2.Amount;
//                     //Insert in to PR Period Trans
//                     strTransDescription := PRTransCode_2."Transaction Name";
//                     curTransAmount := PREmpTrans_2.Amount;
//                     TGroup := 'TAXATION';
//                     TGroupOrder := 6;
//                     TSubGroupOrder := 1;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA
//                     fnUpdatePeriodTrans(strEmpCode, PRTransCode_2."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                     strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                     '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none);

//                 end;
//             end;
//             ////Insert in to PR Period Trans
//             //strTransDescription := PRTransCode_2."Transaction Name";
//             //curTransAmount:=PREmpTrans_2.Amount;
//             //TGroup := 'TAX CALCULATIONS'; TGroupOrder:= 6; TSubGroupOrder:= 1;
//             //fnUpdatePeriodTrans(strEmpCode, PRTransCode_2."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//             //strTransDescription, curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
//             //'',JournalPostAs::Credit,JournalPostingType::" ",'',CoopParameters::none);
//             //Initialize
//             curTransAmount := 0;
//             curTransBalance := 0;
//             strTransDescription := '';
//             //Added Dann for KEPHIS
//             //***************************************************************

//             /////////////////////////////////////////////// NHIF
//             ///  // //Get the N.H.I.F amount for the month GBT
//             curNhif_Base_Amount := 0;

//             if intNHIF_BasedOn = intNHIF_BasedOn::Gross then //>NHIF calculation can be based on
//                 curNhif_Base_Amount := curGrossPay;
//             if intNHIF_BasedOn = intNHIF_BasedOn::Basic then
//                 curNhif_Base_Amount := curBasicPay;
//             if intNHIF_BasedOn = intNHIF_BasedOn::"Taxable Pay" then
//                 curNhif_Base_Amount := curTaxablePay;
//             //calculate NHIF and its relief

//             IF blnPaysNhif THEN BEGIN
//                 curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
//                 curTransAmount := curNHIF;
//                 NHIFEMPyee := PostingGroup."NHIF Employee Account";
//                 strTransDescription := 'N.H.I.F';
//                 TGroup := 'STATUTORIES';
//                 TGroupOrder := 7;
//                 TSubGroupOrder := 2;
//                 fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                  curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                  NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);

//                 IF blnPaysPaye THEN BEGIN
//                     //Get Insurance Relief
//                     IF ((NhifInsuApplies) AND (NHIFInsurancePercentage > 0)) THEN BEGIN

//                         curNHIFInsuranceReliefAmount := ((NHIFInsurancePercentage / 100) * curNHIF);


//                         // if curNHIFInsuranceReliefAmount > NHIFInsuranceCap then
//                         //     curNHIFInsuranceReliefAmount := NHIFInsuranceCap;

//                         IF curNHIFInsuranceReliefAmount > 0 THEN BEGIN
//                             curTransAmount := curNHIFInsuranceReliefAmount;
//                             fNHIFReliefAmount := curTransAmount;
//                             strTransDescription := 'NHIF Insurance Relief';
//                             TGroup := 'TAXATION';
//                             TGroupOrder := 6;
//                             TSubGroupOrder := 12;
//                             fnUpdatePeriodTrans(strEmpCode, 'NHIFINSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" "
//                             , '', CoopParameters::none);
//                         END;
//                     END;
//                 END;
//             END;


//             if (curPensionStaff + curDefinedContrib) > curMaxPensionContrib then
//                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable) + BenifitAmount
//             else
//                 curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable) + BenifitAmount;

//             curTaxablePay := curTaxablePay - NSSFAmount;

//             curTransAmount := curTaxablePay;
//             strTransDescription := 'Chargeable Pay';
//             TGroup := 'TAXATION';
//             TGroupOrder := 6;
//             TSubGroupOrder := 6;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
//             fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//              curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//              CoopParameters::none);

//             //Get the Tax charged for the month
//             // Special tax for disabled employees
//             //Check if employee is disabled


//             HREmp2.Reset;
//             if HREmp2.Get(strEmpCode) then begin
//                 if HREmp2.Disabled = HREmp2.Disabled::Yes then begin
//                     if curTaxablePay >= curDisabledLimit then begin

//                         //If taxable pay is greater than limit
//                         curTaxCharged := fnGetEmployeePaye(curTaxablePay - curDisabledLimit);
//                         curTransAmount := curTransAmount - fNHIFReliefAmount;
//                         curTransAmount := curTaxCharged;
//                         strTransDescription := 'Tax Charged';
//                         TGroup := 'TAXATION';
//                         TGroupOrder := 6;
//                         TSubGroupOrder := 7; //CHANGE tax calculations TO PAYE INFORMATION-HOSEA  // change TGroupOrder :=6 to 7
//                         fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                         CoopParameters::none);
//                     end else begin
//                         //If taxable pay is lower than limit
//                         //curTaxCharged := fnGetEmployeePaye(curTaxablePay);
//                         curTaxCharged := 0;
//                         curTransAmount := curTransAmount - fNHIFReliefAmount;
//                         curTransAmount := curTaxCharged;
//                         strTransDescription := 'Tax Charged';
//                         TGroup := 'TAXATION';
//                         TGroupOrder := 6;
//                         TSubGroupOrder := 7;//CHANGE tax calculations TO PAYE INFORMATION-HOSEA // change TGroupOrder :=6 to 7
//                         fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                         CoopParameters::none);
//                         // END
//                     end;
//                 end

//                 else begin

//                     //Added for deployed
//                     if HREmp2."Employee Category" = 'DEPLOYED' then begin
//                         //MESSAGE('i am deployed');
//                         curTaxCharged := curTaxablePay * 0.3;   //transfer this to setup
//                         curTransAmount := curTaxCharged;

//                         //Added
//                         TaxCharged_1 := curTransAmount;
//                         //Added

//                         strTransDescription := 'Tax Charged';
//                         TGroup := 'TAXATION';
//                         TGroupOrder := 6;
//                         TSubGroupOrder := 7;   //CHANGE tax calculations TO PAYE INFORMATION-HOSEA  // change TGroupOrder :=6 to 7
//                         fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//                         '', JournalPostAs::Credit, JournalPostingType::" ", '', CoopParameters::none);

//                     end else begin
//                         //Not deployed
//                         //  MESSAGE('i am NOT deployed');
//                         curTaxCharged := fnGetEmployeePaye(curTaxablePay);
//                         curTransAmount := curTaxCharged;
//                         strTransDescription := 'Tax Charged';
//                         TGroup := 'TAXATION';
//                         TGroupOrder := 6;
//                         TSubGroupOrder := 7;  //CHANGE tax calculations TO PAYE INFORMATION-HOSEA// change TGroupOrder :=6 to 7
//                         fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
//                         CoopParameters::none);
//                         //Not deployed
//                     end;
//                 end;
//             end;

//             //Get the Net PAYE amount to post for the month
//             if (curInsuranceReliefAmount) > curMaximumRelief then begin
//                 curInsuranceReliefAmount := curMaximumRelief;
//                 curPAYE := curTaxCharged - (curInsuranceReliefAmount + curReliefPersonal + curReliefMorgage);
//             end else begin
//                 //******************************************************************************************************************************************
//                 //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
//                 //Place a check mark on the Salary Card to YES
//                 //if (blnInsuranceCertificate) then begin
//                 curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curReliefMorgage);
//                 /*  end else begin
//                      curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount) - curReliefMorgage;
//                      //curPAYE := curTaxCharged - (curReliefPersonal);
//                  end; */

//             end;

//             //curPAYE := curPAYE - fNHIFReliefAmount;
//             /*
//                //Get the Net PAYE amount to post for the month
//            IF (curReliefPersonal + curInsuranceReliefAmount)>curMaximumRelief THEN
//              curPAYE := curTaxCharged - curMaximumRelief
//            ELSE
//            curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);
//               */




//             if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
//             curTransAmount := curPAYE;
//             if curPAYE < 0 then curTransAmount := 0;
//             strTransDescription := 'P.A.Y.E';
//             TGroup := 'STATUTORIES';
//             TGroupOrder := 7;
//             TSubGroupOrder := 3;
//             fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//              curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, JournalPostAs::Credit,
//              JournalPostingType::"G/L Account", '', CoopParameters::none);

//             //Store the unused relief for the current month
//             //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
//             if curPAYE < 0 then begin
//                 prUnusedRelief.Reset;
//                 prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
//                 prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
//                 prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
//                 if prUnusedRelief.Find('-') then
//                     prUnusedRelief.Delete;

//                 prUnusedRelief.Reset;

//                 prUnusedRelief.Init;
//                 prUnusedRelief."Employee Code" := strEmpCode;
//                 prUnusedRelief."Unused Relief" := curPAYE;
//                 prUnusedRelief."Period Month" := intMonth;
//                 prUnusedRelief."Period Year" := intYear;
//                 prUnusedRelief.Insert;

//                 curPAYE := 0;

//             end;

//             //Deductions: get all deductions for the month
//             //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
//             //>Balance = (Openning Bal + Deduction)...//Increasing balance
//             //>Balance = (Openning Bal - Deduction)...//Reducing balance
//             //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance



//             //commented by hosea to give right NHIF Amount on Payslip
//             //curNhif_Base_Amount :=0;
//             // curNhif_Base_Amount := curBasicPay;

//             // if blnPaysNhif then begin  TODO CHANGED DUE TO NEW TAX RELIEF ON NHIF
//             //     curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
//             //     curTransAmount := curNHIF;
//             //     strTransDescription := 'N.H.I.F';
//             //     TGroup := 'STATUTORIES';
//             //     TGroupOrder := 7;
//             //     TSubGroupOrder := 2;
//             //     fnUpdatePeriodTrans(strEmpCode, 'NHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//             //      curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//             //      NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);
//             // end;



//             prEmployeeTransactions.Reset;
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//             //prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);

//             if prEmployeeTransactions.Find('-') then begin
//                 curTotalDeductions := 0;
//                 repeat
//                     prTransactionCodes.Reset;
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                     prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Deduction);
//                     if prTransactionCodes.Find('-') then begin
//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                         strTransDescription := '';
//                         strExtractedFrml := '';

//                         IF prTransactionCodes."Is Formula" THEN BEGIN
//                             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                             curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
//                             IF prTransactionCodes."Is a Rate" THEN BEGIN
//                                 // Check if Formula Takes Basic and Any other Allowances

//                                 // curTransAmount := curTransAmount * prEmployeeTransactions."Rate Factor";
//                                 // IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic Pay" THEN
//                                 //     curTransAmount := ROUND(curTransAmount * GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::Basic))
//                                 // ELSE
//                                 //     IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic & House Allowance" THEN
//                                 //         curTransAmount := ROUND(curTransAmount * GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::"Basic & House"));
//                                 // prEmployeeTransactions.Amount := curTransAmount;
//                                 // prEmployeeTransactions.MODIFY;

//                                 // curTransAmount := curTransAmount * prEmployeeTransactions."Rate Factor";
//                                 // IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic Pay" THEN
//                                 //     curTransAmount := ROUND((GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::Basic)), 0.01, '=')
//                                 // ELSE
//                                 //     IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic & House Allowance" THEN
//                                 //         curTransAmount := ROUND((GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::"Basic & House")), 0.01, '=');
//                                 // prEmployeeTransactions.Amount := curTransAmount;
//                                 // prEmployeeTransactions.MODIFY;

//                                 IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic Pay" THEN
//                                     curTransAmount := ROUND((GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::Basic)) * (12 / 365) * prEmployeeTransactions."Rate Factor")
//                                 ELSE
//                                     IF prTransactionCodes."Is Rate of" = prTransactionCodes."Is Rate of"::"Basic & House Allowance" THEN
//                                         curTransAmount := ROUND(GetBasicAndOtherAllowances(strEmpCode, intMonth, intYear, SumItems::"Basic & House") * (12 / 365) * prEmployeeTransactions."Rate Factor");
//                                 prEmployeeTransactions.Amount := curTransAmount;

//                                 prEmployeeTransactions.MODIFY;

//                             END;
//                             prEmployeeTransactions.Amount := curTransAmount;

//                             prEmployeeTransactions.MODIFY;
//                         END ELSE BEGIN
//                             curTransAmount := prEmployeeTransactions.Amount;
//                         END;

//                         //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
//                         if ((prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Life Insurance")
//                           and (prTransactionCodes."Deduct Premium" = false)) then begin
//                             curTransAmount := 0;
//                         end;

//                         //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::Morgage)
//                          and (prTransactionCodes."Deduct Mortgage" = false) then begin
//                             curTransAmount := 0;
//                         end;
//                         // Pension
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Defined Contribution") then
//                             if prTransactionCodes.Pension = true then
//                              //AND (prTransactionCodes."Deduct Mortgage"=FALSE) THEN
//                              begin
//                                 curTransAmount := (0.03 * curBasicPay);//-curNSSF;
//                                 fnUpdateEmployerDeductions(strEmpCode, prTransactionCodes."Transaction Code",
//                         'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
//                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
//                             end;

//                         //Get the posting Details
//                         JournalPostingType := JournalPostingType::" ";
//                         JournalAcc := '';
//                         if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
//                             if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
//                                 Customer.Reset;
//                                 HrEmployee.Get(strEmpCode);
//                                 Customer.Reset;
//                                 //IF prTransactionCodes.CustomerPostingGroup ='' THEN
//                                 //Customer.SETRANGE(Customer."Employer Code",'KPSS');

//                                 if prTransactionCodes.CustomerPostingGroup <> '' then
//                                     Customer.SetRange(Customer."Customer Posting Group", prTransactionCodes.CustomerPostingGroup);

//                                 Customer.SetRange(Customer."No.", HrEmployee."No.");
//                                 if Customer.Find('-') then begin
//                                     JournalAcc := Customer."No.";
//                                     JournalPostingType := JournalPostingType::Customer;
//                                 end;
//                             end;
//                         end else begin
//                             JournalAcc := prTransactionCodes."GL Account";
//                             JournalPostingType := JournalPostingType::"G/L Account";
//                         end;

//                         //End posting Details


//                         //  IF prTransactionCodes."Transaction Code"='D002' THEN
//                         //  MESSAGE('iKO');
//                         //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
//                         if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") then begin

//                             curTransAmount := 0;
//                             curLoanInt := 0;
//                             curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
//                             prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
//                             prEmployeeTransactions.Amount, prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);

//                             //Post the Interest
//                             if (curLoanInt <> 0) then begin
//                                 curTransAmount := curLoanInt;
//                                 curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
//                                 curTransBalance := 0;
//                                 strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
//                                 strTransDescription := prEmployeeTransactions."Transaction Name" + ' INTEREST';
//                                 TGroup := 'DEDUCTIONS';
//                                 TGroupOrder := 8;
//                                 TSubGroupOrder := 1;
//                                 //change other deductions to deductions-hosea //change group from 8 to 6 and subgroup from 1 to 12-hosea
//                                 fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
//                                   strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
//                                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                                   JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
//                                   CoopParameters::"loan Interest")
//                             end;
//                             //Get the Principal Amt
//                             //  curTransAmount:=prEmployeeTransactions."Amortized Loan Total Repay Amt"-curLoanInt;
//                             //            //Modify PREmployeeTransaction Table
//                             // prEmployeeTransactions.Amount := curTransAmount;
//                             //prEmployeeTransactions.MODIFY;
//                         end;
//                         //Loan Calculation Amortized

//                         if ((prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") and
//                           (prTransactionCodes.Welfare = true)) then begin
//                             Clear(curTransAmount);//fnGetWelfareAmount
//                             curTransAmount := fnGetWelfareAmount(strEmpCode, prEmployeeTransactions."Transaction Code",
//                                   prTransactionCodes."Interest Rate",
//                                    prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
//                                    prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);
//                             //Modify PREmployeeTransaction Table
//                             prEmployeeTransactions.Amount := curTransAmount;
//                             prEmployeeTransactions.Modify;
//                         end;

//                         case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
//                             prTransactionCodes."Balance Type"::None:
//                                 curTransBalance := 0;
//                             prTransactionCodes."Balance Type"::Increasing:
//                                 curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
//                             prTransactionCodes."Balance Type"::Reducing:
//                                 begin
//                                     //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
//                                     if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
//                                         curTransAmount := prEmployeeTransactions.Balance;
//                                         curTransBalance := 0;
//                                     end else begin
//                                         curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;// curTransAmount;
//                                     end;
//                                     if curTransBalance < 0 then begin
//                                         curTransAmount := 0;
//                                         curTransBalance := 0;
//                                     end;
//                                 end
//                         end;

//                         curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
//                                                                                    //curTransAmount := prEmployeeTransactions.Amount;
//                         if prEmployeeTransactions."Transaction Code" <> 'D0005' then
//                             curTransBalance := curTransBalance
//                         else
//                             curTransAmount := prEmployeeTransactions.Amount;
//                         strTransDescription := prTransactionCodes."Transaction Name";
//                         TGroup := 'DEDUCTIONS';
//                         TGroupOrder := 8;
//                         TSubGroupOrder := 13; //change other deductions to deductions-hosea // change TGroupOrder :=8 to 6
//                         fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//                          strTransDescription, curTransAmount, curTransBalance, intMonth,
//                          intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                          JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
//                          prTransactionCodes."coop parameters");



//                         //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
//                         /*     IF (prTransactionCodes."Special Transactions"=prTransactionCodes."Special Transactions"::"Staff Loan") THEN BEGIN

//                                   curLoanInt:=fnCalcLoanInterest (strEmpCode, prEmployeeTransactions."Transaction Code",
//                                  prTransactionCodes."Interest Rate",
//                                   prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
//                                   prEmployeeTransactions.Balance,SelectedPeriod,prTransactionCodes.Welfare);
//                                    IF curLoanInt > 0 THEN BEGIN
//                                        curTransAmount := curLoanInt;
//                                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
//                                        curTransBalance:=0;
//                                        strTransCode := prEmployeeTransactions."Transaction Code"+'-INT';
//                                        strTransDescription := prEmployeeTransactions."Transaction Name"+ 'Interest';
//                                        TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 14;   //change other deductions to deductions-hosea // change TGroupOrder :=8 to 6
//                                        fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
//                                          strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
//                                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
//                                          JournalAcc,JournalPostAs::Credit,JournalPostingType,prEmployeeTransactions."Loan Number",
//                                          CoopParameters::"loan Interest")
//                                   END;
//                             END;*/
//                         //End Loan transaction calculation
//                         //Fringe Benefits and Low interest Benefits
//                         if prTransactionCodes."Fringe Benefit" = true then begin
//                             if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
//                                 fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
//                                  * prEmployeeTransactions.Balance;
//                             end;
//                         end else begin
//                             fnCalcFringeBenefit := 0;
//                         end;
//                         if fnCalcFringeBenefit > 0 then begin
//                             fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
//                              'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
//                               prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

//                         end;
//                         //End Fringe Benefits

//                         //Create Employer Deduction
//                         if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
//                             if prTransactionCodes."Is Formula for employer" <> '' then begin
//                                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
//                                 curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
//                             end else begin
//                                 curTransAmount := prEmployeeTransactions."Employer Amount";
//                             end;
//                             if curTransAmount > 0 then
//                                 fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
//                                  'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
//                                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);

//                             //Added to for employee plus employer contributions NCA
//                             //Update Balance on PR Period Transaction Table with Pension Contributed from Employer
//                             PRPeriodTrans.Reset;
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", strEmpCode);
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", prEmployeeTransactions."Transaction Code");
//                             PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", SelectedPeriod);
//                             if PRPeriodTrans.Find('-') then begin
//                                 if PRPeriodTrans.Balance <> 0 then PRPeriodTrans.Balance += curTransAmount;
//                                 PRPeriodTrans.Modify;
//                             end;
//                             //Added to for employee plus employer contributions NCA
//                         end;
//                         //Employer deductions

//                     end;

//                 until prEmployeeTransactions.Next = 0;
//                 //GET TOTAL DEDUCTIONS

//                 //Added for NCA - To add Statutories to Total Deductions
//                 TotalSTATUTORIES := 0;
//                 PRPeriod.Reset;
//                 PRPeriod.SetRange(PRPeriod."Payroll Period", SelectedPeriod);
//                 PRPeriod.SetRange(PRPeriod."Employee Code", strEmpCode);
//                 PRPeriod.SetFilter(PRPeriod."Group Text", '=%1|%2', 'STATUTORIES', 'DEDUCTIONS'); //cHANGE STATUTORY DEDUCTIONS TO STATUTORIES-HOSEA
//                 if PRPeriod.Find('-') then begin
//                     repeat
//                         TotalSTATUTORIES += PRPeriod.Amount;
//                     until PRPeriod.Next = 0;

//                 end;
//                 //Added for NCA - To add Statutories to Total Deductions
//                 curTotalDeductions := TotalSTATUTORIES;

//                 curTransBalance := 0;
//                 strTransCode := 'TOT-DED';
//                 strTransDescription := 'TOTAL DEDUCTIONS';
//                 TGroup := 'DEDUCTION SUMMARY';
//                 TGroupOrder := 8;
//                 TSubGroupOrder := 15;//change other deductions to deductions-hosea // change TGroupOrder :=6 to 8
//                 fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
//                   strTransDescription, (TotalSTATUTORIES), curTransBalance, intMonth, intYear,
//                   // (curTotalDeductions+TotalSTATUTORIES-curTotalDeductions), curTransBalance, intMonth, intYear, //ADD -curTotalDeductions -HOSEA
//                   prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
//                   '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none)

//                 //END GET TOTAL DEDUCTIONS
//             end;

//             //Net Pay: calculate the Net pay for the month in the following manner:
//             //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
//             //...Tot Deductions also include (SumLoan + SumInterest)

//             //  curNetPay := curGrossPay - (NSSFAmount + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit);// john

//             curNetPay := curGrossPay - curTotalDeductions;
//             //>Nett = Nett - curExcessPension
//             //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
//             curNetPay := curNetPay; //- curExcessPension

//             //>Nett = Nett - cSumEmployerDeductions
//             //...Employer Deductions are used for reporting as cost to company BUT dont affect Net payB
//             curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

//             curNetRnd_Effect := curNetPay - Round(curNetPay);
//             curTransAmount := curNetPay;
//             strTransDescription := 'Net Pay';
//             TGroup := 'NET PAY';
//             TGroupOrder := 9;
//             TSubGroupOrder := 0;

//             fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
//             PayablesAcc, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);

//             //Rounding Effect: if the Net pay is rounded, take the rounding effect &
//             //save it as an earning for the staff for the next month
//             //>Insert the Netpay rounding effect into the tblRoundingEffect table


//             //Negative pay: if the NetPay<0 then log the entry
//             //>Display an on screen report
//             //>Through a pop-up to the user
//             //>Send an email to the user or manager
//             //END

//         end;
//         //END; !!!!!!!!!

//     end;

//     procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
//     begin
//         ProratedAmt := Round((DaysWorked / DaysInMonth) * BasicSalary);
//     end;

//     procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
//     var
//         Day: Integer;
//         SysDate: Record Date;
//         Expr1: Text[30];
//         FirstDay: Date;
//         LastDate: Date;
//         TodayDate: Date;
//     begin
//         TodayDate := dtDate;

//         Day := Date2DMY(TodayDate, 1);
//         Expr1 := Format(-Day) + 'D+1D';
//         FirstDay := CalcDate(Expr1, TodayDate);
//         LastDate := CalcDate('1M-1D', FirstDay);

//         SysDate.Reset;
//         SysDate.SetRange(SysDate."Period Type", SysDate."Period Type"::Date);
//         SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
//         // SysDate.SETFILTER(SysDate."Period No.",'1..5');
//         if SysDate.Find('-') then
//             DaysInMonth := SysDate.Count;
//     end;

//     procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
//     var
//         prPeriodTransactions: Record "PRL-Period Transactions";
//         prSalCard: Record "HRM-Employee (D)";
//     begin
//         if curAmount = 0 then exit;

//         prPeriodTransactions.Init;
//         prPeriodTransactions."Employee Code" := EmpCode;
//         prPeriodTransactions."Transaction Code" := TCode;
//         prPeriodTransactions."Group Text" := TGroup;
//         prPeriodTransactions."Transaction Name" := Description;
//         //  Amount := ROUND(curAmount,0.05,'=');
//         prPeriodTransactions.Amount := Round(curAmount);
//         prPeriodTransactions.Balance := curBalance;
//         prPeriodTransactions."Original Amount" := prPeriodTransactions.Balance;
//         prPeriodTransactions."Group Order" := GroupOrder;
//         prPeriodTransactions."Sub Group Order" := SubGroupOrder;
//         prPeriodTransactions.Membership := mMembership;
//         prPeriodTransactions."Reference No" := ReferenceNo;
//         prPeriodTransactions."Period Month" := Month;
//         prPeriodTransactions."Period Year" := Year;
//         prPeriodTransactions."Payroll Period" := dtOpenPeriod;
//         prPeriodTransactions."Department Code" := Department;
//         prPeriodTransactions."Journal Account Type" := JournalACType;
//         prPeriodTransactions."Post As" := PostAs;
//         prPeriodTransactions."Journal Account Code" := JournalAC;
//         prPeriodTransactions."Loan Number" := LoanNo;
//         prPeriodTransactions."coop parameters" := CoopParam;
//         prPeriodTransactions."Payroll Code" := PayrollType;
//         //Paymode
//         if prSalCard.Get(EmpCode) then
//             prPeriodTransactions."Payment Mode" := prSalCard."Payment Mode";
//         prPeriodTransactions.Insert;
//         //Update the prEmployee Transactions  with the Amount
//         fnUpdateEmployeeTrans(prPeriodTransactions."Employee Code", prPeriodTransactions."Transaction Code", prPeriodTransactions.Amount,
//         prPeriodTransactions."Period Month", prPeriodTransactions."Period Year", prPeriodTransactions."Payroll Period");

//     end;

//     procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Allowance Recovery"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
//     var
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prTransactionCodes: Record "PRL-Transaction Codes";
//         strExtractedFrml: Text[250];
//     begin
//         SpecialTransAmount := 0;
//         prTransactionCodes.Reset;
//         prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
//         if prTransactionCodes.Find('-') then begin
//             repeat
//                 prEmployeeTransactions.Reset;
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
//                 if prEmployeeTransactions.Find('-') then begin

//                     //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
//                     //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
//                     case intSpecTransID of
//                         intSpecTransID::"Defined Contribution":
//                             if prTransactionCodes."Is Formula" then begin
//                                 strExtractedFrml := '';
//                                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                                 SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//                             end else
//                                 SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

//                         intSpecTransID::"Allowance Recovery":
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


//                         intSpecTransID::"Life Insurance":
//                             SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

//                         //
//                         intSpecTransID::"Owner Occupier Interest":
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


//                         intSpecTransID::"Home Ownership Savings Plan":
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

//                         intSpecTransID::Gratuity:
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount * 0.3;

//                         intSpecTransID::"Insurance Relief":
//                             SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

//                         intSpecTransID::Morgage:
//                             begin
//                                 SpecialTransAmount := SpecialTransAmount + curReliefMorgage;
//                                 if SpecialTransAmount > curReliefMorgage then begin
//                                     SpecialTransAmount := curReliefMorgage
//                                 end;
//                             end;

//                     end;
//                 end;
//             until prTransactionCodes.Next = 0;
//         end;
//         //SpecialTranAmount:=SpecialTransAmount;
//     end;

//     procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
//     var
//         prPAYE: Record "PRL-PAYE";
//         curTempAmount: Decimal;
//         KeepCount: Integer;
//     begin
//         KeepCount := 0;
//         prPAYE.Reset;
//         if prPAYE.FindFirst then begin
//             if curTaxablePay < prPAYE."PAYE Tier" then exit;
//             repeat
//                 KeepCount += 1;
//                 curTempAmount := curTaxablePay;
//                 if curTaxablePay = 0 then exit;
//                 if KeepCount = prPAYE.Count then   //this is the last record or loop
//                     curTaxablePay := curTempAmount
//                 else
//                     if curTempAmount >= prPAYE."PAYE Tier" then
//                         curTempAmount := prPAYE."PAYE Tier"
//                     else
//                         curTempAmount := curTempAmount;

//                 PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
//                 curTaxablePay := curTaxablePay - curTempAmount;

//             until prPAYE.Next = 0;
//         end;
//     end;

//     procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
//     var
//         prNHIF: Record "PRL-NHIF";
//     begin
//         prNHIF.Reset;
//         prNHIF.SetCurrentKey(prNHIF."Tier Code");
//         if prNHIF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
//                     NHIF := prNHIF.Amount;
//             until prNHIF.Next = 0;
//         end;
//     end;

//     procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
//     var
//         Where: Text[30];
//         Which: Text[30];
//         i: Integer;
//         TransCode: Code[20];
//         Char: Text[1];
//         FirstBracket: Integer;
//         StartCopy: Boolean;
//         FinalFormula: Text[250];
//         TransCodeAmount: Decimal;
//         AccSchedLine: Record "Acc. Schedule Line";
//         ColumnLayout: Record "Column Layout";
//         CalcAddCurr: Boolean;
//         AccSchedMgt: Codeunit AccSchedManagement;
//     begin
//         TransCode := '';
//         for i := 1 to StrLen(strFormula) do begin
//             Char := CopyStr(strFormula, i, 1);
//             if Char = '[' then StartCopy := true;

//             if StartCopy then TransCode := TransCode + Char;
//             //Copy Characters as long as is not within []
//             if not StartCopy then
//                 FinalFormula := FinalFormula + Char;
//             if Char = ']' then begin
//                 StartCopy := false;
//                 //Get Transcode
//                 Where := '=';
//                 Which := '[]';
//                 TransCode := DelChr(TransCode, Where, Which);
//                 //Get TransCodeAmount
//                 TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
//                 //Reset Transcode
//                 TransCode := '';
//                 //Get Final Formula
//                 FinalFormula := FinalFormula + Format(TransCodeAmount);
//                 //End Get Transcode
//             end;
//         end;
//         Formula := FinalFormula;
//     end;

//     procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
//     var
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prPeriodTransactions: Record "PRL-Period Transactions";
//     begin
//         prEmployeeTransactions.Reset;
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
//         if prEmployeeTransactions.FindFirst then begin

//             TransAmount := prEmployeeTransactions.Amount;
//             if prEmployeeTransactions."No of Units" <> 0 then
//                 TransAmount := prEmployeeTransactions."No of Units";

//         end;
//         if TransAmount = 0 then begin
//             prPeriodTransactions.Reset;
//             prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//             prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//             if prPeriodTransactions.FindFirst then
//                 TransAmount := prPeriodTransactions.Amount;
//         end;
//     end;

//     procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
//     var
//         AccSchedLine: Record "Acc. Schedule Line";
//         ColumnLayout: Record "Column Layout";
//         CalcAddCurr: Boolean;
//         AccSchedMgt: Codeunit AccSchedManagement2;
//     begin
//         Results := AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
//     end;

//     procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
//     var
//         dtOldPeriod: Date;
//         intNewMonth: Integer;
//         dtNewPeriod: Date;
//         intOldMonth: Integer;
//         intNewYear: Integer;
//         intOldYear: Integer;
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prPeriodTransactions: Record "PRL-Period Transactions";
//         intMonth: Integer;
//         intYear: Integer;
//         prTransactionCodes: Record "PRL-Transaction Codes";
//         curTransAmount: Decimal;
//         curTransBalance: Decimal;
//         prEmployeeTrans: Record "PRL-Employee Transactions";
//         prPayrollPeriods: Record "PRL-Payroll Periods";
//         prNewPayrollPeriods: Record "PRL-Payroll Periods";
//         CreateTrans: Boolean;
//         ControlInfo: Record "HRM-Control-Information";
//         prsalCard3: Record "PRL-Salary Card";
//         prsalCard: Record "PRL-Salary Card";
//     begin
//         ControlInfo.Get();
//         dtNewPeriod := CalcDate('1M', dtOpenPeriod);
//         intNewMonth := Date2DMY(dtNewPeriod, 2);
//         intNewYear := Date2DMY(dtNewPeriod, 3);
//         intOldMonth := Date2DMY(dtOpenPeriod, 2);
//         intOldYear := Date2DMY(dtOpenPeriod, 3);

//         intMonth := Date2DMY(dtOpenPeriod, 2);
//         intYear := Date2DMY(dtOpenPeriod, 3);

//         prEmployeeTransactions.Reset;
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//         prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);

//         //Multiple Payroll
//         if ControlInfo."Multiple Payroll" then begin
//             prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);
//         end;

//         //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",'KPSS091');


//         if prEmployeeTransactions.Find('-') then begin
//             repeat
//                 prTransactionCodes.Reset;
//                 prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
//                 if prTransactionCodes.Find('-') then begin

//                     case prTransactionCodes."Balance Type" of
//                         prTransactionCodes."Balance Type"::None:
//                             begin
//                                 curTransAmount := prEmployeeTransactions.Amount;
//                                 curTransBalance := 0;
//                             end;
//                         prTransactionCodes."Balance Type"::Increasing:
//                             begin
//                                 curTransAmount := prEmployeeTransactions.Amount;
//                                 curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
//                             end;
//                         prTransactionCodes."Balance Type"::Reducing:
//                             begin
//                                 curTransAmount := prEmployeeTransactions.Amount;
//                                 if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
//                                     curTransAmount := prEmployeeTransactions.Balance;
//                                     curTransBalance := 0;
//                                 end else begin
//                                     curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
//                                 end;
//                                 if curTransBalance < 0 then begin
//                                     curTransAmount := 0;
//                                     curTransBalance := 0;
//                                 end;

//                             end;
//                     end;
//                 end;

//                 //For those transactions with Start and End Date Specified
//                 if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
//                     if prEmployeeTransactions."End Date" < dtNewPeriod then begin
//                         curTransAmount := 0;
//                         curTransBalance := 0;
//                     end;
//                 end;
//                 //End Transactions with Start and End Date

//                 if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
//                    (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
//                  begin
//                     if (curTransAmount <> 0) then  //Update the employee transaction table
//                      begin
//                         if ((prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing) and (curTransBalance <> 0)) or
//                          (prTransactionCodes."Balance Type" <> prTransactionCodes."Balance Type"::Reducing) then
//                             prEmployeeTransactions.Balance := curTransBalance;
//                         prEmployeeTransactions.Modify;


//                         //Insert record for the next period

//                         if (prEmployeeTransactions."Transaction Code" <> 'D066') then
//                             if (prEmployeeTransactions."Transaction Code" <> 'P021') then begin
//                                 prEmployeeTrans.Init;
//                                 prEmployeeTrans."Employee Code" := prEmployeeTransactions."Employee Code";
//                                 prEmployeeTrans."Transaction Code" := prEmployeeTransactions."Transaction Code";
//                                 prEmployeeTrans."Transaction Name" := prEmployeeTransactions."Transaction Name";
//                                 prEmployeeTrans.Amount := curTransAmount;
//                                 prEmployeeTrans.Balance := curTransBalance;
//                                 prEmployeeTrans."Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
//                                 prEmployeeTrans."Original Amount" := prEmployeeTransactions."Original Amount";
//                                 prEmployeeTrans.Membership := prEmployeeTransactions.Membership;
//                                 prEmployeeTrans."Reference No" := prEmployeeTransactions."Reference No";
//                                 prEmployeeTrans."Loan Number" := prEmployeeTransactions."Loan Number";
//                                 prEmployeeTrans."Period Month" := intNewMonth;
//                                 prEmployeeTrans."Period Year" := intNewYear;
//                                 prEmployeeTrans."Payroll Period" := dtNewPeriod;
//                                 prEmployeeTrans."Payroll Code" := PayrollCode;
//                                 prEmployeeTrans."Recurance Index" := prEmployeeTransactions."Recurance Index" - 1;
//                                 // Insert only if the counter for the frequnency is not 0
//                                 if (prEmployeeTransactions."Recurance Index" - 1) > 0 then
//                                     prEmployeeTrans.Insert;

//                             end;
//                     end;
//                     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//                     // Insert Openning Babances for VEt and Stores  FRMFarmerCreditSales
//                     VitalSetup.Reset;
//                     if VitalSetup.Find('-') then;
//                     VitalSetup.TestField("Credit Trans. Code");
//                     // VET
//                     if (prEmployeeTransactions."Transaction Code" = VitalSetup."Credit Trans. Code") then begin//A Vet Item
//                                                                                                                // Get Amount Posted For the Transaction
//                                                                                                                // prEmployeeTransactions.RESET;
//                                                                                                                //    prEmployeeTransactions.SETRANGE("Farmer No.",FrmFarmers."Company No.");
//                                                                                                                //    prEmployeeTransactions.SETRANGE("Transaction Code",VitalSetup."Credit Trans. Code");
//                                                                                                                //    prEmployeeTransactions.SETRANGE("Payroll Period",dtOpenPeriod);
//                                                                                                                //    IF prEmployeeTransactions."Transaction Code"= BEGIN
//                         if prEmployeeTransactions.Amount <> 0 then begin
//                             // update the Monthly Submissions
//                             HRMCustomerCreditSales.Reset;
//                             HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Customer No.", prEmployeeTransactions."Employee Code");
//                             HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Trans. No.", VitalSetup."Credit Trans. Code");
//                             HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Payroll Period", dtOpenPeriod);
//                             HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Transaction Type", HRMCustomerCreditSales."Transaction Type"::"Store Settlement");
//                             if HRMCustomerCreditSales.FindFirst then begin
//                                 HRMCustomerCreditSales.Amount := -prEmployeeTransactions.Amount;
//                                 HRMCustomerCreditSales.Modify;
//                             end else begin
//                                 HRMCustomerCreditSales.Init;
//                                 HRMCustomerCreditSales."Trans. No." := VitalSetup."Credit Trans. Code";
//                                 HRMCustomerCreditSales."Trans. Date" := Today;
//                                 HRMCustomerCreditSales."Customer No." := prEmployeeTransactions."Employee Code";
//                                 HRMCustomerCreditSales."Trans. Desc." := 'Credit Purchase Settlement';
//                                 HRMCustomerCreditSales."Served by" := UserId;
//                                 HRMCustomerCreditSales.Amount := -prEmployeeTransactions.Amount;
//                                 HRMCustomerCreditSales."Payroll Period" := dtOpenPeriod;
//                                 HRMCustomerCreditSales."Period Year" := Date2DMY(dtOpenPeriod, 3);
//                                 HRMCustomerCreditSales."Period Month" := Date2DMY(dtOpenPeriod, 2);
//                                 HRMCustomerCreditSales."Transaction Type" := HRMCustomerCreditSales."Transaction Type"::"Store Settlement";
//                                 HRMCustomerCreditSales.Insert;
//                             end;
//                         end;
//                     end;

//                     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//                 end
//             until prEmployeeTransactions.Next = 0;
//             prsalCard.Reset;
//             prsalCard.SetRange(prsalCard."Payroll Period", dtOpenPeriod);
//             if prsalCard.Find('-') then begin
//                 repeat
//                 begin
//                     if prsalCard."Current Round Up" > 0 then begin

//                         prEmployeeTrans.Init;
//                         prEmployeeTrans."Employee Code" := prsalCard."Employee Code";
//                         prEmployeeTrans."Transaction Code" := 'D066';
//                         prEmployeeTrans."Transaction Name" := 'Rounding Up Effect';
//                         prEmployeeTrans.Amount := prsalCard."Current Round Up";
//                         prEmployeeTrans."Period Month" := intNewMonth;
//                         prEmployeeTrans."Period Year" := intNewYear;
//                         prEmployeeTrans."Payroll Period" := dtNewPeriod;
//                         prEmployeeTrans."Payroll Code" := PayrollCode;
//                         prEmployeeTrans.Insert;

//                     end else
//                         if prsalCard."Current Round Down" > 0 then begin

//                             prEmployeeTrans.Init;
//                             prEmployeeTrans."Employee Code" := prsalCard."Employee Code";
//                             prEmployeeTrans."Transaction Code" := 'P021';
//                             prEmployeeTrans."Transaction Name" := 'Rounding Down Effect';
//                             prEmployeeTrans.Amount := prsalCard."Current Round Down";
//                             prEmployeeTrans."Period Month" := intNewMonth;
//                             prEmployeeTrans."Period Year" := intNewYear;
//                             prEmployeeTrans."Payroll Period" := dtNewPeriod;
//                             prEmployeeTrans."Payroll Code" := PayrollCode;
//                             prEmployeeTrans.Insert;
//                         end;
//                 end;

//                 prsalCard3.Reset;
//                 if not (prsalCard3.Get(prsalCard."Employee Code", dtNewPeriod)) then begin // Insert the Basic salary details for the current Month
//                     prsalCard3.Init;
//                     prsalCard3."Employee Code" := prsalCard."Employee Code";
//                     prsalCard3."Payroll Period" := dtNewPeriod;
//                     prsalCard3."Basic Pay" := prsalCard."Basic Pay";
//                     prsalCard3."Payment Mode" := prsalCard."Payment Mode";
//                     prsalCard3.Currency := prsalCard.Currency;
//                     prsalCard3."Pays NSSF" := prsalCard."Pays NSSF";
//                     prsalCard3."Pays NHIF" := prsalCard."Pays NHIF";
//                     prsalCard3."Pays PAYE" := prsalCard."Pays PAYE";
//                     prsalCard3."Payslip Message" := prsalCard."Payslip Message";
//                     prsalCard3."Suspend Pay" := prsalCard."Suspend Pay";
//                     prsalCard3."Suspension Date" := prsalCard."Suspension Date";
//                     prsalCard3."Suspension Reasons" := prsalCard."Suspension Reasons";
//                     prsalCard3.Exists := prsalCard.Exists;
//                     prsalCard3."Bank Account Number" := prsalCard."Bank Account Number";
//                     prsalCard3."Bank Branch" := prsalCard."Bank Branch";
//                     prsalCard3."Employee's Bank" := prsalCard."Employee's Bank";
//                     prsalCard."Posting Group" := prsalCard."Posting Group";
//                     prsalCard3."Pays Pension" := prsalCard."Pays Pension";
//                     prsalCard3."Current Round Up" := 0;
//                     prsalCard3."Current Round Down" := 0;
//                     prsalCard3."Preveous Round Down" := prsalCard."Current Round Down";
//                     prsalCard3."Preveous Round Up" := prsalCard."Current Round Up";
//                     prsalCard3."Period Month" := intNewMonth;
//                     prsalCard3."Period Year" := intNewYear;
//                     prsalCard3."Current Month" := intOldMonth;
//                     prsalCard3."Current Year" := intOldYear;
//                     prsalCard3.Insert;
//                 end;

//                 // prsalCard."Preveous Round Down":=prsalCard."Current Round Down";
//                 // prsalCard."Preveous Round Up":=prsalCard."Current Round Up";
//                 // prsalCard."Period Month":=intNewMonth;
//                 // prsalCard."Period Year":=intNewYear;
//                 // prsalCard."Current Round Down":=0;
//                 // prsalCard."Current Round Up":=0;
//                 // prsalCard."Current Month":=intOldMonth;
//                 // prsalCard."Current Year":=intOldYear;
//                 // prsalCard.MODIFY;


//                 until prsalCard.Next = 0;
//             end;

//         end;

//         //Update the Period as Closed
//         prPayrollPeriods.Reset;
//         prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
//         prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
//         prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
//         if ControlInfo."Multiple Payroll" then
//             prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

//         if prPayrollPeriods.Find('-') then begin
//             prPayrollPeriods.Closed := true;
//             prPayrollPeriods."Date Closed" := Today;
//             prPayrollPeriods.Modify;
//         end;

//         //Enter a New Period

//         prNewPayrollPeriods.Init;
//         prNewPayrollPeriods."Period Month" := intNewMonth;
//         prNewPayrollPeriods."Period Year" := intNewYear;
//         prNewPayrollPeriods."Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + ' - ' + Format(intNewYear);
//         prNewPayrollPeriods."Date Opened" := dtNewPeriod;
//         prNewPayrollPeriods.Closed := false;
//         prNewPayrollPeriods."Payroll Code" := 'PAYROLL';
//         prNewPayrollPeriods.Insert;


//         //Effect the transactions for the P9
//         fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);

//         //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
//         fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
//     end;

//     procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
//     var
//         prPeriodTransactions: Record "PRL-Period Transactions";
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         intNewMonth: Integer;
//         intNewYear: Integer;
//         dtNewPeriod: Date;
//     begin
//         dtNewPeriod := CalcDate('1M', dtOpenPeriod);
//         intNewMonth := Date2DMY(dtNewPeriod, 2);
//         intNewYear := Date2DMY(dtNewPeriod, 3);

//         prPeriodTransactions.Reset;
//         prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//         prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//         prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
//         prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

//         if prPeriodTransactions.Find('-') then begin
//             repeat

//                 prEmployeeTransactions.Init;
//                 prEmployeeTransactions."Employee Code" := prPeriodTransactions."Employee Code";
//                 prEmployeeTransactions."Transaction Code" := 'NEGP';
//                 prEmployeeTransactions."Transaction Name" := 'Negative Pay';
//                 prEmployeeTransactions.Amount := prPeriodTransactions.Amount;
//                 prEmployeeTransactions.Balance := 0;
//                 prEmployeeTransactions."Original Amount" := 0;
//                 prEmployeeTransactions."Period Month" := intNewMonth;
//                 prEmployeeTransactions."Period Year" := intNewYear;
//                 prEmployeeTransactions."Payroll Period" := dtNewPeriod;
//                 prEmployeeTransactions.Insert;

//             until prPeriodTransactions.Next = 0;
//         end;
//     end;

//     procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
//     var
//         P9EmployeeCode: Code[20];
//         P9BasicPay: Decimal;
//         P9Allowances: Decimal;
//         P9Benefits: Decimal;
//         P9ValueOfQuarters: Decimal;
//         P9DefinedContribution: Decimal;
//         P9OwnerOccupierInterest: Decimal;
//         P9GrossPay: Decimal;
//         P9TaxablePay: Decimal;
//         P9TaxCharged: Decimal;
//         P9InsuranceRelief: Decimal;
//         P9TaxRelief: Decimal;
//         P9Paye: Decimal;
//         P9NSSF: Decimal;
//         P9NHIF: Decimal;
//         P9Deductions: Decimal;
//         P9NetPay: Decimal;
//         prPeriodTransactions: Record "PRL-Period Transactions";
//         prEmployee: Record "HRM-Employee (D)";
//     begin
//         P9BasicPay := 0;
//         P9Allowances := 0;
//         P9Benefits := 0;
//         P9ValueOfQuarters := 0;
//         P9DefinedContribution := 0;
//         P9OwnerOccupierInterest := 0;
//         P9GrossPay := 0;
//         P9TaxablePay := 0;
//         P9TaxCharged := 0;
//         P9InsuranceRelief := 0;
//         P9TaxRelief := 0;
//         P9Paye := 0;
//         P9NSSF := 0;
//         P9NHIF := 0;
//         P9Deductions := 0;
//         P9NetPay := 0;

//         prEmployee.Reset;
//         prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Normal);
//         if prEmployee.Find('-') then begin
//             repeat

//                 P9BasicPay := 0;
//                 P9Allowances := 0;
//                 P9Benefits := 0;
//                 P9ValueOfQuarters := 0;
//                 P9DefinedContribution := 0;
//                 P9OwnerOccupierInterest := 0;
//                 P9GrossPay := 0;
//                 P9TaxablePay := 0;
//                 P9TaxCharged := 0;
//                 P9InsuranceRelief := 0;
//                 P9TaxRelief := 0;
//                 P9Paye := 0;
//                 P9NSSF := 0;
//                 P9NHIF := 0;
//                 P9Deductions := 0;
//                 P9NetPay := 0;

//                 prPeriodTransactions.Reset;
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
//                 prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
//                 if prPeriodTransactions.Find('-') then begin
//                     repeat

//                         case prPeriodTransactions."Group Order" of
//                             1: //Basic pay & Arrears
//                                 begin
//                                     if prPeriodTransactions."Sub Group Order" = 1 then P9BasicPay := prPeriodTransactions.Amount; //Basic Pay
//                                     if prPeriodTransactions."Sub Group Order" = 2 then P9BasicPay := P9BasicPay + prPeriodTransactions.Amount; //Basic Pay Arrears
//                                 end;
//                             3:  //Allowances
//                                 begin
//                                     P9Allowances := P9Allowances + prPeriodTransactions.Amount
//                                 end;
//                             4: //Gross Pay
//                                 begin
//                                     P9GrossPay := prPeriodTransactions.Amount
//                                 end;
//                             6: //Taxation
//                                 begin
//                                     if prPeriodTransactions."Sub Group Order" = 1 then P9DefinedContribution := prPeriodTransactions.Amount; //Defined Contribution
//                                     if prPeriodTransactions."Sub Group Order" = 9 then P9TaxRelief := prPeriodTransactions.Amount; //Tax Relief
//                                     if prPeriodTransactions."Sub Group Order" = 8 then P9InsuranceRelief := prPeriodTransactions.Amount; //Insurance Relief
//                                     if prPeriodTransactions."Sub Group Order" = 6 then P9TaxablePay := prPeriodTransactions.Amount; //Taxable Pay
//                                     if prPeriodTransactions."Sub Group Order" = 7 then P9TaxCharged := prPeriodTransactions.Amount; //Tax Charged
//                                 end;
//                             7: //Statutories
//                                 begin
//                                     if prPeriodTransactions."Sub Group Order" = 1 then P9NSSF := prPeriodTransactions.Amount; //Nssf
//                                     if prPeriodTransactions."Sub Group Order" = 2 then P9NHIF := prPeriodTransactions.Amount; //Nhif
//                                     if prPeriodTransactions."Sub Group Order" = 3 then P9Paye := prPeriodTransactions.Amount; //paye
//                                     if prPeriodTransactions."Sub Group Order" = 4 then P9Paye := P9Paye + prPeriodTransactions.Amount; //Paye Arrears
//                                 end;
//                             8://Deductions
//                                 begin
//                                     P9Deductions := P9Deductions + prPeriodTransactions.Amount;
//                                 end;
//                             9: //NetPay
//                                 begin
//                                     P9NetPay := prPeriodTransactions.Amount;
//                                 end;
//                         end;

//                     until prPeriodTransactions.Next = 0;
//                 end;
//                 //Update the P9 Details

//                 if P9NetPay <> 0 then
//                     fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
//                         P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
//                         P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

//             until prEmployee.Next = 0;
//         end;
//     end;

//     procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
//     var
//         prEmployeeP9Info: Record "PRL-Employee P9 Info";
//         intYear: Integer;
//         intMonth: Integer;
//     begin
//         intMonth := Date2DMY(dtCurrPeriod, 2);
//         intYear := Date2DMY(dtCurrPeriod, 3);

//         prEmployeeP9Info.Reset;
//         prEmployeeP9Info.SetRange(prEmployeeP9Info."Payroll Period", dtCurrPeriod);
//         prEmployeeP9Info.SetRange(prEmployeeP9Info."Employee Code", P9EmployeeCode);
//         prEmployeeP9Info.SetRange(prEmployeeP9Info."Period Month", intMonth);
//         prEmployeeP9Info.SetRange(prEmployeeP9Info."Period Year", intYear);
//         prEmployeeP9Info.SetRange(prEmployeeP9Info."Payroll Code", prPayrollCode);
//         if prEmployeeP9Info.Find('-') then prEmployeeP9Info.Delete;

//         prEmployeeP9Info.Init;
//         prEmployeeP9Info."Employee Code" := P9EmployeeCode;
//         prEmployeeP9Info."Basic Pay" := P9BasicPay;
//         prEmployeeP9Info.Allowances := P9Allowances;
//         prEmployeeP9Info.Benefits := P9Benefits;
//         prEmployeeP9Info."Value Of Quarters" := P9ValueOfQuarters;
//         prEmployeeP9Info."Defined Contribution" := P9DefinedContribution;
//         prEmployeeP9Info."Owner Occupier Interest" := P9OwnerOccupierInterest;
//         prEmployeeP9Info."Gross Pay" := P9GrossPay;
//         prEmployeeP9Info."Taxable Pay" := P9TaxablePay;
//         prEmployeeP9Info."Tax Charged" := P9TaxCharged;
//         prEmployeeP9Info."Insurance Relief" := P9InsuranceRelief;
//         prEmployeeP9Info."Tax Relief" := P9TaxRelief;
//         prEmployeeP9Info.PAYE := P9Paye;
//         prEmployeeP9Info.NSSF := P9NSSF;
//         prEmployeeP9Info.NHIF := P9NHIF;
//         prEmployeeP9Info.Deductions := P9Deductions;
//         prEmployeeP9Info."Net Pay" := P9NetPay;
//         prEmployeeP9Info."Period Month" := intMonth;
//         prEmployeeP9Info."Period Year" := intYear;
//         prEmployeeP9Info."Payroll Period" := dtCurrPeriod;
//         prEmployeeP9Info."Payroll Code" := prPayrollCode;
//         prEmployeeP9Info.Insert;

//     end;

//     procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
//     var
//         Day: Integer;
//         SysDate: Record Date;
//         Expr1: Text[30];
//         FirstDay: Date;
//         LastDate: Date;
//         TodayDate: Date;
//     begin
//         TodayDate := dtDate;

//         Day := Date2DMY(TodayDate, 1);
//         Expr1 := Format(-Day) + 'D+1D';
//         FirstDay := CalcDate(Expr1, TodayDate);
//         LastDate := CalcDate('1M-1D', FirstDay);

//         SysDate.Reset;
//         SysDate.SetRange(SysDate."Period Type", SysDate."Period Type"::Date);
//         if not IsTermination then
//             SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
//         else
//             SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
//         // SysDate.SETFILTER(SysDate."Period No.",'1..5');
//         if SysDate.Find('-') then
//             DaysWorked := SysDate.Count;
//     end;

//     procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
//     var
//         FirstMonth: Boolean;
//         startmonth: Integer;
//         startYear: Integer;
//         "prEmployee P9 Info": Record "PRL-Employee P9 Info";
//         P9BasicPay: Decimal;
//         P9taxablePay: Decimal;
//         P9PAYE: Decimal;
//         ProratedBasic: Decimal;
//         SalaryArrears: Decimal;
//         SalaryVariance: Decimal;
//         SupposedTaxablePay: Decimal;
//         SupposedTaxCharged: Decimal;
//         SupposedPAYE: Decimal;
//         PAYEVariance: Decimal;
//         PAYEArrears: Decimal;
//         PeriodMonth: Integer;
//         PeriodYear: Integer;
//         CountDaysofMonth: Integer;
//         DaysWorked: Integer;
//     begin
//         fnInitialize;

//         FirstMonth := true;
//         if EndDate > StartDate then begin
//             while StartDate < EndDate do begin
//                 //fnGetEmpP9Info
//                 startmonth := Date2DMY(StartDate, 2);
//                 startYear := Date2DMY(StartDate, 3);

//                 "prEmployee P9 Info".Reset;
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
//                 "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
//                 if "prEmployee P9 Info".Find('-') then begin
//                     P9BasicPay := "prEmployee P9 Info"."Basic Pay";
//                     P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
//                     P9PAYE := "prEmployee P9 Info".PAYE;

//                     if P9BasicPay > 0 then   //Staff payment history is available
//                      begin
//                         if FirstMonth then begin                 //This is the first month in the arrears loop
//                             if Date2DMY(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
//                              begin
//                                 //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
//                                 //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
//                                 if (Date2DMY(dtDOE, 2) = Date2DMY(StartDate, 2)) and (Date2DMY(dtDOE, 3) = Date2DMY(StartDate, 3)) then begin
//                                     CountDaysofMonth := fnDaysInMonth(dtDOE);
//                                     DaysWorked := fnDaysWorked(dtDOE, false);
//                                     ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
//                                 end;

//                                 //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
//                                 /*   IF dtTermination<>0D THEN BEGIN
//                                    IF (DATE2DMY(dtTermination,2)=DATE2DMY(StartDate,2)) AND (DATE2DMY(dtTermination,3)=DATE2DMY(StartDate,3))THEN BEGIN
//                                        CountDaysofMonth:=fnDaysInMonth(dtTermination);
//                                        DaysWorked:=fnDaysWorked(dtTermination,TRUE);
//                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay,DaysWorked,CountDaysofMonth)
//                                    END;
//                                  END;*/

//                                 SalaryArrears := (CBasic - ProratedBasic)
//                             end
//                             else begin
//                                 SalaryArrears := (CBasic - P9BasicPay);
//                             end;
//                         end;
//                         SalaryVariance := SalaryVariance + SalaryArrears;
//                         SupposedTaxablePay := P9taxablePay + SalaryArrears;

//                         //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
//                         if SupposedTaxablePay > P9taxablePay then begin
//                             SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
//                             SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
//                             PAYEVariance := SupposedPAYE - P9PAYE;
//                             PAYEArrears := PAYEArrears + PAYEVariance;
//                         end;
//                         FirstMonth := false;               //reset the FirstMonth Boolean to False
//                     end;
//                 end;
//                 StartDate := CalcDate('+1M', StartDate);
//             end;
//             if SalaryArrears <> 0 then begin
//                 PeriodYear := Date2DMY(dtOpenPeriod, 3);
//                 PeriodMonth := Date2DMY(dtOpenPeriod, 2);
//                 fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
//                 dtOpenPeriod);
//             end

//         end
//         else
//             Error('The start date must be earlier than the end date');

//     end;

//     procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
//     var
//         FirstMonth: Boolean;
//         ProratedBasic: Decimal;
//         SalaryVariance: Decimal;
//         PayeVariance: Decimal;
//         SupposedTaxablePay: Decimal;
//         SupposedTaxCharged: Decimal;
//         SupposedPaye: Decimal;
//         CurrentBasic: Decimal;
//         StartDate: Date;
//         "prSalary Arrears": Record "PRL-Salary Arrears";
//     begin
//         "prSalary Arrears".Reset;
//         "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
//         "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
//         "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
//         "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
//         if "prSalary Arrears".Find('-') = false then begin
//             "prSalary Arrears".Init;
//             "prSalary Arrears"."Employee Code" := EmployeeCode;
//             "prSalary Arrears"."Transaction Code" := TransCode;
//             "prSalary Arrears"."Start Date" := OrigStartDate;
//             "prSalary Arrears"."End Date" := EndDate;
//             "prSalary Arrears"."Salary Arrears" := SalaryArrears;
//             "prSalary Arrears"."PAYE Arrears" := PayeArrears;
//             "prSalary Arrears"."Period Month" := intMonth;
//             "prSalary Arrears"."Period Year" := intYear;
//             "prSalary Arrears"."Payroll Period" := payperiod;
//             "prSalary Arrears".Insert;
//         end
//     end;

//     procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
//     var
//         curLoanInt: Decimal;
//         intMonth: Integer;
//         intYear: Integer;
//         HRMWelfareLoanTiers: Record "HRM Welfare Loan Tiers";
//     begin
//         intMonth := Date2DMY(CurrPeriod, 2);
//         intYear := Date2DMY(CurrPeriod, 3);

//         curLoanInt := 0;



//         if InterestRate > 0 then begin
//             if RecoveryMethod = RecoveryMethod::"Straight line" then //Straight Line Method [1]
//                 curLoanInt := (InterestRate / 100) * LoanAmount;

//             if RecoveryMethod = RecoveryMethod::Reducing then //Reducing Balance [0]

//                  curLoanInt := (InterestRate / 100) * Balance;

//             if RecoveryMethod = RecoveryMethod::Amortized then //Amortized [2]
//                 curLoanInt := (InterestRate / 100) * Balance;
//         end else
//             curLoanInt := 0;

//         if Welfare then begin
//             Clear(curLoanInt);
//             HRMWelfareLoanTiers.Reset;
//             HRMWelfareLoanTiers.SetFilter("Lower Limit", '%1|<%2', Balance, Balance);
//             HRMWelfareLoanTiers.SetFilter("Upper Limit", '%1|>%2', Balance, Balance);
//             if HRMWelfareLoanTiers.Find('-') then begin
//                 curLoanInt := HRMWelfareLoanTiers.Amount;
//                 curLoanInt := (InterestRate / 100) * curLoanInt;
//             end;
//         end;
//         //Return the Amount
//         LnInterest := Round(curLoanInt);
//     end;

//     procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
//     var
//         prEmployerDeductions: Record "PRL-Employer Deductions";
//     begin

//         if curAmount = 0 then exit;
//         if not prEmployerDeductions.Get(EmpCode, TCode, Month, Year, dtOpenPeriod) then begin

//             prEmployerDeductions.Init;
//             prEmployerDeductions."Employee Code" := EmpCode;
//             prEmployerDeductions."Transaction Code" := TCode;
//             prEmployerDeductions.Amount := curAmount;
//             prEmployerDeductions."Period Month" := Month;
//             prEmployerDeductions."Period Year" := Year;
//             prEmployerDeductions."Payroll Period" := dtOpenPeriod;
//             prEmployerDeductions.Insert;

//         end else begin


//             //"Employee Code" := EmpCode;
//             //"Transaction Code" := TCode;
//             prEmployerDeductions.Amount := curAmount;
//             //"Period Month" := Month;
//             //"Period Year" := Year;
//             //"Payroll Period" := dtOpenPeriod;
//             prEmployerDeductions.Modify;

//         end;
//     end;

//     procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
//     var
//         pureformula: Text[50];
//     begin
//         pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
//         curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
//     end;

//     procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
//     var
//         prEmployeeTrans: Record "PRL-Employee Transactions";
//     begin
//         /* prEmployeeTrans.RESET;
//          prEmployeeTrans.SETRANGE(prEmployeeTrans."Employee Code",EmpCode);
//          prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
//          prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
//          prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Month",Month);
//          prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Year",Year);
//          IF prEmployeeTrans.FIND('-') THEN BEGIN
//            prEmployeeTrans.Amount:=Amount;
//            prEmployeeTrans.MODIFY;
//          END; */

//     end;

//     procedure fnGetJournalDet(strEmpCode: Code[20])
//     var
//         SalaryCard: Record "HRM-Employee (D)";
//     begin
//         //Get Payroll Posting Accounts
//         if SalaryCard.Get(strEmpCode) then begin
//             if PostingGroup.Get(SalaryCard."Posting Group") then begin
//                 //Comment This for the Time Being

//                 PostingGroup.TestField("Salary Account");
//                 PostingGroup.TestField("Income Tax Account");
//                 PostingGroup.TestField("Net Salary Payable");
//                 PostingGroup.TestField("NSSF Employer Account");
//                 PostingGroup.TestField("Pension Employer Acc");

//                 TaxAccount := PostingGroup."Income Tax Account";
//                 salariesAcc := PostingGroup."Salary Account";
//                 PayablesAcc := PostingGroup."Net Salary Payable";
//                 NSSFEMPyer := PostingGroup."NSSF Employer Account";
//                 NSSFEMPyee := PostingGroup."NSSF Employee Account";
//                 NHIFEMPyee := PostingGroup."NHIF Employee Account";
//                 PensionEMPyer := PostingGroup."Pension Employer Acc";
//             end else begin
//                 Error('Please specify Posting Group in Employee No.  ' + strEmpCode);
//             end;
//         end;
//         //End Get Payroll Posting Accounts
//     end;

//     procedure fnGetSpecialTransAmount2(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean)
//     var
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prTransactionCodes: Record "PRL-Transaction Codes";
//         strExtractedFrml: Text[250];
//     begin
//         SpecialTranAmount := 0;
//         prTransactionCodes.Reset;
//         prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
//         if prTransactionCodes.Find('-') then begin
//             repeat
//                 prEmployeeTransactions.Reset;
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
//                 if prEmployeeTransactions.Find('-') then begin

//                     //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
//                     //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
//                     case intSpecTransID of
//                         intSpecTransID::"Defined Contribution":
//                             if prTransactionCodes."Is Formula" then begin
//                                 strExtractedFrml := '';
//                                 strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                                 SpecialTranAmount := SpecialTranAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//                             end else
//                                 SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

//                         intSpecTransID::"Life Insurance":
//                             SpecialTranAmount := SpecialTranAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

//                         //
//                         intSpecTransID::"Owner Occupier Interest":
//                             SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;


//                         intSpecTransID::"Home Ownership Savings Plan":
//                             SpecialTranAmount := SpecialTranAmount + prEmployeeTransactions.Amount;

//                         intSpecTransID::Morgage:
//                             begin
//                                 SpecialTranAmount := SpecialTranAmount + curReliefMorgage;

//                                 if SpecialTranAmount > curReliefMorgage then begin
//                                     SpecialTranAmount := curReliefMorgage
//                                 end;

//                             end;

//                     end;
//                 end;
//             until prTransactionCodes.Next = 0;
//         end;
//     end;

//     procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date) PaysPens: Boolean
//     var
//         pnTranCode: Record "PRL-Transaction Codes";
//         pnEmpTrans: Record "PRL-Employee Transactions";
//     begin
//         PaysPens := false;
//         pnEmpTrans.Reset;
//         pnEmpTrans.SetRange(pnEmpTrans."Employee Code", pnEmpCode);
//         pnEmpTrans.SetRange(pnEmpTrans."Payroll Period", pnPayperiod);
//         if pnEmpTrans.Find('-') then begin
//             repeat
//                 if pnTranCode.Get(pnEmpTrans."Transaction Code") then
//                     if pnTranCode."coop parameters" = pnTranCode."coop parameters"::Pension then
//                         PaysPens := true;
//             until pnEmpTrans.Next = 0;
//         end;
//     end;

//     procedure fnGetPensionAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
//     var
//         prEmployeeTransactions: Record "PRL-Employee Transactions";
//         prTransactionCodes: Record "PRL-Transaction Codes";
//         strExtractedFrml: Text[250];
//     begin
//         SpecialTransAmount := 0;
//         prTransactionCodes.Reset;
//         prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
//         prTransactionCodes.SetRange(prTransactionCodes.Pension, true);
//         if prTransactionCodes.Find('-') then begin
//             repeat
//                 prEmployeeTransactions.Reset;
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
//                 prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
//                 if prEmployeeTransactions.Find('-') then begin

//                     //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
//                     //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
//                     case intSpecTransID of
//                         intSpecTransID::"Defined Contribution":
//                             if (prTransactionCodes.Pension) then begin
//                                 if prTransactionCodes."Is Formula" then begin
//                                     strExtractedFrml := '';
//                                     strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
//                                     SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//                                 end else
//                                     SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;
//                             end;
//                     end;
//                 end;
//             until prTransactionCodes.Next = 0;
//         end;
//         SpecialTranAmount := SpecialTransAmount;
//     end;

//     procedure disabled_emp(var empNo: Code[20]; var Gross: Decimal) Dis_A: Boolean
//     var
//         hrEmp: Record "HRM-Employee (D)";
//     begin
//         if hrEmp.Get(empNo) then
//             Dis_A := hrEmp."Physical Disability";
//         if Dis_A = true then begin
//             if (Gross <= 150000) then
//                 Dis_A := false;
//         end;
//     end;

//     procedure fnGetEmployeeNSSF(curBaseAmount: Decimal) NSSF: Decimal
//     var
//         prNSSF: Record "prNSSF Tiers";
//     begin

//         prNSSF.Reset;
//         prNSSF.SetCurrentKey(prNSSF.Tier);
//         if prNSSF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
//                     NSSF := prNSSF."Tier 1 Employee Deduction";//prNSSF."Tier 1 Employee Deduction" + prNSSF."Tier 2 Employee Deduction";
//             until prNSSF.Next = 0;
//         end;
//     end;

//     procedure fnGetEmployerNSSF(curBaseAmount: Decimal) NSSF: Decimal
//     var
//         prNSSF: Record "prNSSF Tiers";
//     begin

//         prNSSF.Reset;
//         prNSSF.SetCurrentKey(prNSSF.Tier);
//         if prNSSF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
//                     NSSF := prNSSF."Tier 1 Employee Deduction";//prNSSF."Tier 1 Employer Contribution" + prNSSF."Tier 2 Employer Contribution";
//             until prNSSF.Next = 0;
//         end;
//     end;

//     procedure fnGetEmployeeNSSF_Tier(curBaseAmount: Decimal) NSSF: Text
//     var
//         prNSSF: Record "prNSSF Tiers";
//     begin

//         prNSSF.Reset;
//         prNSSF.SetCurrentKey(prNSSF.Tier);
//         if prNSSF.FindFirst then begin
//             repeat
//                 if ((curBaseAmount >= prNSSF."Lower Limit") and (curBaseAmount <= prNSSF."Upper Limit")) then
//                     NSSF := 'Tier ' + Format(prNSSF.Tier);
//             until prNSSF.Next = 0;
//         end;
//     end;

//     procedure fnCalculatedBasicPay(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; HoursWorked: Decimal; ExpectedWorkHours: Decimal) CalculatedBasicAmt: Decimal
//     begin
//         CalculatedBasicAmt := Round((HoursWorked / ExpectedWorkHours) * BasicSalary);
//     end;

//     procedure fnGetWelfareAmount(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
//     var
//         curLoanInt: Decimal;
//         intMonth: Integer;
//         intYear: Integer;
//         HRMWelfareLoanTiers: Record "HRM Welfare Loan Tiers";
//     begin
//         intMonth := Date2DMY(CurrPeriod, 2);
//         intYear := Date2DMY(CurrPeriod, 3);

//         if Welfare then begin
//             Clear(curLoanInt);
//             HRMWelfareLoanTiers.Reset;
//             HRMWelfareLoanTiers.SetFilter("Lower Limit", '%1|<%2', Balance, Balance);
//             HRMWelfareLoanTiers.SetFilter("Upper Limit", '%1|>%2', Balance, Balance);
//             if HRMWelfareLoanTiers.Find('-') then begin
//                 curLoanInt := HRMWelfareLoanTiers.Amount;
//             end;
//         end;
//         //Return the Amount
//         LnInterest := Round(curLoanInt);
//     end;

//     // local procedure ComputeLost1stand2ndOvertimes(PeriodMonth: Integer; PeriodYear: Integer; EmployeeNo: Code[20])
//     // var
//     //     HRMEmployeeD: Record "HRM-Employee (D)";
//     //     PRLVitalSetupInfo: Record "PRL-Vital Setup Info";
//     //     PRLSalaryCard: Record "PRL-Salary Card";
//     //     PRLTransactionCodes: Record "PRL-Transaction Codes";
//     //     PRLEmployeeTransactions: Record "PRL-Employee Transactions";
//     //     HRMSalaryGrades: Record "HRM-Job_Salary grade/steps";
//     //     PRLPayrollPeriods: Record "PRL-Payroll Periods";
//     //     LostHoursAmount: Decimal;
//     //     LostHoursRate: Decimal;
//     //     "1stOvertimeRate": Decimal;
//     //     "1stOvertimeAmount": Decimal;
//     //     "2ndOvertimeRate": Decimal;
//     //     "2ndOvertimeAmount": Decimal;
//     //     OtherChargeableAmountsLost: Integer;
//     //     OtherChargeableAmounts1st: Integer;
//     //     OtherChargeableAmounts2nd: Integer;
//     // begin
//     //     PRLVitalSetupInfo.RESET;
//     //     IF NOT (PRLVitalSetupInfo.FIND('-')) THEN ERROR('Vital Setup is Missing!');
//     //     PRLPayrollPeriods.RESET;
//     //     PRLPayrollPeriods.SETRANGE("Period Month", PeriodMonth);
//     //     PRLPayrollPeriods.SETRANGE("Period Year", PeriodYear);
//     //     IF NOT (PRLPayrollPeriods.FIND('-')) THEN ERROR('Specified Period is Not within the filters');
//     //     HRMEmployeeD.RESET;
//     //     HRMEmployeeD.SETRANGE("No.", EmployeeNo);
//     //     IF HRMEmployeeD.FIND('-') THEN BEGIN
//     //         HRMEmployeeD.TESTFIELD("Salary Grade");
//     //         HRMSalaryGrades.RESET;
//     //         HRMSalaryGrades.SETRANGE("Employee Category", HRMEmployeeD."Salary Category");
//     //         HRMSalaryGrades.SETRANGE("Salary Grade code", HRMEmployeeD."Salary Grade");
//     //         IF HRMSalaryGrades.FIND('-') THEN BEGIN
//     //             //  HRMSalaryGrades.TESTFIELD("Weekly Hours");
//     //             // Get The Basic Salary Details and Overtime and/Or Lost Hours
//     //             PRLSalaryCard.RESET;
//     //             PRLSalaryCard.SETRANGE("Employee Code", EmployeeNo);
//     //             PRLSalaryCard.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //             IF PRLSalaryCard.FIND('-') THEN BEGIN
//     //                 PRLSalaryCard.CALCFIELDS("1st Over Time Quantity");
//     //                 PRLSalaryCard.CALCFIELDS("2nd Overtime Quantity");
//     //                 PRLSalaryCard.CALCFIELDS("Lost Hours");
//     //                 //PRLVitalSetupInfo.TESTFIELD("Lost Hours Code");
//     //                 // PRLVitalSetupInfo.TESTFIELD("1st Overtime Code");
//     //                 // PRLVitalSetupInfo.TESTFIELD("2nd Overtime Code");
//     //                 ///////////////////////////////////////////////////////////////////// Other Charges for Lost
//     //                 IF PRLVitalSetupInfo."Lost Hours Based On" = PRLVitalSetupInfo."Lost Hours Based On"::"Basic with Tagged Transactions" THEN BEGIN
//     //                     // Get All Allowances Tagged as Include in Computation of Lost Hours
//     //                     CLEAR(OtherChargeableAmountsLost);
//     //                     PRLEmployeeTransactions.RESET;
//     //                     PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                     PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                     IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                         REPEAT
//     //                         BEGIN
//     //                             // Check if the Transaction is affected by Lost Hours
//     //                             PRLTransactionCodes.RESET;
//     //                             PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                             PRLTransactionCodes.SETRANGE("Affects Lost Hours", TRUE);
//     //                             IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                 OtherChargeableAmountsLost += PRLEmployeeTransactions.Amount;
//     //                             END;
//     //                         END;
//     //                         UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                     END;

//     //                 END ELSE
//     //                     IF PRLVitalSetupInfo."Lost Hours Based On" = PRLVitalSetupInfo."Lost Hours Based On"::Gross THEN BEGIN
//     //                         // Get All Allowances to Include in Computation of Lost Hours
//     //                         //Pick all Transactions Tagged as Allowances
//     //                         CLEAR(OtherChargeableAmountsLost);
//     //                         PRLEmployeeTransactions.RESET;
//     //                         PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                         PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                         IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                             REPEAT
//     //                             BEGIN
//     //                                 // Check if the Transaction is affected by Lost Hours
//     //                                 PRLTransactionCodes.RESET;
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Type", PRLTransactionCodes."Transaction Type"::Income);
//     //                                 IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                     OtherChargeableAmountsLost += PRLEmployeeTransactions.Amount;
//     //                                 END;
//     //                             END;
//     //                             UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                         END;
//     //                     END ELSE
//     //                         IF PRLVitalSetupInfo."Lost Hours Based On" = PRLVitalSetupInfo."Lost Hours Based On"::Basic THEN BEGIN
//     //                             OtherChargeableAmountsLost := 0;
//     //                         END;

//     //                 ///////////////////////////////////////////////////////////////////// Other Charges for 1stOvertime
//     //                 IF PRLVitalSetupInfo."1st Overtime Based On" = PRLVitalSetupInfo."1st Overtime Based On"::"Basic with Tagged Transactions" THEN BEGIN
//     //                     // Get All Allowances Tagged as Include in Computation of "1st Overtime Based On"
//     //                     CLEAR(OtherChargeableAmounts1st);
//     //                     PRLEmployeeTransactions.RESET;
//     //                     PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                     PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                     IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                         REPEAT
//     //                         BEGIN
//     //                             // Check if the Transaction is affected by Lost Hours
//     //                             PRLTransactionCodes.RESET;
//     //                             PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                             PRLTransactionCodes.SETRANGE("Affects Overtime", TRUE);
//     //                             IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                 OtherChargeableAmounts1st += PRLEmployeeTransactions.Amount;
//     //                             END;
//     //                         END;
//     //                         UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                     END;

//     //                 END ELSE
//     //                     IF PRLVitalSetupInfo."1st Overtime Based On" = PRLVitalSetupInfo."1st Overtime Based On"::Gross THEN BEGIN
//     //                         // Get All Allowances to Include in "1st Overtime Based On"
//     //                         //Pick all Transactions Tagged as Allowances
//     //                         CLEAR(OtherChargeableAmounts1st);
//     //                         PRLEmployeeTransactions.RESET;
//     //                         PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                         PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                         IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                             REPEAT
//     //                             BEGIN
//     //                                 // Check if the Transaction is affected by "1st Overtime Based On"
//     //                                 PRLTransactionCodes.RESET;
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Type", PRLTransactionCodes."Transaction Type"::Income);
//     //                                 IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                     OtherChargeableAmounts1st += PRLEmployeeTransactions.Amount;
//     //                                 END;
//     //                             END;
//     //                             UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                         END;
//     //                     END ELSE
//     //                         IF PRLVitalSetupInfo."1st Overtime Based On" = PRLVitalSetupInfo."1st Overtime Based On"::Basic THEN BEGIN
//     //                             OtherChargeableAmounts1st := 0;
//     //                         END;

//     //                 ///////////////////////////////////////////////////////////////////// Other Charges for 2ndOvertime
//     //                 IF PRLVitalSetupInfo."2nd Overtime Based On" = PRLVitalSetupInfo."2nd Overtime Based On"::"Basic with Tagged Transactions" THEN BEGIN
//     //                     // Get All Allowances Tagged as Include in Computation of "2nd Overtime Based On"
//     //                     CLEAR(OtherChargeableAmounts2nd);
//     //                     PRLEmployeeTransactions.RESET;
//     //                     PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                     PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                     IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                         REPEAT
//     //                         BEGIN
//     //                             // Check if the Transaction is affected by Lost Hours
//     //                             PRLTransactionCodes.RESET;
//     //                             PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                             PRLTransactionCodes.SETRANGE("Affects Overtime", TRUE);
//     //                             IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                 OtherChargeableAmounts2nd += PRLEmployeeTransactions.Amount;
//     //                             END;
//     //                         END;
//     //                         UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                     END;

//     //                 END ELSE
//     //                     IF PRLVitalSetupInfo."2nd Overtime Based On" = PRLVitalSetupInfo."2nd Overtime Based On"::Gross THEN BEGIN
//     //                         // Get All Allowances to Include in "2nd Overtime Based On"
//     //                         //Pick all Transactions Tagged as Allowances
//     //                         CLEAR(OtherChargeableAmounts2nd);
//     //                         PRLEmployeeTransactions.RESET;
//     //                         PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                         PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                         IF PRLEmployeeTransactions.FIND('-') THEN BEGIN
//     //                             REPEAT
//     //                             BEGIN
//     //                                 // Check if the Transaction is affected by "2nd Overtime Based On"
//     //                                 PRLTransactionCodes.RESET;
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLEmployeeTransactions."Transaction Code");
//     //                                 PRLTransactionCodes.SETRANGE("Transaction Type", PRLTransactionCodes."Transaction Type"::Income);
//     //                                 IF PRLTransactionCodes.FIND('-') THEN BEGIN
//     //                                     OtherChargeableAmounts2nd += PRLEmployeeTransactions.Amount;
//     //                                 END;
//     //                             END;
//     //                             UNTIL PRLEmployeeTransactions.NEXT = 0;
//     //                         END;
//     //                     END ELSE
//     //                         IF PRLVitalSetupInfo."2nd Overtime Based On" = PRLVitalSetupInfo."2nd Overtime Based On"::Basic THEN BEGIN
//     //                             OtherChargeableAmounts2nd := 0;
//     //                         END;
//     //                 // Compute Rates Here
//     //                 CLEAR(LostHoursAmount);
//     //                 CLEAR(LostHoursRate);
//     //                 CLEAR("1stOvertimeAmount");
//     //                 CLEAR("1stOvertimeRate");
//     //                 CLEAR("2ndOvertimeAmount");
//     //                 CLEAR("2ndOvertimeRate");
//     //                 //  LostHoursRate := ((PRLSalaryCard."Basic Pay" + OtherChargeableAmountsLost) / ((HRMSalaryGrades."Weekly Hours" * 52) / 12));
//     //                 //  "1stOvertimeRate" := ((PRLSalaryCard."Basic Pay") / ((HRMSalaryGrades."Weekly Hours" * 52) / 12)) * 1.5;
//     //                 // "2ndOvertimeRate" := ((PRLSalaryCard."Basic Pay") / ((HRMSalaryGrades."Weekly Hours" * 52) / 12)) * 2;




//     //                 PRLSalaryCard."Lost Hours Rate" := LostHoursRate;
//     //                 PRLSalaryCard."1st Overtime Rate" := "1stOvertimeRate";
//     //                 PRLSalaryCard."2nd Overtime Rate" := "2ndOvertimeRate";
//     //                 PRLSalaryCard.MODIFY;
//     //                 LostHoursAmount := Round((PRLSalaryCard."Lost Hours" * LostHoursRate), 0.01, '=');
//     //                 "1stOvertimeAmount" := PRLSalaryCard."1st Over Time Quantity" * "1stOvertimeRate";
//     //                 "2ndOvertimeAmount" := PRLSalaryCard."2nd Overtime Quantity" * "2ndOvertimeRate";
//     //                 // Update Lost Hours
//     //                 // Update 1st Allowances
//     //                 // Update 2nd Allowances
//     //                 PRLEmployeeTransactions.RESET;
//     //                 PRLEmployeeTransactions.SETRANGE("Employee Code", EmployeeNo);
//     //                 PRLEmployeeTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//     //                 PRLEmployeeTransactions.SETFILTER("Transaction Code", '%1|%2|%3', PRLVitalSetupInfo."Lost Hours Code", PRLVitalSetupInfo."1st Overtime Code",
//     //                 PRLVitalSetupInfo."2nd Overtime Code");
//     //                 //Clear Transaction entries Related to Loset Hours, 1st and 2nd Overtime
//     //                 IF PRLEmployeeTransactions.FIND('-') THEN PRLEmployeeTransactions.DELETEALL;
//     //                 //Create Transaction Entries
//     //                 //== Lost Hours
//     //                 PRLTransactionCodes.RESET;
//     //                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLVitalSetupInfo."Lost Hours Code");
//     //                 IF PRLTransactionCodes.FIND('-') THEN;
//     //                 PRLEmployeeTransactions.INIT;
//     //                 PRLEmployeeTransactions."Employee Code" := EmployeeNo;
//     //                 PRLEmployeeTransactions."Payroll Period" := PRLPayrollPeriods."Date Opened";
//     //                 PRLEmployeeTransactions."Period Year" := PeriodYear;
//     //                 PRLEmployeeTransactions."Period Month" := PeriodMonth;
//     //                 PRLEmployeeTransactions."Transaction Code" := PRLVitalSetupInfo."Lost Hours Code";
//     //                 PRLEmployeeTransactions."Transaction Name" := PRLTransactionCodes."Transaction Name" + ' Hours:' + FORMAT(PRLSalaryCard."Lost Hours") + ' Rate:' + FORMAT(LostHoursRate);
//     //                 PRLEmployeeTransactions."Recurance Index" := 99;
//     //                 PRLEmployeeTransactions.Balance := -LostHoursAmount;
//     //                 PRLEmployeeTransactions.Amount := -LostHoursAmount;
//     //                 // PRLEmployeeTransactions.INSERT(TRUE);
//     //                 //Create Transaction Entries
//     //                 //== 1st Overtime
//     //                 PRLTransactionCodes.RESET;
//     //                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLVitalSetupInfo."1st Overtime Code");
//     //                 IF PRLTransactionCodes.FIND('-') THEN;
//     //                 PRLEmployeeTransactions.INIT;
//     //                 PRLEmployeeTransactions."Employee Code" := EmployeeNo;
//     //                 PRLEmployeeTransactions."Payroll Period" := PRLPayrollPeriods."Date Opened";
//     //                 PRLEmployeeTransactions."Period Year" := PeriodYear;
//     //                 PRLEmployeeTransactions."Period Month" := PeriodMonth;
//     //                 PRLEmployeeTransactions."Transaction Code" := PRLVitalSetupInfo."1st Overtime Code";
//     //                 PRLEmployeeTransactions."Transaction Name" := PRLTransactionCodes."Transaction Name" + ' Hours:' + FORMAT(PRLSalaryCard."1st Over Time Quantity") + ' Rate:' + FORMAT("1stOvertimeAmount");
//     //                 PRLEmployeeTransactions."Recurance Index" := 99;
//     //                 PRLEmployeeTransactions.Balance := "1stOvertimeAmount";
//     //                 PRLEmployeeTransactions.Amount := "1stOvertimeAmount";
//     //                 //  PRLEmployeeTransactions.INSERT(TRUE);
//     //                 //Create Transaction Entries
//     //                 //== 2nd Overtime
//     //                 PRLTransactionCodes.RESET;
//     //                 PRLTransactionCodes.SETRANGE("Transaction Code", PRLVitalSetupInfo."2nd Overtime Code");
//     //                 IF PRLTransactionCodes.FIND('-') THEN;
//     //                 PRLEmployeeTransactions.INIT;
//     //                 PRLEmployeeTransactions."Employee Code" := EmployeeNo;
//     //                 PRLEmployeeTransactions."Payroll Period" := PRLPayrollPeriods."Date Opened";
//     //                 PRLEmployeeTransactions."Period Year" := PeriodYear;
//     //                 PRLEmployeeTransactions."Period Month" := PeriodMonth;
//     //                 PRLEmployeeTransactions."Transaction Code" := PRLVitalSetupInfo."2nd Overtime Code";
//     //                 PRLEmployeeTransactions."Transaction Name" := PRLTransactionCodes."Transaction Name" + ' Hours:' + FORMAT(PRLSalaryCard."2nd Overtime Quantity") + ' Rate:' + FORMAT("2ndOvertimeAmount");
//     //                 PRLEmployeeTransactions."Recurance Index" := 99;
//     //                 PRLEmployeeTransactions.Balance := "2ndOvertimeAmount";
//     //                 PRLEmployeeTransactions.Amount := "2ndOvertimeAmount";
//     //                 // PRLEmployeeTransactions.INSERT(TRUE);
//     //             END;// To be extended to include employees without Basic Salary
//     //         END ELSE
//     //             ERROR('Invalid Salary Grade &/Or Category');
//     //     END ELSE
//     //         ERROR('Employee Missing.');
//     // end;

//     local procedure GetBasicAndOtherAllowances(EmpStrNo: Code[20]; PerMonth: Integer; PerYaer: Integer; SumItems: Option " ","Basic","Basic & House") RetAmounts: Decimal
//     var
//         EmpTransactions: Record "PRL-Employee Transactions";
//         PRLSalaryCard: Record "PRL-Salary Card";
//         PRLPayrollPeriods: Record "PRL-Payroll Periods";
//         PRLTransactionCodes: Record "PRL-Transaction Codes";
//         PRLVitalSetupInfo: Record "PRL-Vital Setup Info";
//     begin
//         CLEAR(RetAmounts);
//         PRLVitalSetupInfo.RESET;
//         IF PRLVitalSetupInfo.FIND('-') THEN;
//         PRLPayrollPeriods.RESET;
//         PRLPayrollPeriods.SETRANGE("Period Month", PerMonth);
//         PRLPayrollPeriods.SETRANGE("Period Year", PerYaer);
//         IF PRLPayrollPeriods.FIND('-') THEN BEGIN
//             EmpTransactions.RESET;
//             EmpTransactions.SETRANGE("Employee Code", EmpStrNo);
//             EmpTransactions.SETRANGE("Transaction Code", PRLVitalSetupInfo."House Allowance Code");
//             EmpTransactions.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//             IF EmpTransactions.FIND('-') THEN;
//             PRLSalaryCard.RESET;
//             PRLSalaryCard.SETRANGE("Employee Code", EmpStrNo);
//             PRLSalaryCard.SETRANGE("Payroll Period", PRLPayrollPeriods."Date Opened");
//             IF PRLSalaryCard.FIND('-') THEN;

//             IF SumItems = SumItems::"Basic" THEN
//                 RetAmounts := PRLSalaryCard."Basic Pay"
//             ELSE
//                 IF SumItems = SumItems::"Basic & House" THEN
//                     RetAmounts := PRLSalaryCard."Basic Pay" + EmpTransactions.Amount;
//         END;
//     end;
// }
// // // Check if Formula Takes Basic and Any other Allowances 
// //            curTransAmount:=curTransAmount*prEmployeeTransactions."Rate Factor";
// //            IF prTransactionCodes."Is Rate of"=prTransactionCodes."Is Rate of"::Basic THEN 
// //            curTransAmount:=ROUND(curTransAmount*GetBasicAndOtherAllowances(strEmpCode,intMonth,intYear,SumItems::Basic))
// //            ELSE IF prTransactionCodes."Is Rate of"=prTransactionCodes."Is Rate of"::"Basic & House" THEN 
// //            curTransAmount:=ROUND(curTransAmount*GetBasicAndOtherAllowances(strEmpCode,intMonth,intYear,SumItems::"Basic & House"));
// //            prEmployeeTransactions.Amount:=curTransAmount;
// //            prEmployeeTransactions.MODIFY;
