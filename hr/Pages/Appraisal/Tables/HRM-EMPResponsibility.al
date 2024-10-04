table 85608 "HRM-Employee Responsibility"
{
    fields
    {
        field(1; "Responsibility Code"; Code[10])
        {

        }
        field(2; Responsibility; Text[100])
        {

        }

    }
    keys
    {
        key(Key1; "Responsibility Code")
        {
            Clustered = true;
        }
    }
}