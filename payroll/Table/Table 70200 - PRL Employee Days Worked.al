table 70200 "PRL Employee Days Worked"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec."Employee Code" <> '' then begin
                    HRMEmployee.Reset;
                    HRMEmployee.SetRange(HRMEmployee."No.", Rec."Employee Code");
                    if HRMEmployee.Find('-') then begin
                        Rec."F.  Name" := HRMEmployee."First Name" + ' ' + HRMEmployee."Middle Name" + ' ' + HRMEmployee."Last Name";
                    end;
                end;
            end;
        }
        field(2; "F.  Name"; Text[50])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."First Name" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(3; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Casual Payroll Periods"."Date Openned";

            trigger OnValidate()
            begin
                if "Payroll Period" <> 0D then begin
                    "Period Month" := Date2DMY("Payroll Period", 2);
            "Period Year" := Date2DMY("Payroll Period", 3);
                end;
            end;
        }
        field(4; "Days Worked"; Decimal)
        {

            trigger OnValidate()
            begin

                if "Payroll Period" <> 0D then begin
                    if Rec."Employee Code" <> '' then begin
                        HRMEmployee.Reset;
                        HRMEmployee.SetRange(HRMEmployee."No.", Rec."Employee Code");
                        if HRMEmployee.Find('-') then begin
                            if HRMEmployee."Employee Category" = 'CASUALS' then begin
                                CasualsAttendanceLedger.Reset;
                                CasualsAttendanceLedger.SetRange("Staff No.", "Employee Code");
                                CasualsAttendanceLedger.SetRange("Payroll Month", "Period Month");
                                CasualsAttendanceLedger.SetRange("Payroll Year", "Period Year");
                                if CasualsAttendanceLedger.Find('-') then begin
                                    "Computed Days" := CasualsAttendanceLedger.Count;
                                end;
                            end else begin
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(5; "Computed Days"; Integer)
        {
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
        {
        }
        field(8; "Current Instalment"; Integer)
        {
        }
        field(9; "Daily Rate"; Decimal)
        {
        }
        field(10; "M. Name"; Text[50])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Middle Name" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(11; "L. Name"; Text[50])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Last Name" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period", "Current Instalment")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRMEmployee: Record "HRM-Employee (D)";
        CasualsAttendanceLedger: Record "Casuals Attendance Ledger";
        StaffAttendanceLedger: Record "Staff Attendance Ledger";
        Dates: Record Date;
}

