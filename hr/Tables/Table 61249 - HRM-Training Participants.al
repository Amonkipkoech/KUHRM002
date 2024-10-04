table 61249 "HRM-Training Participants"
{
    DrillDownPageID = "HRM-Training Partcipants";
    LookupPageID = "HRM-Training Partcipants";

    fields
    {
        field(1; "Training Code"; Code[30])
        {
            TableRelation = "HRM-Training Applications"."Application No";

            // trigger OnValidate()
            // begin
            //     /*IF Training."Training category"<> Training."Training category"::Group THEN
            //     ERROR(mcontent);
            //     */

            // end;
        }
        field(2; "Employee Code"; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            //Editable =  false;

            trigger OnValidate()
            begin
                if Hr.Get("Employee Code") then
                    "Employee name" := Hr."First Name" + ' ' + Hr."Middle Name" + ' ' + Hr."Last Name";
            end;

        }
        field(3; "Employee name"; Text[60])
        {
        }
        field(4; "Academic Year"; Code[20])
        {
        }
        field(5; "Scholarship Type"; Text[100])
        {
        }
        field(6; "Scholarship Period"; Text[100])
        {
        }
        field(7; Completed; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(8; "Bonding Required"; Text[100])
        {
        }
        field(9; "Bonding Period"; Code[20])
        {

        }
        field(10; "Certificate Issued"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(11; Objectives; Text[100])
        {
        }
        field(12; "Department Code"; Code[20])
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
        field(13; "Department"; Text[200])
        {

        }
        field(14; "Training Description"; Text[200])
        {

        }
        field(15; "Training Institution"; Text[200])
        {

        }
        field(16; "Training Cost"; Text[20])
        {

        }
        field(17; "Date From"; Date)
        {

        }
        field(18; "Date To"; Date)
        {

        }



    }

    keys
    {
        key(Key1; "Training Code", "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Training.Reset;
        Training.SetRange(Training."Application No", "Training Code");
        if Training.Find('-') then begin
            if Training."Training Category" <> Training."Training Category"::Group then
                Error(mcontent);
        end;
    end;

    var
        Hr: Record "HRM-Employee (D)";
        Training: Record "HRM-Training Applications";
        mcontent: Label 'You cannot assign participants where training category is ''Individual''';
}

