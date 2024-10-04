table 61192 "HRM-Job Responsiblities (B)"
{

    fields
    {
        field(1; "Payroll Number"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Payroll Number");
                if Emp.FindFirst() then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(2; "Job ID"; Code[50])
        {
            Caption = 'Primary Job Title';
            TableRelation = "HRM-Jobs";
        }
        field(3; "Responsibility Description"; Text[300])
        {

        }
        field(4; Remarks; Text[150])
        {
        }
        field(5; "Responsibility Code"; Code[20])
        {
            Caption = 'Responsiblity';
            trigger OnValidate()
            begin
                /*
                HRAppEvalArea.RESET;
                HRAppEvalArea.SETRANGE(HRAppEvalArea.Code,"Responsibility Code");
                IF HRAppEvalArea.FIND('-') THEN
                BEGIN
                    "Responsibility Description":=HRAppEvalArea.Description;
                END;
                */

            end;
        }
        field(6; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                dimV: Record "Dimension Value";
            begin
                if dimV.Get("Department Code") then
                    Department := Dimv.Name;
            end;
        }
        field(7; "Department"; Text[200])
        {
            Editable = false;
        }
        field(8; Duration; Duration)
        {
        }
        field(9; "From Date"; Date)
        {
        }
        field(10; "To Date"; Date)
        {
        }
        field(11; "Expiry Notificaion date"; Date)
        {
        }
        field(20; "Employee Name"; Text[100])
        {
        }
        field(21; Section; Option)
        {
            OptionMembers = " ",Faculty,Centre,Institute,School,Directorate;
        }
        field(22; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(23; "Faculty Code"; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(24; "Resposibility two"; Text[250])
        {

        }
        field(25; "Job Reference N.o"; Code[50])
        {
            TableRelation = "HRM-Jobs"."Job Reference Number";
        }
        field(26; "Minimun Requirement"; text[300])
        {

        }



    }

    keys
    {
        key(Key1; "Job ID", "Responsibility Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRAppEvalArea: Record "HRM-Appraisal Evaluation Areas";
        Emp: Record "HRM-Employee (D)";
}

