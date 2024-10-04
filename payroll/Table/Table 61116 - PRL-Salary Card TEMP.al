table 61116 "PRL-Salary Card TEMP"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash';
            OptionMembers = "Bank Transfer",Cheque,Cash,Reli,OFI;
        }
        field(4; Currency; Code[20])
        {
            TableRelation = "PRL-Currencies"."Currency Code";
        }
        field(5; "Pays NSSF"; Boolean)
        {
        }
        field(6; "Pays NHIF"; Boolean)
        {
        }
        field(7; "Pays PAYE"; Boolean)
        {
        }
        field(8; "Payslip Message"; Text[100])
        {
        }
        field(9; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info"."Basic Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info"."Gross Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cumm NetPay"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info"."Net Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cumm Allowances"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Group Order" = FILTER(1),
                                                                      "Sub Group Order" = FILTER(2),
                                                                      "Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cumm Deductions"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info".Deductions WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Suspend Pay"; Boolean)
        {
        }
        field(15; "Suspension Date"; Date)
        {
        }
        field(16; "Suspension Reasons"; Text[200])
        {
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
        }
        field(19; "Cumm PAYE"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info".PAYE WHERE("Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info".NSSF WHERE("Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = FILTER('637'),
                                                                      "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(22; "Cumm HELB"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                      "Transaction Code" = FILTER('320')));
            FieldClass = FlowField;
        }
        field(23; "Cumm NHIF"; Decimal)
        {
            CalcFormula = Sum("PRL-Employee P9 Info".NHIF WHERE("Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(24; "Bank Account Number"; Code[50])
        {
        }
        field(25; "Bank Branch"; Code[50])
        {
        }
        field(26; "Employee's Bank"; Code[50])
        {
        }
        field(27; "Posting Group"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee;
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }
}

