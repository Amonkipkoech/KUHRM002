table 61661 "HRM-Emp. Performance Target"
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
        field(4; Target; Text[250])
        {
        }
        field(5; "Code"; Integer)
        {
        }
        field(6; "Appraisee Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if employee.Get("Employee No") then begin
                    employee.CalcFields(employee.MaximumTagets);
                    MAXMUMSC := employee.MaximumTagets;
                end;
                employee.Reset;
                employee.SetRange(employee."Employee No", "Employee No");
                if employee.Find('-') then begin

                    if "Appraisee Rating" > "Maximum Rating" then
                        Error('The maximum Rating % is %1', "Maximum Rating");

                end;



                Employees.Reset;
                Employees.SetRange(Employees."No.", "Employee No");
                if Employees.Find('-') then begin

                    // "Job Scale":=Employees."Job Scale";

                    //CALCFIELDS("Overall Rating") ;
                    "Overall Rating" := "Overall Rating" + "Appraisee Rating";

                    //Kate
                    hrvalues.Reset;
                    hrvalues.SetRange(hrvalues.Code, "Job Scale");
                    hrvalues.SetRange(hrvalues.Type, hrvalues.Type::"Appraisal Sub Category");
                    if hrvalues.Find('-') then begin
                        // IF "Overall Rating" >hrvalues."Performance Targets" THEN
                        //ERROR('Your Rating Should Not Exceed %1',hrvalues."Performance Targets");
                    end;
                end;
            end;
        }
        field(7; "Appraiser Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Appraiser Rating" > "Maximum Rating" then begin
                    Error('Your Rating Should Not Exceed %1', "Maximum Rating");
                end;
                /* ELSE BEGIN
                
                employee.RESET;
                employee.SETRANGE(employee."Employee No","Employee No");
                IF  employee.FIND('-') THEN BEGIN
                IF (employee."Job Scale">='01') AND (employee."Job Scale"<='08') THEN BEGIN
                 IF "Appraisee Rating">60 THEN
                 ERROR('The maximum % is 60%')
                 END ELSE
                IF (employee."Job Scale">='09') AND (employee."Job Scale"<='15') THEN BEGIN
                 IF "Appraisee Rating">70 THEN
                 ERROR('The maximum % is 70%');
                END;
                END;
                
                 CALCFIELDS("Overall Rating") ;
                 "Overall Rating":="Overall Rating"+"Appraiser Rating";
                
                  Employees.RESET;
                  Employees.SETRANGE(Employees."No.","Employee No");
                 IF Employees.FIND('-') THEN BEGIN
                
                  "Job Scale":=Employees."Job Scale";
                
                
                   hrvalues.RESET;
                   hrvalues.SETRANGE(hrvalues.Code,"Job Scale");
                   hrvalues.SETRANGE(hrvalues.Type,hrvalues.Type::Category);
                   IF hrvalues.FIND('-') THEN BEGIN
                    IF "Overall Rating" >hrvalues."Performance Targets" THEN
                     ERROR('Your Rating Should Not Exceed %1',hrvalues."Performance Targets");
                  END;
                 END;
                  END;*/

            end;
        }
        field(8; "Agreed Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Agreed Rating" > "Maximum Rating" then begin
                    Error('Your Rating Should Not Exceed %1', "Maximum Rating");
                end;
                /*
                ELSE BEGIN

               employee.RESET;
               employee.SETRANGE(employee."Employee No","Employee No");
               IF  employee.FIND('-') THEN BEGIN
               IF (employee."Job Scale">='01') AND (employee."Job Scale"<='08') THEN BEGIN
                IF "Appraisee Rating">60 THEN
                ERROR('The maximum % is 60%')
                END ELSE
               IF (employee."Job Scale">='09') AND (employee."Job Scale"<='15') THEN BEGIN
                IF "Appraisee Rating">70 THEN
                ERROR('The maximum % is 70%');
               END;
               END;

                CALCFIELDS("Overall Rating") ;
                "Overall Rating":="Overall Rating"+"Agreed Rating";

                 Employees.RESET;
                 Employees.SETRANGE(Employees."No.","Employee No");
                IF Employees.FIND('-') THEN BEGIN

                 "Job Scale":=Employees."Job Scale";


                  hrvalues.RESET;
                  hrvalues.SETRANGE(hrvalues.Code,"Job Scale");
                  hrvalues.SETRANGE(hrvalues.Type,hrvalues.Type::Category);
                  IF hrvalues.FIND('-') THEN BEGIN
                   IF "Overall Rating" >hrvalues."Performance Targets" THEN
                    ERROR('Your Rating Should Not Exceed %1',hrvalues."Performance Targets");
                 END;
                END;
                 END; */

            end;
        }
        field(9; Reason; Text[250])
        {
        }
        field(10; "Overall Rating"; Decimal)
        {
            CalcFormula = Sum("HRM-Emp. Performance Target"."Agreed Rating" WHERE("Employee No" = FIELD("Employee No"),
                                                                                   "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                   "Appraisal Type" = FIELD("Appraisal Type")));
            FieldClass = FlowField;
            InitValue = 0;
        }
        field(11; "Total Targets"; Integer)
        {
            CalcFormula = Count("HRM-Emp. Performance Target" WHERE("Employee No" = FIELD("Employee No"),
                                                                     "Appraisal Period" = FIELD("Appraisal Period"),
                                                                     "Appraisal Type" = FIELD("Appraisal Type")));
            FieldClass = FlowField;
        }
        field(12; Results; Text[250])
        {
        }
        field(13; Barriers; Text[250])
        {
        }
        field(14; "Action Plan"; Text[250])
        {
        }
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Maximum Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Appraisee Rating" > "Maximum Rating" then begin
                    //ERROR('Your Rating Should Not Exceed %1',"Maximum Rating");
                end

                else begin

                    if employee.Get("Employee No") then begin
                        employee.CalcFields(employee.MaximumTagets);
                        MAXMUMSC := employee.MaximumTagets;
                    end;
                    employee.Reset;
                    employee.SetRange(employee."Employee No", "Employee No");
                    if employee.Find('-') then begin

                        if (employee."Job Scale" >= '01') and (employee."Job Scale" <= '08') then begin
                            repeat
                                MAXMUMSC := MAXMUMSC + "Appraisee Rating";
                                if MAXMUMSC > 60 then
                                    Error('The maximum % is 60%');
                            until Next = 0
                        end else
                            if (employee."Job Scale" >= '09') and (employee."Job Scale" <= '15') then begin
                                repeat
                                    MAXMUMSC := MAXMUMSC + "Appraisee Rating";
                                    if MAXMUMSC > 70 then
                                        Error('The maximum % is 70%');
                                until Next = 0;
                            end;
                    end;


                    CalcFields("Overall Rating");
                    "Overall Rating" := "Overall Rating" + "Maximum Rating";

                    Employees.Reset;
                    Employees.SetRange(Employees."No.", "Employee No");
                    if Employees.Find('-') then begin

                        // "Job Scale":=Employees."Job Scale";


                        hrvalues.Reset;
                        hrvalues.SetRange(hrvalues.Code, "Job Scale");
                        hrvalues.SetRange(hrvalues.Type, hrvalues.Type::"Appraisal Sub Category");
                        if hrvalues.Find('-') then begin
                            //IF "Overall Rating" >hrvalues."Performance Targets" THEN
                            //ERROR('Your Rating Should Not Exceed %1',hrvalues."Performance Targets");
                        end;
                    end;
                end;
            end;
        }
        field(50002; "Total Rating"; Decimal)
        {
            CalcFormula = Sum("HRM-Emp. Performance Target"."Agreed Rating" WHERE("Employee No" = FIELD("Employee No"),
                                                                                   "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                   "Appraisal Type" = FIELD("Appraisal Type")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No", "Appraisal Period")
        {
            SumIndexFields = "Agreed Rating";
        }
        key(Key2; "Employee No", "Appraisal Period")
        {
            SumIndexFields = "Maximum Rating";
        }
        key(Key3; "Employee No", "Appraisal Type", "Appraisal Period")
        {
            SumIndexFields = "Agreed Rating", "Appraisee Rating";
        }
    }

    fieldgroups
    {
    }

    var
        employee: Record "HRM-Appraisal Goal Setting H";
        Employees: Record "HRM-Employee (D)";
        "Job Scale": Code[20];
        Apprating6: Decimal;
        Apprating7: Decimal;
        MAXMUMSC: Decimal;
        hrvalues: Record "HRM-Lookup Values";
}

