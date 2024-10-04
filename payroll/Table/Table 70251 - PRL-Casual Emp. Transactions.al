table 70251 "PRL-Casual Emp. Transactions"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin

                blnIsLoan := false;
                if objTransCodes.Get("Transaction Code") then
                    "Transaction Name" := objTransCodes."Transaction Name";
                "Payroll Period" := SelectedPeriod;
                "Period Month" := PeriodMonth;
                "Period Year" := PeriodYear;
                if objTransCodes."Special Transactions" = 8 then blnIsLoan := true;
            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {

            trigger OnValidate()
            begin
                /* IF Balance=0 THEN
                  IF "Loan Termination Reason"='' THEN
                    ERROR('Provide a termination reason first!');
            */

            end;
        }
        field(6; "Original Amount"; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(11; Membership; Code[20])
        {
            TableRelation = "PRL-Institutional Membership"."Institution No";
        }
        field(12; "Reference No"; Text[100])
        {
        }
        field(13; integera; Integer)
        {
        }
        field(14; "Employer Amount"; Decimal)
        {
        }
        field(15; "Employer Balance"; Decimal)
        {
        }
        field(16; "Stop for Next Period"; Boolean)
        {
        }
        field(17; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(18; "Start Date"; Date)
        {
        }
        field(19; "End Date"; Date)
        {
        }
        field(20; "Loan Number"; Code[30])
        {
        }
        field(21; "Payroll Code"; Code[20])
        {
            TableRelation = "PRL-Payroll Type";
        }
        field(22; "No of Units"; Decimal)
        {
        }
        field(23; Suspended; Boolean)
        {
        }
        field(24; "Transaction Type"; Option)
        {
            CalcFormula = Lookup("PRL-Transaction Codes"."Transaction Type" WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Income,Deduction;
        }
        field(25; "Loan Account No"; Code[30])
        {
        }
        field(26; "Emp Count"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE("No." = FIELD("Employee Code"),
                                                          Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(27; "PV Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(28; "Emp Status"; Option)
        {
            CalcFormula = Lookup("HRM-Employee (D)".Status WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(29; "Recurance Index"; Integer)
        {
        }
        field(30; "Loan Termination Date"; Date)
        {
        }
        field(31; "Loan Termination Reason"; Text[250])
        {

            trigger OnValidate()
            begin
                if "Loan Terminated by" = '' then begin
                    "Loan Termination Date" := Today;
                    "Loan Terminated by" := UserId;
                    Modify;
                end else begin
                    if "Loan Terminated by" <> UserId then Error('The reason can only be modified by ' + "Loan Terminated by");
                end;
            end;
        }
        field(32; "Loan Terminated by"; Code[20])
        {
        }
        field(33; "Current Instalment"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No", "Current Instalment")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RecType := RecType::EmpTrans;
        ValidateUser.validateUser(RecType);
    end;

    trigger OnInsert()
    begin
        "Recurance Index" := 999;

        RecType := RecType::EmpTrans;
        ValidateUser.validateUser(RecType);
    end;

    trigger OnModify()
    begin
        RecType := RecType::EmpTrans;
        ValidateUser.validateUser(RecType);
    end;

    trigger OnRename()
    begin
        RecType := RecType::EmpTrans;
        ValidateUser.validateUser(RecType);
    end;

    var
        Transcode: Record "PRL-Transaction Codes";
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
        ValidateUser: Codeunit "Validate User Permissions";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
}

