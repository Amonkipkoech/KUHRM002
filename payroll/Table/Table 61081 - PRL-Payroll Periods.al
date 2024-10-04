table 61081 "PRL-Payroll Periods"
{
    DrillDownPageID = "PRL-Payroll Periods List";
    LookupPageID = "PRL-Payroll Periods List";

    fields
    {
        field(1; "Period Month"; Integer)
        {
            NotBlank = true;
        }
        field(2; "Period Year"; Integer)
        {
            NotBlank = true;
        }
        field(3; "Period Name"; Text[30])
        {
            Description = 'e.g November 2009';
            NotBlank = true;
        }
        field(4; "Date Opened"; Date)
        {
            NotBlank = true;
        }
        field(5; "Date Closed"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
            Description = 'A period is either closed or open';

            trigger OnValidate()
            begin
                //IF NOT "Approved For Closure" THEN ERROR('The Payroll Has not been Approved for closure.');
            end;
        }
        field(7; "Payroll Code"; Code[20])
        {
            TableRelation = "PRL-Payroll Type";
        }
        field(8; "Tax Paid"; Decimal)
        {
            CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Payroll Period" = FIELD("Date Opened"),
                                                                      "Group Order" = CONST(7),
                                                                      "Sub Group Order" = CONST(3)));
            FieldClass = FlowField;
        }
        field(9; "Payslip Message"; Text[250])
        {
        }
        field(10; "Allow View of Online Payslips"; Boolean)
        {

            trigger OnValidate()
            begin
                //IF NOT "Approved For Closure" THEN ERROR('The Payroll Has not been Approved for closure.');
            end;
        }
        field(11; "Approved For Closure"; Boolean)
        {
        }
        field(12; "Approved By"; Code[20])
        {
        }
        field(13; "Approved Date"; Date)
        {
        }
        field(14; "Approved Time"; Time)
        {
        }
        field(15; "Approval Comments"; Text[250])
        {
        }
        field(16; "Casual Daily Rate"; Decimal)
        {
        }
        field(17; Status; Option)

        {
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        }
        field(18; Period; code[20])
        {
            
        }
    }

    keys
    {
        key(Key1; "Date Opened", "Payroll Code", "Date Closed")
        {
        }
    }

    fieldgroups
    {
    }

    procedure ApprovePayroll() Approves: Boolean
    var
        usersetup: Record "User Setup";
    begin
        Approves := false;
        if usersetup.Get(UserId) then begin
            //if usersetup."Approve Payroll Closure" then Approves := true;
        end;
    end;
}

