table 50002 "Indispline Cases"
{

    fields
    {
        field(1; "Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Indispline Id"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Indispline Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Indicpline Cases setup"."Case Code";

            trigger OnValidate()
            var
                IndicplineCasessetup: Record "Indicpline Cases setup";
            begin
                IF IndicplineCasessetup.GET(Rec."Indispline Code") THEN;
                "Indispline Description" := IndicplineCasessetup."Case Description";
                Severity := IndicplineCasessetup.Severity;
            end;
        }
        field(4; "Indispline Description"; Text[100])
        {
            Editable = false;
        }
        field(5; Severity; Option)
        {
            Editable = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ",Low,Medium,High;
        }
        field(6; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            var
                HRMEmployee: Record "HRM-Employee (D)";
            begin
                IF HRMEmployee.GET(Rec."Staff No") THEN
                    Rec."Staff Name" := HRMEmployee."First Name" + ' ' + HRMEmployee."Middle Name" + ' ' + HRMEmployee."Last Name";
            end;
        }
        field(7; "Staff Name"; Text[100])
        {
            Editable = false;
        }
        field(8; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENTS'),
                                                          "Global Dimension No." = FILTER(2));
        }
        field(9; "Department Name"; Text[100])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Global Dimension No." = FILTER(2),
                                                               Code = FIELD("Department Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Incident Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(11; "Incident Time"; Time)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(12; "Reported By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Possible Action"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Recommendations; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(16; Background; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(17; Response; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(18; "Discipline Process"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(19; "Summary of Findings"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Year Code", "Indispline Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Rec."Captured By" := USERID;
    end;

    var
        HRMEmployee: Record "HRM-Employee (D)";
        IndicplineCasessetup: Record "Indicpline Cases setup";
}

