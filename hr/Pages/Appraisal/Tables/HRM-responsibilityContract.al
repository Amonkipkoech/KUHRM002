table 85607 "HRM Responsiblities Contract"
{

    fields
    {

        field(1; "Payroll No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

        }
        field(2; "Job ID"; Code[50])
        {
            Caption = 'Primary Job Title';
            //TableRelation = "HRM-Jobs";
        }

        field(3; Remarks; Text[150])
        {
        }
        field(4; "Responsibility Code"; Code[50])
        {
            TableRelation = "HRM-Employee Responsibility"."Responsibility Code";
            trigger OnValidate()
            var
                resP: Record "HRM-Employee Responsibility";
            begin
                resP.Reset();
                resP.SetRange("Responsibility Code", Rec."Responsibility Code");
                if resP.Find('-') then begin
                    rec."Responsibility Description" := resP.Responsibility;
                    Rec.Modify()
                end;

            end;


        }
        field(5; "Responsibility Description"; Text[300])
        {

        }

        field(6; "Department Code"; Code[20])
        {
            // TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            // trigger OnValidate()
            // var
            //     dimV: Record "Dimension Value";
            // begin
            //     if dimV.Get("Department Code") then
            //         Department := Dimv.Name;
            //     Rec.Modify()
            // end;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));



            trigger OnValidate()
            begin
                Dimv.SetRange(dimV.Code, "Department Code");
                if Dimv.Find('-') then begin
                    Department := dimV.Name;
                end;
            end;
        }
        field(7; "Department"; Text[200])
        {

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
        field(23; Division; Option)
        {
            OptionMembers = " ","Administrative Staff","Academic Staff";

        }

        field(24; "Resposibility two"; Text[250])
        {

        }
        field(25; "Job Reference N.o"; Code[50])
        {
            // TableRelation = "HRM-Jobs"."Job Reference Number";
        }
        field(26; "Faculty"; code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }




    }

    keys
    {
        key(Key1; "Payroll No.", "Job ID")
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
        dimV: Record "Dimension Value";

}

