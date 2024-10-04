table 61663 "HRM-Appraisals Perfomance"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Appraisal Type"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Type"));
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Period"));
        }
        field(5; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
        field(8; Weighting; Decimal)
        {
        }
        field(9; Factors; Text[150])
        {
        }
        field(10; "Specific Comments"; Text[250])
        {
        }
        field(11; Score; Decimal)
        {

            trigger OnValidate()
            begin
                Overall := Score * Weighting;
            end;
        }
        field(12; Overall; Decimal)
        {
        }
        field(13; "Employee Overall"; Decimal)
        {
        }
        field(14; Description; Text[250])
        {
        }
        field(15; "Date Captured"; DateTime)
        {
        }
        field(16; Outcome; Text[250])
        {
        }
        field(17; "Agreed Target Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Appraisal Type", "Appraisal Period", Factors)
        {
            Clustered = true;
            SumIndexFields = Score;
        }
        key(Key2; "No.")
        {
            SumIndexFields = Score;
        }
    }

    fieldgroups
    {
    }
}

