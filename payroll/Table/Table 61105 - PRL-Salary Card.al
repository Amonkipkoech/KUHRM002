table 61105 "PRL-Salary Card"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";
                
                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran.Amount:="Basic Pay"*(10/100);
                  prEmpTran.MODIFY;
                  END;
                  END;
                  END; */

            end;
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[20])
        {
            TableRelation = "PRL-Currencies"."Currency Code";
        }
        field(5; "Pays NSSF"; Boolean)
        {

            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";
                
                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF NOT prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran2.INIT;
                  prEmpTran2."Employee Code":="Employee Code";
                  prEmpTran2."Transaction Code":=prTrans."Transaction Code";
                  prEmpTran2."Period Month":=objPeriod."Period Month";
                  prEmpTran2."Period Year":=objPeriod."Period Year";
                  prEmpTran2."Payroll Period":=objPeriod."Date Opened";
                  prEmpTran2."Transaction Name":=prTrans."Transaction Name";
                  prEmpTran2.Amount:="Basic Pay"*(10/100);
                  prEmpTran2.INSERT;
                  END;
                  END;
                  END; */

            end;
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
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Group Order" = FILTER(8),
                                                                      "Sub Group Order" = FILTER(0 | 1),
                                                                      "Employee Code" = FIELD("Employee Code"),
                                                                      "Transaction Code" = FILTER(<> 'Total Deductions')));
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
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = FILTER('PAYE'),
                                                                      "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = FILTER('NSSF'),
                                                                      "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = FILTER('0007'),
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
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                      "Transaction Code" = FILTER('NHIF')));
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
        field(28; "Cumm Employer Pension"; Decimal)
        {
            CalcFormula = Sum("PRL-Employer Deductions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                      "Transaction Code" = CONST('0007')));
            FieldClass = FlowField;
        }
        field(29; "Pays Pension"; Boolean)
        {
        }
        field(50000; "Current Round Up"; Decimal)
        {
        }
        field(50001; "Current Round Down"; Decimal)
        {
        }
        field(50002; "Preveous Round Down"; Decimal)
        {
        }
        field(50003; "Preveous Round Up"; Decimal)
        {
        }
        field(50004; "Period Month"; Integer)
        {
        }
        field(50005; "Period Year"; Integer)
        {
        }
        field(50006; "Current Month"; Integer)
        {
        }
        field(50007; "Current Year"; Integer)
        {
        }
        field(50008; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(50009; Closed; Boolean)
        {
            CalcFormula = Lookup("PRL-Payroll Periods".Closed WHERE("Date Opened" = FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(60014; "Employee Category"; Code[20])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Employee Category" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
            TableRelation = "HRM-Staff Categories"."Category Code";
        }
        field(60015; "Lost Hours"; Decimal)
        {
            CalcFormula = Sum("HRM-Time Register".Quantity WHERE("Lost Time" = FILTER(true),
                                                                  "Employee No." = FIELD("Employee Code"),
                                                                  "Payment Period" = FIELD("Payroll Period")));
            FieldClass = FlowField;
        }
        field(60016; "1st Over Time Quantity"; Decimal)
        {
            CalcFormula = Sum("HRM-Time Register".Quantity WHERE("Over Time" = FILTER(true),
                                                                  "Employee No." = FIELD("Employee Code"),
                                                                  "Payment Period" = FIELD("Payroll Period"),
                                                                  "Day Type" = filter('WORKING')
                                                                  ));
            FieldClass = FlowField;
        }
        field(60017; "2nd Overtime Quantity"; Decimal)
        {
            CalcFormula = Sum("HRM-Time Register".Quantity WHERE("Over Time" = FILTER(true),
                                                                  "Employee No." = FIELD("Employee Code"),
                                                                  "Payment Period" = FIELD("Payroll Period"),
                                                                  "Day Type" = filter('NONWORKING')
                                                                  ));
            FieldClass = FlowField;
        }
        field(60018; "1st Overtime Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "2nd Overtime Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60020; "Lost Hours Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Current Month Flow"; Integer)
        {
            CalcFormula = Lookup("PRL-Payroll Periods"."Period Month" WHERE(Closed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60022; "Current Year Flow"; Integer)
        {
            CalcFormula = Lookup("PRL-Payroll Periods"."Period Year" WHERE(Closed = FILTER(false)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RecType := RecType::Sal;
        ValidateUser.validateUser(RecType);
    end;

    trigger OnInsert()
    begin
        /* objPeriod.RESET;
         objPeriod.SETFILTER(objPeriod.Closed,'=%1',FALSE);
         objPeriod.SETFILTER(objPeriod."Date Opened",'<>%1',0D);
         IF objPeriod.FIND('-') THEN BEGIN
           "Period Month":=objPeriod."Period Month";
           "Period Year":=objPeriod."Period Year";
           "Payroll Period":=objPeriod."Date Opened";
         END; */

        RecType := RecType::Sal;
        ValidateUser.validateUser(RecType);

    end;

    trigger OnModify()
    begin
        RecType := RecType::Sal;
        ValidateUser.validateUser(RecType);
    end;

    trigger OnRename()
    begin
        RecType := RecType::Sal;
        ValidateUser.validateUser(RecType);
    end;

    var
        prEmpTran: Record "PRL-Employee Transactions";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        prTrans: Record "PRL-Transaction Codes";
        prEmpTran2: Record "PRL-Employee Transactions";
        ValidateUser: Codeunit "Validate User Permissions";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
}

