table 85515 "HRM-Departmental Tragets"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; objCode; Code[5])
        {
        }
        field(2; Lineno; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "PF. No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }
        field(4; Objective; Text[300])
        {

        }
        field(5; "Department Code"; code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(6; "Academic Year"; code[20])
        {
            TableRelation = "HRM-Appraisal Periods";
        }
    }

    keys
    {
        key(Key1; objCode, Lineno)
        {
            Clustered = true;
        }
    }



}