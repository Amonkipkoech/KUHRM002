table 62220 "HRM-Time Register"
{

    fields
    {
        field(1; "Registration Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Absence Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Shift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "From Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Period Month" := DATE2DMY("From Date", 2);
                "Period Year" := DATE2DMY("From Date", 3);
                PRLPayrollPeriods.RESET;
                PRLPayrollPeriods.SETRANGE("Period Month", "Period Month");
                PRLPayrollPeriods.SETRANGE("Period Year", "Period Year");
                IF PRLPayrollPeriods.FIND('-') THEN BEGIN
                    "Payment Period" := PRLPayrollPeriods."Date Opened";
                END ELSE BEGIN
                    // Set to the start of the month
                    PRLPayrollPeriods.RESET;
                    PRLPayrollPeriods.SETRANGE(Closed, FALSE);
                    IF PRLPayrollPeriods.FIND('-') THEN BEGIN
                        "Payment Period" := PRLPayrollPeriods."Date Opened";
                    END;
                END;
            end;
        }
        field(6; "Day Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Time Clocked In"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "From Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Time Clocked Out"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "To Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Charge Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Pending Off"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Unit of Measure Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Day/Hour"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Day,Hour';
            OptionMembers = " ",Day,Hour;
        }
        field(17; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending,Released,Posted';
            OptionMembers = New,Pending,Released,Posted;
        }
        field(18; "Dept Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Crop Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Production Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date/Time Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Date/Time Last Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Date/Time Approved"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Opened By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Date/Time Opened"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Over Time"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Lost Time"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Comment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Payment Period"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Time Clocked In", "Time Clocked Out", "From Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PRLPayrollPeriods: Record 61081;
}

