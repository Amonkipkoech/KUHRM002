table 84508 "HRM-Leave Schedule"
{


    fields
    {
        field(1; PayrollNo; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            begin
                if Emp.Get(PayrollNo) then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name"+ ' ' + Emp."Last Name";
                end;
            end;

        }
        field(2; "Employee Name"; Text[100])
        {


        }
        field(3; "Start Date"; Date)
        {

        }
        field(4; "End Date"; Date)
        {

        }
        field(5; EntryNo; code[20])
        {

        }
    }

    keys
    {
       key( Key1; EntryNo, PayrollNo)
       {
        
       }

    }

    var

        Emp: Record "HRM-Employee (D)";



}