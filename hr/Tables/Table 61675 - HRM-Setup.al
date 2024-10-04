table 61675 "HRM-Setup"
{
    Caption = 'Human Resources Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Employee Nos."; Code[10])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            var
                ResUnitOfMeasure: Record "Resource Unit of Measure";
                ResLedgEnty: Record "Res. Ledger Entry";
            begin
                if "Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
                    if EmployeeAbsence.Find('-') then
                        Error(Text001, FieldCaption("Base Unit of Measure"), EmployeeAbsence.TableCaption);
                end;

                HumanResUnitOfMeasure.Get("Base Unit of Measure");
                ResUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
                ResUnitOfMeasure.TestField("Related to Base Unit of Meas.");
            end;
        }
        field(4; "Leave Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(5; "Recruitment Needs Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Disciplinary Cases Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Applicants Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50000; "Tax Table"; Code[10])
        {
        }
        field(50001; "Corporation Tax"; Decimal)
        {
        }
        field(50002; "Housing Earned Limit"; Decimal)
        {
        }
        field(50003; "Pension Limit Percentage"; Decimal)
        {
        }
        field(50004; "Pension Limit Amount"; Decimal)
        {
        }
        field(50005; "Round Down"; Boolean)
        {
        }
        field(50006; "Working Hours"; Decimal)
        {
        }
        field(50008; "Payroll Rounding Precision"; Decimal)
        {
        }
        field(50009; "Payroll Rounding Type"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(50010; "Special Duty Table"; Code[10])
        {
        }
        field(50011; "CFW Round Deduction code"; Code[20])
        {
        }
        field(50012; "BFW Round Earning code"; Code[20])
        {
        }
        field(50013; "Company overtime hours"; Decimal)
        {
        }
        field(50014; "Tax Relief Amount"; Decimal)
        {
        }
        field(50015; "Posting Group"; Code[20])
        {
        }
        field(50016; "General Payslip Message"; Text[100])
        {
        }
        field(50017; "Overtime Indicator"; Decimal)
        {
        }
        field(50018; "Bank Charges"; Decimal)
        {
        }
        field(50019; "Batch File Path"; Text[250])
        {
        }
        field(50020; "Incoming Mail Server"; Text[30])
        {
        }
        field(50021; "Outgoing Mail Server"; Text[30])
        {
        }
        field(50022; "Email Text"; Text[250])
        {
        }
        field(50023; "Sender User ID"; Text[30])
        {
        }
        field(50024; "Sender Address"; Text[100])
        {
        }
        field(50025; "Email Subject"; Text[100])
        {
        }
        field(50026; "Template Location"; Text[100])
        {
        }
        field(50027; CopyTo; Text[100])
        {
        }
        field(50028; "Delay Time"; Integer)
        {
        }
        field(50029; BatchNo; Code[10])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
        }
        field(50030; "HR Admin Address"; Text[150])
        {
        }
        field(50031; "Base Calendar"; Code[10])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(50032; "Normal Leave Aprroval Levels"; Integer)
        {
        }
        field(50033; "Manager Leave Approval Levels"; Integer)
        {
        }
        field(50034; "Job ID"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50035; "Last Application No"; Integer)
        {
        }
        field(50036; "Active Loans Manager"; Code[30])
        {
        }
        field(50037; "Active Loans Director"; Code[30])
        {
        }
        field(50038; "Appraisal Manager"; Code[30])
        {
        }
        field(50039; "Low Intrest Loan Rate"; Decimal)
        {
        }
        field(50040; "First Payroll Aprroval"; Code[30])
        {
            //todo TableRelation = Table2000000002.Field1;
        }
        field(50041; "Second Payroll Aprroval"; Code[30])
        {
            TableRelation = User."User Name";
        }
        field(50042; "Payroll Approved"; Boolean)
        {
        }
        field(50043; "Payroll Control Accont"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50044; "Payroll Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50045; "Payroll Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Payroll Journal Template"));
        }
        field(50046; "Sal.Increament"; Decimal)
        {
        }
        field(50050; "Training Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50055; "Transport Req Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50056; "Employee Requisition Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50057; "Leave Posting Period[FROM]"; Date)
        {
        }
        field(50058; "Leave Posting Period[TO]"; Date)
        {
        }
        field(50059; "Job Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50060; "Exit Interview Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50061; "Appraisal Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50062; "Company Activities"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50067; "Induction Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50068; "Medical Claims Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50069; "Medical Scheme Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50070; "Days To Retirement"; DateFormula)
        {
        }
        field(50071; "Retirement Age"; Decimal)
        {
        }
        field(50072; "Back To Office Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50073; "TNA Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50074; "Pension Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50075; "Disabled Retirement Age"; Decimal)
        {
        }
        field(50076; "Total Females"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Female)));
            FieldClass = FlowField;
        }
        field(50077; "Total Males"; Integer)
        {
            CalcFormula = Count("HRM-Employee (D)" WHERE(Gender = FILTER(Male)));
            FieldClass = FlowField;
        }
        field(50078; "Staff Clearance"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50079; "HR Interview"; Date)
        {

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeAbsence: Record "Employee Absence";
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        Text001: Label 'You cannot change %1 because there are %2.';
}

