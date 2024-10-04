table 61632 "HRM-Appraisal Values assesment"
{

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Appraisal Type"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Type"));
        }
        field(3; "Appraisal Period"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Appraisal Period"));
        }
        field(4; "Value factors"; Text[250])
        {
        }
        field(5; "Code"; Code[20])
        {


            trigger OnValidate()
            begin
                if hrValueassess.Get(Code) then begin
                    "Value factors" := hrValueassess."Value factors";
                end;
            end;
        }
        field(6; "Appraisee Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                // Employees.TESTFIELD("Job Scale");
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin

                    //"Job Scale":=Employees."Job Scale";


                    hrvalues.Reset;
                    hrvalues.SetRange(hrvalues.Code, "Job Scale");
                    hrvalues.SetRange(hrvalues.Type, hrvalues.Type::CompetenceValues);
                    if hrvalues.Find('-') then begin
                        if "Appraisee Rating" > hrvalues."Weight Scores" then
                            Error('Your Rating Should Not Exceed %1', hrvalues."Weight Scores");
                    end;
                end;
            end;
        }
        field(7; "Appraiser Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin

                    //"Job Scale":=Employees."Job Scale";


                    hrvalues.Reset;
                    hrvalues.SetRange(hrvalues.Code, "Job Scale");
                    hrvalues.SetRange(hrvalues.Type, hrvalues.Type::CompetenceValues);
                    if hrvalues.Find('-') then begin
                        if "Appraiser Rating" > hrvalues."Weight Scores" then
                            Error('Your Rating Should Not Exceed %1', hrvalues."Weight Scores");
                    end;
                end;
            end;
        }
        field(8; "Agreed Rating"; Integer)
        {

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin

                    //"Job Scale":=Employees."Job Scale";


                    hrvalues.Reset;
                    hrvalues.SetRange(hrvalues.Code, "Job Scale");
                    hrvalues.SetRange(hrvalues.Type, hrvalues.Type::CompetenceValues);
                    if hrvalues.Find('-') then begin
                        if "Agreed Rating" > hrvalues."Weight Scores" then
                            Error('Your Rating Should Not Exceed %1', hrvalues."Weight Scores");
                    end;
                end;
            end;
        }
        field(9; Reason; Text[250])
        {
        }
        field(10; "Overall Rating"; Decimal)
        {
            CalcFormula = Sum("HRM-Appraisal Values assesment"."Agreed Rating New" WHERE("Employee No" = FIELD("Employee No"),
                                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                          "Appraisal Type" = FIELD("Appraisal Type")));
            FieldClass = FlowField;
            InitValue = 0;
        }
        field(11; "Total Targets"; Integer)
        {
            CalcFormula = Count("HRM-Appraisal Values assesment" WHERE("Employee No" = FIELD("Employee No"),
                                                                        "Appraisal Period" = FIELD("Appraisal Period"),
                                                                        "Appraisal Type" = FIELD("Appraisal Type")));
            FieldClass = FlowField;
        }
        field(12; "Agreed Rating New"; Decimal)
        {

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin

                    //"Job Scale":=Employees."Job Scale";


                    hrvalues.Reset;
                    hrvalues.SetRange(hrvalues.Code, "Job Scale");
                    hrvalues.SetRange(hrvalues.Type, hrvalues.Type::CompetenceValues);
                    if hrvalues.Find('-') then begin
                        if "Agreed Rating New" > hrvalues."Weight Scores" then
                            Error('Your Rating Should Not Exceed %1', hrvalues."Weight Scores");
                    end;
                end;
            end;
        }
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Agreed RatingS"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Employee No", "Appraisal Type", "Appraisal Period", "Code")
        {
            SumIndexFields = "Agreed Rating New";
        }
        key(Key2; "Code")
        {
        }
        key(Key3; "Employee No", "Appraisal Period", "Appraisal Type")
        {
            SumIndexFields = "Appraiser Rating", "Agreed RatingS", "Agreed Rating New";
        }
    }

    fieldgroups
    {
    }

    var
        hrValueassess: Record "HRM-Appraisal Values assesment";
        Employees: Record "HRM-Employee (D)";
        "Job Scale": Code[10];
        hrvalues: Record "HRM-Lookup Values";
}

