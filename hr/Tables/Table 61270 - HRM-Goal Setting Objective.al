table 61270 "HRM-Goal Setting Objective"
{

    fields
    {
        field(1; "No Series"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal Code"; Code[50])
        {
            TableRelation = "HRM-Appraisal Card"."Appraisal Code";
        }
        field(3; Goal; Text[250])
        {
            //todo  TableRelation = "ACA-Students".RegNo;
        }
        field(4; Deliverable; Text[250])
        {
        }
        field(5; "Date Created"; DateTime)
        {
        }
        field(6; EmployeeNo; Text[10])
        {
        }
    }

    keys
    {
        key(Key1; "No Series")
        {
        }
    }

    fieldgroups
    {
    }
}

