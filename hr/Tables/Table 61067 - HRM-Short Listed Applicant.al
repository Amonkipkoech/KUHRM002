table 61067 "HRM-Short Listed Applicant"
{

    fields
    {
        field(1; "Short Listed ID"; Integer)
        {
        }
        field(2; "Job ID"; Code[20])
        {
        }
        field(3; "No of Qualification Required"; Integer)
        {
        }
        field(4; "No of Qualification Attained"; Integer)
        {
        }
        field(5; Difference; Integer)
        {
        }
        field(6; Name; Text[100])
        {
        }
        field(7; "Job Title"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Short Listed ID", "Job ID")
        {
        }
    }

    fieldgroups
    {
    }
}

