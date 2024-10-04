table 50073 "Casuals Attendance Ledger"
{

    fields
    {
        field(1; "Visit No."; Code[250])
        {
        }
        field(2; "Staff No."; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));

            trigger OnValidate()
            begin
                StaffLedger.Reset;
                StaffLedger.SetRange(StaffLedger."Staff No.", "Staff No.");
                StaffLedger.SetRange(StaffLedger."Checked Out", false);
                if StaffLedger.Count > 0 then Error('Staff must be checked out first');

                // Pick the details from the Visitor Card
                if StaffCard.Get("Staff No.") then begin
                    "Full Name" := StaffCard."First Name" + ' ' + StaffCard."Middle Name" + ' ' + StaffCard."Last Name";
                    Company := 'VIHIGA DAIRY FARMERS COOPERATIVE SOCIETY';
                    "Phone No." := StaffCard."Cellular Phone Number";
                    Email := StaffCard."Company E-Mail";
                    Category := StaffCard."Employee Category";
                end;
            end;
        }
        field(3; "Full Name"; Text[150])
        {
        }
        field(4; "Phone No."; Code[150])
        {
        }
        field(5; Email; Text[150])
        {

            trigger OnValidate()
            var
                atExists: Boolean;
                CountedXters: Integer;
            begin
                Clear(atExists);
                Clear(CountedXters);
                if Email <> '' then begin
                    repeat
                    begin
                        CountedXters := CountedXters + 1;
                        if (CopyStr(Email, CountedXters, 1)) = '@' then atExists := true;
                    end;
                    until ((CountedXters = StrLen(Email)) or atExists);

                    if atExists = false then Error('Provide a valid email address!');
                end;
            end;
        }
        field(6; Company; Text[150])
        {
        }
        field(7; "Office Station/Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENTS'));
        }
        field(8; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Office Station/Department"),
                                                               "Dimension Code" = FILTER('DEPARTMENTS')));
            FieldClass = FlowField;
        }
        field(9; "Signed in by"; Code[50])
        {
        }
        field(10; "Transaction Date"; Date)
        {

            trigger OnValidate()
            begin
                "Payroll Month" := Date2DMY("Transaction Date", 2);
                "Payroll Year" := Date2DMY("Transaction Date", 3);
            end;
        }
        field(11; "Time In"; Time)
        {
        }
        field(12; "Time Out"; Time)
        {
        }
        field(13; "Signed Out By"; Code[50])
        {
        }
        field(14; "Checked Out"; Boolean)
        {
        }
        field(15; Comment; Text[250])
        {

            trigger OnValidate()
            begin
                "Comment By" := UserId;
            end;
        }
        field(16; "Comment By"; Text[100])
        {
        }
        field(17; Category; Code[20])
        {
            TableRelation = "HRM-Staff Categories"."Category Code";
        }
        field(19; "Payroll Month"; Integer)
        {
        }
        field(20; "Payroll Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Visit No.")
        {
        }
        key(Key2; "Staff No.", "Visit No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        StaffLedger.Reset;
        StaffLedger.SetRange(StaffLedger."Staff No.", '');
        if StaffLedger.Count > 1 then Error('There are some unused records');

        // if "Visit No." = '' then begin
        //     if GenLedgerSet.Get() then
        //         GenLedgerSet.TestField(GenLedgerSet."Casuals  Register Nos");
        //         "Visit No." := NoSeriesMgt.GetNextNo(GenLedgerSet."Casuals  Register Nos", Today, true);
        //     end;
        //     "Transaction Date" := Today;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSet: Record "General Ledger Setup";
        StaffLedger: Record "Casuals Attendance Ledger";
        StaffCard: Record "HRM-Employee (D)";
}

