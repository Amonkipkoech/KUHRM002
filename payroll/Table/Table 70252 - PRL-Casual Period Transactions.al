table 70252 "PRL-Casual Period Transactions"
{
    DrillDownPageID = "PRL-PeriodTransaction List";
    LookupPageID = "PRL-PeriodTransaction List";

    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HRMEmployeeD.Reset;
                HRMEmployeeD.SetRange("No.", "Employee Code");
                if HRMEmployeeD.Find('-') then begin
                    "Employee Category" := HRMEmployeeD."Employee Category";
                end;
            end;
        }
        field(2; "Transaction Code"; Text[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(3; "Group Text"; Text[30])
        {
            Description = 'e.g Statutory, Deductions, Tax Calculation etc';
        }
        field(4; "Transaction Name"; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Balance; Decimal)
        {
        }
        field(7; "Original Amount"; Decimal)
        {
        }
        field(8; "Group Order"; Integer)
        {
        }
        field(9; "Sub Group Order"; Integer)
        {
        }
        field(10; "Period Month"; Integer)
        {
        }
        field(11; "Period Year"; Integer)
        {
        }
        field(12; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
        }
        field(13; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
        }
        field(14; Membership; Code[50])
        {
            TableRelation = "PRL-Institutional Membership"."Institution No";
        }
        field(15; "Reference No"; Text[20])
        {
        }
        field(16; "Department Code"; Code[20])
        {
        }
        field(17; Lumpsumitems; Boolean)
        {
        }
        field(18; TravelAllowance; Code[20])
        {
        }
        field(19; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(20; "Company Deduction"; Boolean)
        {
            Description = 'Dennis- Added to filter out the company deductions esp: the Pensions';
        }
        field(21; "Emp Amount"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(22; "Emp Balance"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(23; "Journal Account Code"; Code[20])
        {
        }
        field(24; "Journal Account Type"; Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor;
        }
        field(25; "Post As"; Option)
        {
            OptionMembers = " ",Debit,Credit;
        }
        field(26; "Loan Number"; Code[30])
        {
        }
        field(27; "coop parameters"; Option)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(28; "Payroll Code"; Code[20])
        {
            TableRelation = "PRL-Payroll Type";
        }
        field(29; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(50000; "Total Statutories"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                      "Group Text" = CONST('STATUTORIES'),
                                                                      "Period Month" = FIELD("Period Month"),
                                                                      "Period Year" = FIELD("Period Year")));
            FieldClass = FlowField;
        }
        field(50001; "Employee Category"; Code[20])
        {
            TableRelation = "HRM-Staff Categories"."Category Code";
        }
        field(50002; Grouping; Code[20])
        {
        }
        field(50003; "View on Payslip"; Boolean)
        {
        }
        field(50004; "Group Section"; Option)
        {
            OptionCaption = ' ,Header,Lines,Footer';
            OptionMembers = " ",Header,Lines,Footer;
        }
        field(50005; "Current Instalment"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Current Instalment")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code")
        {
            SumIndexFields = Amount;
        }
        key(Key4; Membership)
        {
        }
        key(Key5; "Transaction Code", "Payroll Period", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Payroll Period", "Group Order", "Sub Group Order")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Employee Code", "Department Code")
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Transaction Name")
        {
        }
        key(Key9; "Group Order")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRMEmployeeD: Record "HRM-Employee (D)";
}

