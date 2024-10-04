table 75000 "HRM-Training Evaluation Action"
{

    fields
    {
        field(1; "Training Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Sequence; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Action"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "How to implement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Time Lines"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Training Code", Sequence, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

