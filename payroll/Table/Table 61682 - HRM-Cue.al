table 61682 "HRM-Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Employee-Active"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(3; "Employee-Male"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Male)));
            FieldClass = FlowField;
        }
        field(4; "Employee-Female"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Female)));
            FieldClass = FlowField;
        }
        field(5; "Employee-InActive"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Inactive)));
            FieldClass = FlowField;
        }
        field(6; "Employee-Active (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(7; "Employee-Male (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Male)));
            FieldClass = FlowField;
        }
        field(8; "Employee-Female (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Female)));
            FieldClass = FlowField;
        }
        field(9; "Employee-InActive (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(<> Active)));
            FieldClass = FlowField;
        }
        field(10; "Active Casulals (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Casuals)));
            FieldClass = FlowField;
        }
        field(11; "Active Permanent (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Permanent)));
            FieldClass = FlowField;
        }
        field(12; "Active Casula (Female) (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Casuals),
                                                          Gender = FILTER(Female)));
            FieldClass = FlowField;
        }
        field(13; "Active Casula (Male) (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Casuals),
                                                          Gender = FILTER(Male)));
            FieldClass = FlowField;
        }
        field(14; "Active Permanent (Female) (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Permanent),
                                                          Gender = FILTER(Female)));
            FieldClass = FlowField;
        }
        field(15; "Active Permanent (Male) (PR)"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Status = FILTER(Active),
                                                          "Employee Type" = FILTER(Permanent),
                                                          Gender = FILTER(Male)));
            FieldClass = FlowField;
        }
        field(16; "Payroll Emp Count"; Integer)
        {
            CalcFormula = count("HRM-Employee (D)" where("Include In Payroll" = filter(true)));
            FieldClass = Flowfield;
        }
        field(17; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE("Termination Category" = FILTER(= " ")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

