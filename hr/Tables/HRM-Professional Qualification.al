table 50006 "HRM-Professional Qualification"
{

    fields
    {
        field(1; "Payroll No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            Editable = false;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Internal,External,Others';
            OptionMembers = " ",Internal,External,Others;
        }
        field(3; "Valid From"; Date)
        {
        }
        field(4; "Valid To"; Date)
        {
        }


        field(7; "Qualification Code"; Code[20])
        {

        }
        field(8; "Qualification Name"; Text[250])
        {

        }
        field(9; "Examination Body"; Code[50])
        {
            TableRelation = "HRM-Professional Bodies".code;
        }
        field(10; "Year Attained"; Integer)
        {

        }
        field(11; "Membership No."; Code[20])
        {

        }
        field(12; "Professional Qualification"; Text[100])
        {

        }


    }

    keys
    {
        key(Key1; "Payroll No.", "Membership No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        qual: Record "HRM-Emp. Qualifications Final";
}

