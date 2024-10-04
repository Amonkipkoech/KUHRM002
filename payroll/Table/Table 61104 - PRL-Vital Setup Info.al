table 61104 "PRL-Vital Setup Info"

{

    fields
    {
        field(1; "Setup Code"; Code[10])
        {
            Description = '[Relief]';
        }
        field(2; "Tax Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(3; "Insurance Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(4; "Max Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(5; "Mortgage Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(6; "Max Pension Contribution"; Decimal)
        {
            Description = '[Pension]';
        }
        field(7; "Tax On Excess Pension"; Decimal)
        {
            Description = '[Pension]';
        }
        field(8; "Loan Market Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(9; "Loan Corporate Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(10; "Taxable Pay (Normal)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(11; "Taxable Pay (Agricultural)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(12; "NHIF Based on"; Option)
        {
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(13; "NSSF Employee Factor"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(14; "NSSF Employer Factor"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(15; "OOI Deduction"; Decimal)
        {
            Description = '[OOI]';
        }
        field(16; "OOI December"; Decimal)
        {
            Description = '[OOI]';
        }
        field(17; "Security Day (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(18; "Security Night (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(19; "Ayah (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(20; "Gardener (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(21; "Security Day (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(22; "Security Night (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(23; "Ayah (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(24; "Gardener (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(25; "Benefit Threshold"; Decimal)
        {
            Description = '[Servant]';
        }
        field(26; "Payslip Message"; Text[100])
        {
        }
        field(27; "Value Posting"; Decimal)
        {
        }
        field(28; "Disabled Tax Limit"; Decimal)
        {
        }
        field(29; "Incremental percentage"; Decimal)
        {
        }
        field(30; "Max. Leave Allowance"; Decimal)
        {
        }
        field(31; "Acting Allowance Percentage"; Decimal)
        {
        }
        field(32; "Acting Allowance Based On"; Option)
        {
            OptionCaption = ' ,Basic Pay,Gross Pay';
            OptionMembers = " ","Basic Pay","Gross Pay";
        }
        field(33; "Acting Allowance Duration"; DateFormula)
        {
        }
        field(34; "Leave Allowance Percentage"; Decimal)
        {
        }
        field(35; "Leave Allowance Based On"; Option)
        {
            OptionMembers = " ","Basic Pay","Gross Pay","Net Pay";
        }
        field(36; "Training Deduction Percentage"; Decimal)
        {
        }
        field(37; "NSSF Based on"; Option)
        {
            Description = '[NSSF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(38; "Based On Hours worked"; Option)
        {
            OptionCaption = ' ,BasedOnWorkedHrs';
            OptionMembers = " ",BasedOnWorkedHrs;

            trigger OnValidate()
            var
                i: Integer;
            begin
                /*HREmp.RESET;
                IF HREmp.FIND('-') THEN
                BEGIN
                    REPEAT
                         i:=i+1;
                        HREmp."Based On Hours worked":="Based On Hours worked";
                        HREmp.VALIDATE(HREmp."Based On Hours worked");
                         HREmp.MODIFY;
                    UNTIL HREmp.NEXT =0;
                    MESSAGE('%1 Employees Payroll will be calculated Based on attendance records',i);
                END;
                */

            end;
        }
        field(39; "Monthly Expected Work Hrs"; Decimal)
        {
        }
        field(40; "Credit Trans. Code"; Code[20])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(41; "1st Overtime Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic,Gross,Basic with Tagged Transactions';
            OptionMembers = Basic,Gross,"Basic with Tagged Transactions";
        }
        field(42; "2nd Overtime Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic,Gross,Basic with Tagged Transactions';
            OptionMembers = Basic,Gross,"Basic with Tagged Transactions";
        }
        field(43; "Lost Hours Based On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic,Gross,Basic with Tagged Transactions';
            OptionMembers = Basic,Gross,"Basic with Tagged Transactions";
        }
        field(45; "1st Overtime Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(47; "Lost Hours Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(48; "2nd Overtime Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(49; "NSSF Employee"; Code[10])
        {
            //DataClassification = ToBeClassified;
            //TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(50; "Apply NHIF Insurance Relief"; Boolean)
        {

        }
        field(51; "NHIF Insurance Relief Limit"; Decimal)
        {

        }
        field(52; "NHIF Insurance Relief %"; Decimal)
        {

        }
        field(53; "House Allowance Code"; Code[30])
        {

        }
    }

    keys
    {
        key(Key1; "Setup Code")
        {
        }
    }

    fieldgroups
    {
    }
}


