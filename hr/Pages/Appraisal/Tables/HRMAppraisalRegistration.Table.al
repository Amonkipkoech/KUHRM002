table 75007 "HRM-Appraisal Registration"
{
    DrillDownPageID = "HRM-Appraisal Reg List 2";
    LookupPageID = "HRM-Appraisal Reg List 2";

    fields
    {
        field(1; "PF No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; "Appraisal Period Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Periods".Code;

            trigger OnValidate()
            begin
                coReg2.RESET;
                coReg2.SETRANGE(coReg2."Appraisal Period Code", Rec."Appraisal Period Code");
                coReg2.SETRANGE(coReg2."PF No.", Rec."PF No.");
                IF coReg2.FIND('-') THEN BEGIN
                    IF coReg2.COUNT > 1 THEN ERROR('Multiple Registration in the same Appraisal Period is not allowed....');
                END;
            end;
        }
        field(3; "Appraisal Job Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Jobs".Code;

            trigger OnValidate()
            begin
                Periods.RESET;
                Periods.SETRANGE(Periods.Closed, FALSE);
                IF Periods.FIND('-') THEN;

                acadYears.RESET;
                acadYears.SETRANGE(acadYears.Closed, TRUE);
                IF acadYears.FIND('-') THEN BEGIN
                    Rec."Appraisal Year Code" := acadYears.Code;
                END;



                //Default Stage and semeter

                //Defaulting of semester
                Periods.RESET;
                Periods.SETRANGE(Periods.Closed, FALSE);
                IF Periods.FIND('-') THEN
                    "Appraisal Period Code" := Periods.Code
                ELSE
                    ERROR('Please specify the Curent Appraisal Period in the Appraisal Periods Setup!');
                VALIDATE("Appraisal Period Code");

                // Insert the Settlement Type
                CReg2.RESET;
                CReg2.SETRANGE("PF No.", Rec."PF No.");
                CReg2.SETFILTER("Employee Category", '<>%1', '');
                IF CReg2.FIND('-') THEN BEGIN
                    "Employee Category" := CReg2."Employee Category";
                    VALIDATE("Employee Category");
                END;

                IF "Registration Date" = 0D THEN
                    "Registration Date" := TODAY;
                VALIDATE("Registration Date");
            end;
        }
        field(7; "Employee Category"; Code[50])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee Category".Code;

            trigger OnValidate()
            begin
                VALIDATE("Registration Date");
                TESTFIELD("Reg. Transacton ID");
                "User ID" := USERID;
            end;
        }
        field(8; "Registration Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                EmpAppraisalTargets.RESET;
                EmpAppraisalTargets.SETRANGE(EmpAppraisalTargets."PF. No.", "PF No.");
                EmpAppraisalTargets.SETRANGE(EmpAppraisalTargets."Reg. Transacton ID", "Reg. Transacton ID");
                IF EmpAppraisalTargets.FIND('-') THEN
                    EmpAppraisalTargets.DELETEALL;



                //Insert Employee Appraisal Targets

                AppraisalTargets.RESET;
                AppraisalTargets.SETRANGE(AppraisalTargets."Appraisal Job Code", "Appraisal Job Code");
                AppraisalTargets.SETRANGE(AppraisalTargets."Appraisal Year Code", "Appraisal Year Code");
                IF AppraisalTargets.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        EmpAppraisalTargets.INIT;
                        EmpAppraisalTargets."Reg. Transacton ID" := "Reg. Transacton ID";
                        EmpAppraisalTargets."PF. No." := "PF No.";
                        EmpAppraisalTargets."Appraisal Job Code" := "Appraisal Job Code";
                        EmpAppraisalTargets."Appraisal Target Code" := AppraisalTargets.Code;
                        EmpAppraisalTargets."Appraisal Period Code" := "Appraisal Period Code";
                        //EmpAppraisalTargets.Description:=AppraisalTargets.Desription;
                        EmpAppraisalTargets.Taken := TRUE;
                        EmpAppraisalTargets.INSERT
                    END;
                    UNTIL AppraisalTargets.NEXT = 0
                END;
            end;
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Reg. Transacton ID"; Code[20])
        {

            trigger OnValidate()
            begin

                IF "Reg. Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Appraisal Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
                END;
            end;
        }
        field(11; "No. Series"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Reg. Transacton ID" <> xRec."Reg. Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    NoSeriesMgt.TestManual(GenSetup."Appraisal Registration Nos.");
                    "No. Series" := '';
                END;

                IF "Reg. Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Appraisal Registration Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
                END;
            end;
        }
        field(21; "Targets Set"; Integer)
        {
            Editable = false;
        }
        field(22; "User ID"; Code[50])
        {
        }
        field(37; "Appraisal Year Code"; Code[20])
        {
            Description = 'Stores the reference to the academic year in the database';
            TableRelation = "HRM-Appraisal Years".Code;
        }
        field(68; "Date Registered"; Date)
        {
        }
        field(69; "Appraisal Jobs Category"; Code[20])
        {
            CalcFormula = Lookup("HRM-Appraisal Jobs"."Appraisal Category");
            FieldClass = FlowField;
        }
        field(20029; "Average Individual Target"; Decimal)
        {
        }
        field(50005; "Appraisal Target Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "`"; Code[20])
        {
        }
        field(50060; Award; Text[200])
        {
        }
        field(50085; "Suspervisor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Supervisor Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Individual Target Grade"; Code[10])
        {
        }
        field(50089; "Individual Target Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Average Agreed Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Appraisal Emp. Targets"."Individual Target" WHERE("PF. No." = FIELD("PF No."),
                                                                                      "Appraisal Period Code" = FIELD("Appraisal Period Code"),
                                                                                      "Appraisal year Code" = FIELD("Appraisal Year Code")));
            FieldClass = FlowField;
        }
        field(50098; "Agreed Score Grade"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Agreed Score Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Staff Name"; Text[250])
        {
        }
        field(60033; "ID Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "PF No.", "Appraisal Period Code", "Appraisal Job Code", "Appraisal Year Code")
        {
            Clustered = true;
        }
        key(Key2; "Registration Date", "Appraisal Job Code")
        {
        }
        key(Key3; "Reg. Transacton ID", "Appraisal Job Code", "Appraisal Period Code")
        {
        }
        key(Key4; "Appraisal Job Code")
        {
        }
        key(Key5; "Employee Category")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EmpAppraisalTargets.RESET;
        EmpAppraisalTargets.SETRANGE(EmpAppraisalTargets."PF. No.", Rec."PF No.");
        EmpAppraisalTargets.SETRANGE("Appraisal Period Code", Rec."Appraisal Period Code");
        IF EmpAppraisalTargets.FIND('-') THEN
            EmpAppraisalTargets.DELETEALL;

        /*  ExamR.RESET;
         ExamR.SETRANGE(ExamR."PF No.", Rec."PF No.");
         ExamR.SETRANGE("Appraisal Period Code", Rec."Appraisal Period Code");
         IF ExamR.FIND('-') THEN
             ExamR.DELETEALL; */
    end;

    trigger OnInsert()
    begin
        IF "Reg. Transacton ID" = '' THEN BEGIN
            GenSetup.GET;
            GenSetup.TESTFIELD(GenSetup."Appraisal Registration Nos.");
            NoSeriesMgt.InitSeries(GenSetup."Appraisal Registration Nos.", xRec."No. Series", 0D, "Reg. Transacton ID", "No. Series");
        END;
    end;

    var
        UserSetup: Record 91;
        coReg2: Record "HRM-Appraisal Registration";
        coReg1: Record "HRM-Appraisal Registration";
        acadYears: Record "HRM-Appraisal Years";
        NoSeriesMgt: Codeunit 396;
        GenSetup: Record "HRM-Appraisal Gen. Setup";
        TotalCost: Decimal;
        RecFound: Boolean;
        EmpAppraisalTargets: Record "HRM-Appraisal Emp. Targets";
        AppraisalTargets: Record "HRM-Appraisal Targets";
        GenJnl: Record 81;
        Units: Record "HRM-Appraisal Targets";
        Periods: Record "HRM-Appraisal Periods";
        SemFound: Boolean;
        DueDate: Date;
        Cust: Record 18;
        GenBatches: Record 232;
        window: Dialog;
        GLPosting: Codeunit 12;
        SettlementType: Record "HRM-Employee Category";
        CReg: Record "HRM-Appraisal Registration";
        CustPostGroup: Record 92;
        Programmes: Record "HRM-Appraisal Jobs";
        CourseReg: Record "HRM-Appraisal Registration";
        CourseReg2: Record "HRM-Appraisal Registration";
        Found: Boolean;
        LibCode: Text[30];
        Custs: Record 18;
        UnitType: Text[100];
        TotalUnits: Integer;
        OldStud: Boolean;
        CReg2: Record "HRM-Appraisal Registration";
        StudUnits: Record "HRM-Appraisal Emp. Targets";
        //ExamR: Record "HRM-Appraisal Results";
        Prog: Record "HRM-Appraisal Jobs";
        Prog2: Record "HRM-Appraisal Jobs";
        AcademicYear: Record "HRM-Appraisal Years";
        EmpAppraisalTargets_2: Record "HRM-Appraisal Emp. Targets";
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;


    procedure Check_Units_Exist(PfNo: Code[20]; EmpJob: Code[20]; Stag: Code[20]; Unt: Code[20]) Exists: Boolean
    var
        StudUnits: Record "HRM-Appraisal Emp. Targets";
    begin
        Exists := FALSE;
        StudUnits.RESET;
        StudUnits.SETRANGE(StudUnits."Appraisal Job Code", EmpJob);
        StudUnits.SETRANGE(StudUnits."Appraisal Target Code", Unt);
        StudUnits.SETRANGE(StudUnits."PF. No.", PfNo);
        IF StudUnits.FIND('-') THEN
            Exists := TRUE;
    end;
}

