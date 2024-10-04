table 61269 "HRM-Interpersonal Factors"
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
        field(3; "Interpersonal Factors"; Code[200])
        {
            //todo TableRelation = "ACA-Students".RegNo;
        }
        field(4; "IF Description"; Text[250])
        {
        }
        field(5; "Supervisor Comments"; Text[250])
        {
        }
        field(6; "Appraisee Comments"; Text[250])
        {
        }
        field(7; Ratings; Option)
        {
            OptionCaption = 'Behaviour contradicts specific value (0),Displays correct behaviour (1),Proactively embarrasses value (2),Role model (3)';
            OptionMembers = "Behaviour contradicts specific value (0)","Displays correct behaviour (1)","Proactively embarrasses value (2)","Role model (3)";
        }
        field(8; "Examples Behaviours"; Text[250])
        {
        }
        field(9; "Supervisor Ratings"; Option)
        {
            OptionMembers = "Unsatisfactory (1)","Development Required (2)","Meets Expectation (3)","Exceeds Expectation (4)","Exceptional (5) ";
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

