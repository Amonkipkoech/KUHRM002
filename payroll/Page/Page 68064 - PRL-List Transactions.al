page 68064 "PRL-List Transactions"
{
    PageType = List;
    SourceTable = "PRL-Employee Transactions";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Visible = false;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;

                    // trigger OnValidate()
                    // begin
                    //     blnIsLoan := false;
                    //     if objTransCodes.Get(Rec."Transaction Code") then
                    //         Rec."Transaction Name" := objTransCodes."Transaction Name";

                    //     Rec."Payroll Period" := SelectedPeriod;
                    //     Rec."Period Month" := PeriodMonth;
                    //     Rec."Period Year" := PeriodYear;


                    //     if objTransCodes."Special Transactions" = 8 then blnIsLoan := true;

                    //     /*IF objTransCodes."Is Formula"=TRUE THEN
                    //     BEGIN
                    //      empCode:="Employee Code";
                    //      CLEAR(objOcx);
                    //      curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes.Formula);
                    //      Amount:=curTransAmount;
                    //     END;
                    //     */
                    //     //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                    //     curTransAmount := 0;
                    //     /*
                    //     IF objTransCodes."Include Employer Deduction"=TRUE THEN
                    //     BEGIN
                    //       curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes."Is Formula for employer");
                    //       "Employer Amount":=curTransAmount;
                    //     END;
                    //     */

                    // end;
                }

                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("No of Units"; Rec."No of Units")
                {
                    ToolTip = 'Specifies the value of the No of Units field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //TODO calculate amount based on days and employees Basic salary

                    end;
                }

                field(Balance; Rec.Balance)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("Recurance Index"; Rec."Recurance Index")
                {
                    ApplicationArea = all;
                }
                field("Loan Termination Reason"; Rec."Loan Termination Reason")
                {
                    ApplicationArea = all;
                }
                field("Loan Termination Date"; Rec."Loan Termination Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Terminated by"; Rec."Loan Terminated by")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("#of Repayments"; Rec."#of Repayments")
                {
                    ApplicationArea = all;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        if blnIsLoan = true then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("Amortized Loan Total Repay Amt"; Rec."Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = all;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = all;
                }
                field(Membership; Rec.Membership)
                {
                    ApplicationArea = all;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = all;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = all;
                }
                field("Stop for Next Period"; Rec."Stop for Next Period")
                {
                    ApplicationArea = all;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = all;
                }
                field("Employer Balance"; Rec."Employer Balance")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
    end;

    var
        objTransCodes: Record "PRL-Transaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "PRL-Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "PRL-Employee Transactions";
        transType: Text[30];
        objOcx: Codeunit prPayrollProcessing;
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];


}
