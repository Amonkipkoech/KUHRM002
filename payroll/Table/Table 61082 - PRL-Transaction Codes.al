table 61082 "PRL-Transaction Codes"

{
    DataCaptionFields = "Transaction Name";
    DrillDownPageID = "PRL-List TransCode";
    LookupPageID = "PRL-List TransCode";

    fields
    {
        field(1; "Transaction Code"; Code[50])
        {
            Description = 'Unique Trans line code';
        }
        field(3; "Transaction Name"; Text[100])
        {
            Description = 'Description';
        }
        field(4; "Balance Type"; Option)
        {
            Description = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(5; "Transaction Type"; Option)
        {
            Description = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(6; Frequency; Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(7; "Is Cash"; Boolean)
        {
            Description = 'Does staff receive cash for this transaction';
        }
        field(8; Taxable; Boolean)
        {
            Description = 'Is it taxable or not';
        }
        field(9; "Is Formula"; Boolean)
        {
            Description = 'Is the transaction based on a formula';
        }
        field(10; Formula; Text[200])
        {
            Description = '[Formula] If the above field is "Yes", give the formula';
        }
        field(16; "Amount Preference"; Option)
        {
            Description = 'Either (Posted Amount), (Take Higher) or (Take Lower)';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(18; "Special Transactions"; Option)
        {
            Description = 'Represents all Special Transactions';
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters,Morgage,Gratuity,Insurance Relief,Allowance Recovery,Staff Welfare';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Allowance Recovery","Staff Welfare";
        }
        field(21; "Deduct Premium"; Boolean)
        {
            Description = '[Insurance] Should the Premium be treated as a payroll deduction?';
        }
        field(26; "Interest Rate"; Decimal)
        {
            Description = '[Loan] If above is "Yes", give the interest rate';
        }
        field(28; "Repayment Method"; Option)
        {
            Description = '[Loan] Reducing,Straight line';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(29; "Fringe Benefit"; Boolean)
        {
            Description = '[Loan] should the loan be treated as a Fringe Benefit?';
        }
        field(30; "Employer Deduction"; Boolean)
        {
            Description = 'Caters for Employer Deductions';
            trigger OnValidate()
            begin
                TestField(AccountName);
                TestField(ReceivingBank);
                TestField(RecevingBranch);
                TestField(AccountNo);
            end;
        }
        field(31; isHouseAllowance; Boolean)
        {
            Description = 'Flags if its house allowance - Dennis';
        }
        field(32; "Include Employer Deduction"; Boolean)
        {
            Description = 'Is the transaction to include the employer deduction? - Dennis';
        }
        field(33; "Is Formula for employer"; Text[200])
        {
            Description = '[Is Formula for employer] If the above field is "Yes", give the Formula for employer Dennis';
        }
        field(34; "Transaction Code old"; Code[50])
        {
            Description = 'Old Unique Trans line code - Dennis';
        }
        field(35; "GL Account"; Code[50])
        {
            Description = 'to post to GL account - Dennis';
            TableRelation = "G/L Account"."No.";
        }
        field(36; "GL Employee Account"; Code[50])
        {
            Description = 'to post to GLemployee  account - Dennis';
        }
        field(37; "coop parameters"; Option)
        {
            Caption = 'Other Categorization';
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(38; "IsCoop/LnRep"; Boolean)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
        }
        field(39; "Deduct Mortgage"; Boolean)
        {
        }
        field(40; Subledger; Option)
        {
            OptionMembers = " ",Customer,Vendor;
        }
        field(41; Welfare; Boolean)
        {
        }
        field(42; CustomerPostingGroup; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(43; Pension; Boolean)
        {
        }
        field(44; "Affects Overtime"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Affects Lost Hours"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Calculate from Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Is a Rate"; Boolean)
        {

        }
        field(48; "Is Rate of"; Option)
        {
            OptionCaption = 'Basic Pay';
            OptionMembers = "Basic Pay","Basic & House Allowance";
        }
        field(49; "Mortgage Interest"; Boolean)
        {

        }
        field(50; "ReceivingBank"; code[20])
        {

        }
        field(51; RecevingBranch; text[100])
        {

        }
        field(52; AccountNo; code[20])
        {

        }
        field(53; BankCode; code[20])
        {

        }
        field(54; AccountName; text[100])
        {

        }
        field(55; "External Deduction"; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(AccountName);
                TestField(ReceivingBank);
                TestField(RecevingBranch);
                TestField(AccountNo);
            end;
        }





    }

    keys
    {
        key(Key1; "Transaction Code", "Transaction Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RecType := RecType::prTrans;
        //todo  ValidateUser.validateUser(RecType);
    end;

    trigger OnInsert()
    begin
        RecType := RecType::prTrans;
        //ValidateUser.validateUser(RecType);
    end;

    trigger OnModify()
    begin
        RecType := RecType::prTrans;
        //ValidateUser.validateUser(RecType);
    end;

    trigger OnRename()
    begin
        RecType := RecType::prTrans;
        //ValidateUser.validateUser(RecType);
    end;

    var
        //todo ValidateUser: Codeunit "Validate User Permissions";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
}


