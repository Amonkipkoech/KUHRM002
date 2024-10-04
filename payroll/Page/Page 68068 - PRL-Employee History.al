page 68068 "PRL-Employee History"
{
    PageType = List;
    SourceTable = "PRL-Employee P9 Info";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Allowances; Rec.Allowances)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Deductions; Rec.Deductions)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PAYE; Rec.PAYE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(NSSF; Rec.NSSF)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(NHIF; Rec.NHIF)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

