table 85539 "HRM-Prof Qualification"
{


    fields
    {
        field(1; "Application No"; Code[10])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }
        field(2; "Proffesional Qualification"; Text[100])
        {
        }

        field(3; "Awarding Body"; Text[100])
        {

        }
        field(4; "Year Awarded"; Code[10])
        {

        }
    }

    keys
    {
        key(Key1; "Application No", "Proffesional Qualification", "Awarding Body")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    

}