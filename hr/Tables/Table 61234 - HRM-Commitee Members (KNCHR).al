table 61234 "HRM-Commitee Members (KNCHR)"
{

    fields
    {
        field(1; "Member No."; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.Get("Member No.");
                "Member Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                if "Member type" = "Member type"::"Non-staff" then
                    Error('You cannot fill member number for a Non-Staff');
            end;
        }
        field(2; "Member Name"; Text[100])
        {
        }
        field(3; Role; Text[100])
        {
        }
        field(8; "Date Appointed"; Date)
        {
        }
        field(9; Grade; Code[20])
        {
        }
        field(10; Active; Boolean)
        {
        }
        field(11; Committee; Code[70])
        {
            TableRelation = "HRM-Committees (B)".Code;
        }
        field(12; "Member type"; Option)
        {
            OptionMembers = Staff,"Non-staff";
        }
    }

    keys
    {
        key(Key1; Committee, "Member No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HRM-Employee (D)";
}

