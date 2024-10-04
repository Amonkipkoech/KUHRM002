page 68085 "PRL-Salary Arrears (C)"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "PRL-Salary Arrears";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Salary Arrears"; Rec."Salary Arrears")
                {
                    ApplicationArea = All;
                }
                field("PAYE Arrears"; Rec."PAYE Arrears")
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Current Basic"; Rec."Current Basic")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

