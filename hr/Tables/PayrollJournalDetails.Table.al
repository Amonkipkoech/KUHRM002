table 61837 "Payroll Journal Details"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; "Transaction Name"; Code[250])
        {
        }
        field(4; "G/L Account"; Code[20])
        {
        }
        field(5; "Period Month"; Integer)
        {
        }
        field(6; "Period Year"; Integer)
        {
        }
        field(7; "Posting Description"; Text[200])
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Post as"; Option)
        {
            OptionCaption = ' ,Debit,Credit';
            OptionMembers = " ",Debit,Credit;
        }
        field(24; "Journal Account Type"; Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor;
        }
        field(27; "coop parameters"; Option)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(28; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Campus; code[20])
        {

        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Department Code")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

