page 68069 "PRL-Employee Posting Group"
{
    PageType = Worksheet;
    SourceTable = "PRL-Employee Posting Group";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ApplicationArea = all;
                }
                field("Income Tax Account"; Rec."Income Tax Account")
                {
                    ApplicationArea = all;
                }
                field("NSSF Employer Account"; Rec."NSSF Employer Account")
                {
                    ApplicationArea = all;
                }
                field("NSSF Employee Account"; Rec."NSSF Employee Account")
                {
                    ApplicationArea = all;
                }
                field("NSSF Payable Acc"; Rec."NSSF Payable Acc")
                {
                    ApplicationArea = all;
                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                    ApplicationArea = all;
                }
                field("Operating Overtime"; Rec."Operating Overtime")
                {
                    ApplicationArea = all;
                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {
                    ApplicationArea = all;
                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                    ApplicationArea = all;
                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                    ApplicationArea = all;
                }
                field("Pension Payable Acc"; Rec."Pension Payable Acc")
                {
                    ApplicationArea = all;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = all;
                }
                field("NHIF Employee Account"; Rec."NHIF Employee Account")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

