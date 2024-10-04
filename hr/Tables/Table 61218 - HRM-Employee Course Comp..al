table 61218 "HRM-Employee Course Comp."
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then begin
                    // "Employee First Name":= Employee."Known As";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(2; "Product Name"; Code[30])
        {
        }
        field(3; "Date Acredited"; Date)
        {
        }
        field(4; "Apply To Employee"; Boolean)
        {
        }
        field(5; "Employee First Name"; Text[30])
        {
        }
        field(6; "Employee Last Name"; Text[30])
        {
        }
        field(7; "Product Description"; Text[170])
        {
        }
        field(8; "Class Code"; Text[30])
        {
        }
        field(9; Department; Code[10])
        {
        }
        field(10; Office; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Product Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        OK := Employee.Get("Employee No.");
        if OK then begin
            // "Employee First Name":= Employee."Known As";
            "Employee Last Name" := Employee."Last Name";
        end;
    end;

    var
        Employee: Record "HRM-Employee (D)";
        OK: Boolean;
}

