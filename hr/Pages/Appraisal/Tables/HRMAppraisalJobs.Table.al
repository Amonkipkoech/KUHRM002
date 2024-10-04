table 75003 "HRM-Appraisal Jobs"
{
    DrillDownPageID = "HRM-Appraisal Jobs List";
    LookupPageID = "HRM-Appraisal Jobs List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(47; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(51; "Appraisal Category"; Code[20])
        {
            TableRelation = "HRM-Appraisal Category".Code;
        }
        field(50002; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Department Code"),
                                                               "Dimension Code" = FILTER('DEPARTMENT')));
            FieldClass = FlowField;
        }
        field(50007; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50008; "Appraisal Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Appraisal Years".Code;
        }
    }

    keys
    {
        key(Key1; "Code", "Appraisal Year Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
         CReg.RESET;
         CReg.SETRANGE(CReg.Programme,xRec.Code);
         IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Programme');
         */

    end;

    trigger OnModify()
    begin
        /* IF xRec.Code<>Code THEN BEGIN
         CReg.RESET;
         CReg.SETRANGE(CReg.Programme,Code);
         IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used programme');
         END;*/

    end;

    var
        Units: Record "HRM-Appraisal Targets";
        CReg: Record "HRM-Appraisal Registration";
}

