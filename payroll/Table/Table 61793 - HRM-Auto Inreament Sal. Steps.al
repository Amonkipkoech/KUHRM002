table 61793 "HRM-Auto Inreament Sal. Steps"
{

    fields
    {
        field(1; "Employee Category"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(2; "Salary Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Salary Grades"."Salary Grade";
        }
        field(3; Step; Integer)
        {
            NotBlank = true;
        }
        field(4; "Basic Salary"; Decimal)
        {
        }
         field(5; "Stage Code"; Code[20])
        {

        }
        
    }

    keys
    {
        key(Key1; "Employee Category", "Salary Grade", Step)
        {
        }
    }

    fieldgroups
    {
    }
}

