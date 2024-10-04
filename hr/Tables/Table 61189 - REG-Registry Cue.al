table 61189 "REG-Registry Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "New Files"; Integer)
        {
            CalcFormula = Count("REG-Registry Files" WHERE("File Status" = FILTER(New)));
            FieldClass = FlowField;
        }
        field(3; "Bring-up Files"; Integer)
        {
            CalcFormula = Count("REG-Registry Files" WHERE("File Status" = FILTER(Bring_up)));
            FieldClass = FlowField;
        }
        field(4; "Archived Files"; Integer)
        {
            CalcFormula = Count("REG-Registry Files" WHERE("File Status" = FILTER(Archived)));
            FieldClass = FlowField;
        }
        field(5; "New Inbound Mails"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Incoming Mail (Internal)" | "Incoming Mail (External)"),
                                                           "Mail Status" = FILTER(New)));

        }
        field(6; "Mail Sorting"; Integer)
        {
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Incoming Mail (Internal)" | "Incoming Mail (External)"),
                                                           "Mail Status" = FILTER(Sorted)));
            FieldClass = FlowField;
        }
        field(7; "Sorted Mails"; Integer)
        {
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Incoming Mail (Internal)" | "Incoming Mail (External)"),
                                                           "Mail Status" = FILTER(Sorted)));
            FieldClass = FlowField;
        }
        field(8; "New Outbound Mails"; Integer)
        {
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Outgoing Mail (Internal)" | "Outgoing Mail (External)"),
                                                           "Mail Status" = FILTER(New)));
            FieldClass = FlowField;
        }
        field(9; Dispatch; Integer)
        {
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Outgoing Mail (Internal)" | "Outgoing Mail (External)"),
                                                           "Mail Status" = FILTER(Dispatch)));
            FieldClass = FlowField;
        }
        field(10; Dispatched; Integer)
        {
            CalcFormula = Count("REG-Mail Register" WHERE("Direction Type" = FILTER("Outgoing Mail (Internal)" | "Outgoing Mail (External)"),
                                                           "Mail Status" = FILTER(Dispatched)));
            FieldClass = FlowField;
        }
        field(11; "Active Files"; Integer)
        {
            CalcFormula = Count("REG-Registry Files" WHERE("File Status" = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(12; "Partially Active"; Integer)
        {
            CalcFormula = Count("REG-Registry Files" WHERE("File Status" = FILTER("Partially Active")));
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

