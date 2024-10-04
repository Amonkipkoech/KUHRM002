table 80001 "HRM-Return To Office(Leave)"
{
    DrillDownPageID = "HRM-Leave Application List";
    LookupPageID = "HRM-Leave Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            var
                lastNo: Integer;
                GenLedgerSetup: Record "HRM-Setup";
                //RespCenter: Record "FIN-Responsibility Center BR";
                UserMgt: Codeunit "User Setup Management";
                Dimval: Record "Dimension Value";
                Text001: Label 'Your identification is set up to process from %1 %2 only.';
                Emp3: Record "HRM-Employee (D)";
                Emp: Record "HRM-Employee (D)";
                "Employee Leaves": Record "HRM-Emp. Leaves";
                BaseCalendar: Record "Base Calendar Change";
                CurDate: Date;
                LeaveTypes: Record "HRM-Leave Types";
                DayApp: Decimal;
                NoSeriesMgt: Codeunit NoSeriesManagement;
                EndDate: Date;
                BeginDate: Date;
                NextDate: Date;
                varDaysApplied: Integer;
                fDays: Integer;
                ReturnDateLoop: Boolean;
                Employee: Record "HRM-Employee (D)";
                fEmpNo: Code[30];
                EmpLeaveApps: Record "HRM-Leave Requisition";
                GeneralOptions: Record "HRM-Setup";
                "HR Set Up": Record "HRM-Human Resources Setup.";
                Levels: Integer;
                LEmployee: Record "HRM-Employee (D)";
                CurrYear: Integer;
                CYSDate: Date;
                CYEDate: Date;
                CurrYearValue: Integer;
                Number: Integer;
                SMTP: Codeunit "Email Message";// replaced "SMTP Mail"
                Names: Text[100];
                objPeriod: Record "PRL-Payroll Periods";
                PayPeriod: Date;
                CurrYearValue2: Integer;
                prCodes: Record "PRL-Transaction Codes";
                prTrans: Record "PRL-Employee Transactions";
                //todo   Payroll: Record "PRL-Salary Card";
                Grd: Code[10];
                hrSetup: Record "HRM-Setup";
                mContent: Text[100];
                mSubject: Text[100];
                nonworking: Decimal;
                CurrDate: Date;
                NONWORKINDAYS: Integer;
                Users2: Record User;
                usersetup: Record "User Setup";
                leaveLedgers: Record "HRM-Leave Ledger";
                dates: Record Date;
                HRMLeaveTypes: Record "HRM-Leave Types";
                HRMPostedLeaves: Record 61125;

            begin
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Leave Balance" := Emp."Leave Balance";
                    "Leave No" := Emp."Current Leave No";
                    Validate("Leave No");
                end;


            end;
        }
        field(4; "Employee Name"; Text[100])
        {
        }

        field(5; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Applied Days"; Decimal)
        {

        }
        field(8; "Starting Date"; Date)
        {

        }
        field(9; "End Date"; Date)
        {
        }
        field(10; Purpose; Text[200])
        {
        }
        field(11; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code;
        }
        field(12; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(15; "User ID"; Code[30])
        {

        }

        field(17; Posted; Boolean)
        {
        }
        field(18; "Posted By"; Code[20])
        {
        }
        field(19; "Posting Date"; Date)
        {
        }
        field(20; "Process Leave Allowance"; Boolean)
        {
        }
        field(21; "Available Days"; Decimal)
        {
            Editable = false;
            CalcFormula = Sum("HRM-Leave Ledger"."No. of Days" WHERE("Employee No" = FIELD("Employee No")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(22; "Return Date"; Date)
        {
        }
        field(23; "Reliever No."; Code[30])
        {

        }
        field(24; "Reliever Name"; Text[250])
        {
        }
        field(25; "Leave No"; Code[10])
        {
            trigger OnValidate()

            var
                lastNo: Integer;
                GenLedgerSetup: Record "HRM-Setup";
                //RespCenter: Record "FIN-Responsibility Center BR";
                UserMgt: Codeunit "User Setup Management";
                Dimval: Record "Dimension Value";
                Text001: Label 'Your identification is set up to process from %1 %2 only.';
                Emp3: Record "HRM-Employee (D)";
                Emp: Record "HRM-Employee (D)";
                "Employee Leaves": Record "HRM-Emp. Leaves";
                BaseCalendar: Record "Base Calendar Change";
                CurDate: Date;
                LeaveTypes: Record "HRM-Leave Types";
                DayApp: Decimal;
                NoSeriesMgt: Codeunit NoSeriesManagement;
                EndDate: Date;
                BeginDate: Date;
                NextDate: Date;
                varDaysApplied: Integer;
                fDays: Integer;
                ReturnDateLoop: Boolean;
                Employee: Record "HRM-Employee (D)";
                fEmpNo: Code[30];
                EmpLeaveApps: Record "HRM-Leave Requisition";
                GeneralOptions: Record "HRM-Setup";
                "HR Set Up": Record "HRM-Human Resources Setup.";
                Levels: Integer;
                LEmployee: Record "HRM-Employee (D)";
                CurrYear: Integer;
                CYSDate: Date;
                CYEDate: Date;
                CurrYearValue: Integer;
                Number: Integer;
                SMTP: Codeunit "Email Message";// replaced "SMTP Mail"
                Names: Text[100];
                objPeriod: Record "PRL-Payroll Periods";
                PayPeriod: Date;
                CurrYearValue2: Integer;
                prCodes: Record "PRL-Transaction Codes";
                prTrans: Record "PRL-Employee Transactions";
                //todo   Payroll: Record "PRL-Salary Card";
                Grd: Code[10];
                hrSetup: Record "HRM-Setup";
                mContent: Text[100];
                mSubject: Text[100];
                nonworking: Decimal;
                CurrDate: Date;
                NONWORKINDAYS: Integer;
                Users2: Record User;
                usersetup: Record "User Setup";
                leaveLedgers: Record "HRM-Leave Ledger";
                dates: Record Date;
                HRMLeaveTypes: Record "HRM-Leave Types";
                HRMPostedLeaves: Record 61125;

            begin
                if HRMPostedLeaves.Get("Leave No") then begin
                    "Leave Type" := HRMPostedLeaves."Leave Type";
                    "Reliever No." := HRMPostedLeaves."Reliever No.";
                    "End Date" := HRMPostedLeaves."End Date";
                    "Starting Date" := HRMPostedLeaves."Starting Date";
                    "Applied Days" := HRMPostedLeaves."Applied Days";
                    "Campus Code" := HRMPostedLeaves."Campus Code";
                    "Department Code" := HRMPostedLeaves."Department Code";
                    "Return Date" := HRMPostedLeaves."Return Date";
                    "Posted By" := HRMPostedLeaves."Posted By";
                    "Posting Date" := HRMPostedLeaves."Posting Date";


                end;


            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    var
        lastNo: Integer;
        GenLedgerSetup: Record "HRM-Setup";
        //RespCenter: Record "FIN-Responsibility Center BR";
        UserMgt: Codeunit "User Setup Management";
        Dimval: Record "Dimension Value";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Emp3: Record "HRM-Employee (D)";
        Emp: Record "HRM-Employee (D)";
        "Employee Leaves": Record "HRM-Emp. Leaves";
        BaseCalendar: Record "Base Calendar Change";
        CurDate: Date;
        LeaveTypes: Record "HRM-Leave Types";
        DayApp: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EndDate: Date;
        BeginDate: Date;
        NextDate: Date;
        varDaysApplied: Integer;
        fDays: Integer;
        ReturnDateLoop: Boolean;
        Employee: Record "HRM-Employee (D)";
        fEmpNo: Code[30];
        EmpLeaveApps: Record "HRM-Leave Requisition";
        GeneralOptions: Record "HRM-Setup";
        "HR Set Up": Record "HRM-Human Resources Setup.";
        Levels: Integer;
        LEmployee: Record "HRM-Employee (D)";
        CurrYear: Integer;
        CYSDate: Date;
        CYEDate: Date;
        CurrYearValue: Integer;
        Number: Integer;
        SMTP: Codeunit "Email Message";// replaced "SMTP Mail"
        Names: Text[100];
        objPeriod: Record "PRL-Payroll Periods";
        PayPeriod: Date;
        CurrYearValue2: Integer;
        prCodes: Record "PRL-Transaction Codes";
        prTrans: Record "PRL-Employee Transactions";
        //todo   Payroll: Record "PRL-Salary Card";
        Grd: Code[10];
        hrSetup: Record "HRM-Setup";
        mContent: Text[100];
        mSubject: Text[100];
        nonworking: Decimal;
        CurrDate: Date;
        NONWORKINDAYS: Integer;
        Users2: Record User;
        usersetup: Record "User Setup";
        leaveLedgers: Record "HRM-Leave Ledger";
        dates: Record Date;
        HRMLeaveTypes: Record "HRM-Leave Types";
        HRMPostedLeaves: Record 61125;
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Back To Office Nos.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Back To Office Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Date := Today;
    end;

    //if usersetup.Get(UserId) then begin;
    /* if usersetup."Staff No" = '' then
        Error('You are not authorized to use the leave application page. Please consult the system administrator.');
    if Employee.Get(CopyStr(usersetup."Staff No", 4, ((StrLen(usersetup."Staff No")) - 3))) then begin
        "Employee No" := Employee."No.";
        Validate("Employee No");
        "Campus Code" := usersetup."Global Dimension 1 Code";
        "Department Code" := usersetup."Global Dimension 2 Code";
        Date := Today;
    end;
end; */
    //end;





}

