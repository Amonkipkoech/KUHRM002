table 61337 "GEN-Medical Scheme"
{

    Caption = 'HRM-Medical Insurance Info.';
    fields
    {
        field(1; "Payroll No."; Code[20])
        {
        }
        field(2; "Principal Insurance Number"; Code[30])
        {
        }
        field(3; "Number of Dependents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HRM-Insurance Dependants" where("Payroll No." = field("Payroll No.")));
        }
        field(4; "Insurance Contract Number"; Code[30])
        {
        }
        field(5; "Group Life Cover"; Boolean)
        {
        }
        field(6; "Group Personal Accident & WIBA"; Boolean)
        {
        }

    }

    keys
    {
        key(Key1; "Payroll No.", "Principal Insurance Number")
        {
        }
    }

    fieldgroups
    {
    }
}

