page 70251 "PRL-Casual Emp. Transactions"
{
    PageType = List;
    SourceTable = "PRL-Casual Emp. Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        blnIsLoan := false;
                        if objTransCodes.Get(Rec."Transaction Code") then
                            Rec."Transaction Name" := objTransCodes."Transaction Name";
                        Rec."Payroll Period" := SelectedPeriod;
                        Rec."Period Month" := PeriodMonth;
                        Rec."Period Year" := PeriodYear;
                    end;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = all;
                }
                field("Recurance Index"; Rec."Recurance Index")
                {
                    ApplicationArea = all;
                }
                field("Current Instalment"; Rec."Current Instalment")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
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
            SelectedPeriod := objPeriod."Date Openned";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Openned"));
        Rec.SetFilter("Current Instalment", Format(objPeriod."Current Instalment"));
    end;

    var
        objTransCodes: Record "PRL-Transaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Casual Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "PRL-Casual Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "PRL-Casual Emp. Transactions";
        transType: Text[30];
        objOcx: Codeunit "prPayrollProcessing Casual";
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
}

