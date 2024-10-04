table 61791 "HRM-Salary Increament Register"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Increament Month"; Code[20])
        {
        }
        field(3; "Increament Year"; Integer)
        {
        }
        field(4; "User ID"; Code[20])
        {
        }
        field(5; "Prev. Salary"; Decimal)
        {
        }
        field(6; "Current Salary"; Decimal)
        {
        }
        field(7; "Job Grade"; Code[20])
        {
        }
        field(8; "Job Category"; Code[50])
        {
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

