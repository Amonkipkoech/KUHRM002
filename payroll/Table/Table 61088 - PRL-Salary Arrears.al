table 61088 "PRL-Salary Arrears"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; "Start Date"; Date)
        {
            Description = 'From when do we back date';
        }
        field(4; "End Date"; Date)
        {
            Description = 'Upto when do we back date';
        }
        field(5; "Salary Arrears"; Decimal)
        {
        }
        field(6; "PAYE Arrears"; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Current Basic"; Decimal)
        {
        }
        field(10; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(11; Number; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Period Month", "Period Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            "Period Month" := PayPeriod."Period Month";
        "Period Year" := PayPeriod."Period Year";

        //Get the Salary Arrears code
        TransCode.SetRange(TransCode."Special Transactions", 7);
        if TransCode.Find('-') then
            "Transaction Code" := TransCode."Transaction Code";

        //Get the staff current salary
        if SalCard.Get("Employee Code") then begin
            "Current Basic" := SalCard."Basic Pay";
        end;
    end;

    var
        SalCard: Record "PRL-Salary Card";
        TransCode: Record "PRL-Transaction Codes";
        PayPeriod: Record "PRL-Payroll Periods";
}

