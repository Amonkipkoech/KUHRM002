table 61790 "HRM-Job_Salary grade/steps"
{
    DrillDownPageID = "HRM-Job_Salary Grade/Steps";
    LookupPageID = "HRM-Job_Salary Grade/Steps";

    fields
    {
        field(2; "Employee Category"; Code[30])
        {
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(3; "Salary Grade code"; Code[30])
        {
            TableRelation = "HRM-Salary Grades"."Salary Grade";
        }
        field(4; "Grade Level"; Integer)
        {
        }
        field(5; "House Allowance"; Decimal)
        {
        }

        field(6; "Leave Allowance"; Decimal)
        {
        }
        field(7; "Medical Ceilling"; Decimal)
        {
        }
        field(8; "Annual Leave Days"; Decimal)
        {
            Caption = 'Entitled Annual Leave Days';
        }
        field(9; "Grade Description"; Text[100])
        {
            CalcFormula = Lookup("HRM-Salary Grades".Description WHERE("Salary Grade" = FIELD("Salary Grade code")));
            FieldClass = FlowField;
        }
        field(10; "Weekly Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Monthly Leave Days"; Decimal)
        {
            Caption = 'Entitled Monthly Leave Days';
            DataClassification = ToBeClassified;
        }
        field(12; "Job Group Qualification"; Text[50])
        {
            Caption = 'Job Group Qualification';
            DataClassification = ToBeClassified;
        }
        field(13; "Years Of Experience"; Integer)
        {
            Caption = 'Years of Experience';
            DataClassification = ToBeClassified;
        }
        field(14; "Teaching/NonTeaching"; Option)
        {
            Caption = 'Teaching / Non Teaching';
            OptionMembers = " ",T,N;
        }
        field(15; "Entitled Allowance 1"; code[20])
        {
            TableRelation = "PRL-Transaction Codes" where("Transaction Type" = const(Income));
        }
        field(16; "Entitled Allowance 2"; code[20])
        {
            TableRelation = "PRL-Transaction Codes" where("Transaction Type" = const(Income));
        }
        field(17; "Entitled Allowance 3"; code[20])
        {
            TableRelation = "PRL-Transaction Codes" where("Transaction Type" = const(Income));
        }
        field(19; "Travel Allowance"; Decimal)
        {

        }
        field(20; "Commuter Allowance"; Decimal)
        {

        }
        field(21; "Amount"; Integer)
        {

        }
        field(22; "House Allowance Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(23; "Commuter Allowance Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(25; "Retirement Age"; Decimal)
        {
            
        }

    }

    keys
    {
        key(Key1; "Employee Category", "Salary Grade code")
        {
        }
        key(Key2; "Grade Level")
        {
        }
    }

    fieldgroups
    {
    }
}

