table 70250 "PRL-Casual Payroll Periods"
{

    fields
    {
        field(1; "Date Openned"; Date)
        {
        }
        field(2; "Period Month"; Integer)
        {
        }
        field(3; "Period Year"; Integer)
        {
        }
        field(4; "Period Name"; Code[100])
        {
        }
        field(5; "Casuals Daily Rate"; Decimal)
        {
        }
        field(6; "No. of Instalments"; Integer)
        {
        }
        field(7; "Current Instalment"; Integer)
        {
        }
        field(8; "Instalment Description"; Option)
        {
            OptionCaption = 'Monthly,Half,Quater,Week';
            OptionMembers = Monthly,Half,Quater,Week;
        }
        field(9; Closed; Boolean)
        {
        }
        field(10; "Period Instalment Prefix"; Option)
        {
            OptionCaption = ' ,st,nd,rd,th';
            OptionMembers = " ",st,nd,rd,th;
        }
        field(11; "Closed By"; Code[20])
        {
        }
        field(12; "Date Closed"; Date)
        {
        }
        field(13; "No of Days"; Decimal)
        {
        }
        field(14; "Payslip Message"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Date Openned", "Current Instalment")
        {
        }
    }

    fieldgroups
    {
    }
}

